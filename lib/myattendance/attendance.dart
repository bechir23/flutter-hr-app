import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/index.dart';
import 'event.dart';

class attendance extends StatefulWidget {
  static const screenroute = 'attendance';

  @override
  State<attendance> createState() => _attendanceState();
}

class _attendanceState extends State<attendance> {
  //const attendance({super.key});
  Map<DateTime, List<Event>> selectedEvents = {};
  Future<Map<DateTime, List<Event>>> update() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot eventSnapshot = await firestore.collection('events').get();

    Map<DateTime, List<Event>> selectedEvents = {};

    for (QueryDocumentSnapshot eventDoc in eventSnapshot.docs) {
      Map<String, dynamic> eventData = eventDoc.data() as Map<String, dynamic>;
      String? eventName = eventData['event'] as String?;
      Timestamp? eventTime = eventData['time'] as Timestamp?;

      if (eventName != null && eventTime != null) {
        DateTime eventDateTime = eventTime.toDate();
        DateTime onlyDate = DateTime(
            eventDateTime.year, eventDateTime.month, eventDateTime.day);
        Event event = Event(title: eventName);

        if (selectedEvents.containsKey(onlyDate)) {
          selectedEvents[onlyDate]?.add(event);
        } else {
          selectedEvents[onlyDate] = [event];
        }
      }
    }

    return selectedEvents;
  }

  CalendarFormat format = CalendarFormat.month;
  DateTime now = DateTime.now();
  DateTime selectedDay = DateTime.now();

  DateTime focusedDay = DateTime.now();

  final TextEditingController _eventController = TextEditingController();
  Future Delete(String a) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot =
        await firestore.collection('events').where('event', isEqualTo: a).get();

    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      await docSnapshot.reference.delete();
    }
  }

  Future Submit(String a, DateTime b) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('events').add({
      'event': a,
      'time': Timestamp.fromDate(b),
    });
  }

  void _deleteEvent(String eventName) async {
    await Delete(eventName);
    update().then((eventsMap) {
      setState(() {
        selectedEvents = eventsMap;
      });
    });
  }

  Future<void> _addEvent(String eventName) async {
    await Submit(eventName, now);
    Map<DateTime, List<Event>> eventsMap =
        await update(); // Fetch updated data from Firestore
    setState(() {
      selectedEvents = eventsMap;
      _eventController.clear();
    });

    //print(selectedEvents); // Wait for Firestore operation to complete
  }

  @override
  void initState() {
    super.initState();
    _updateSelectedEventsFromFirestore().then((_) {});
  }

  Future<void> _updateSelectedEventsFromFirestore() async {
    Map<DateTime, List<Event>> eventsMap =
        await update(); // Fetch data from Firestore
    setState(() {
      selectedEvents = eventsMap;
    });
  }

  List<Event> _getEventsfromDay(DateTime date) {
    //        print(selectedEvents[date]);

    DateTime dateWithoutTime = DateTime(date.year, date.month, date.day);

    return selectedEvents[dateWithoutTime] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              focusedDay: selectedDay,
              firstDay: DateTime(2022),
              lastDay: DateTime(2040),
              calendarFormat: format,
              onFormatChanged: (CalendarFormat _format) {
                setState(() {
                  format = _format;
                });
              },
              startingDayOfWeek: StartingDayOfWeek.sunday,
              daysOfWeekVisible: true,

              onDaySelected: (DateTime selectDay, DateTime focusDay) {
                setState(() {
                  selectedDay = selectDay;
                  focusedDay = focusDay;
                });
              },
              selectedDayPredicate: (DateTime date) {
                return isSameDay(selectedDay, date);
              },

              eventLoader: _getEventsfromDay,

              //To style the Calendar
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                selectedTextStyle: TextStyle(color: Colors.white),
                todayDecoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                defaultDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                weekendDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: true,
                titleCentered: true,
                formatButtonShowsNext: false,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                formatButtonTextStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _getEventsfromDay(selectedDay).length,
              itemBuilder: (context, index) {
                Event event = _getEventsfromDay(selectedDay)[index];
                return Container(
                  color: Colors.purple,
                  padding: const EdgeInsets.all(12.0),
                  child: ListTile(
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          _deleteEvent(event.title);
                        });
                      },
                      icon: const Icon(Icons.delete),
                    ),
                    title: Text(
                      event.title,
                      textAlign: TextAlign.start,
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (isSameDay(focusedDay, now)) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Add Event"),
                content: TextFormField(
                  controller: _eventController,
                ),
                actions: [
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () => Navigator.pop(context),
                  ),
                  TextButton(
                    child: const Text("Ok"),
                    onPressed: () {
                      if (_eventController.text.isEmpty) {
                      } else {
                        setState(() {
                          _addEvent(_eventController.text);
                        });
                      }

                      Navigator.pop(context);
                      _eventController.clear();
                      setState(() {});
                      return;
                    },
                  ),
                ],
              ),
            );
          }
        },
        label: const Text('Add Event'),
      ),
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'My attendance',
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
          backgroundColor: const Color.fromARGB(255, 223, 130, 161),
          leading: IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                Provider.of<pos>(context, listen: false).index = 0;
                Navigator.pushNamed(context, 'navigation');
              })),
      backgroundColor: const Color.fromARGB(255, 223, 130, 161),
    );
  }
}
