import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/leave/request.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/index.dart';
import 'leavedetails.dart';

class leave extends StatefulWidget {
  static const screenroute = 'leave';
  const leave({super.key});

  @override
  State<leave> createState() => _leaveState();
}

class _leaveState extends State<leave> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('request').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('No tasks found'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    DateTime startdate = (data['start'] as Timestamp).toDate();
                    DateTime enddate = (data['end'] as Timestamp).toDate();

                    if (data['email'] == null ||
                        !isSameDay(startdate, selectedDay)) {
                      return const SizedBox(); // You can return an empty widget or handle this case as per your requirement.
                    }
                    return TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  leavedetails(m: data, d: document.id),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(12.0),
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 204, 101, 178),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: ListTile(
                                title: Text(
                                  data['reason'] ?? '',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Text(
                                    data['email']
                                        .toString()
                                        .substring(0, 2)
                                        .toUpperCase(),
                                    style: const TextStyle(color: Colors.blue),
                                  ),
                                ),
                                // ignore: dead_code
                                subtitle: Column(children: [
                                  Row(children: [
                                    const Icon(Icons.calendar_month),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${startdate.year}/${startdate.month}/${startdate.day}',
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 10),
                                    )
                                  ]),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(children: [
                                    const Icon(Icons.calendar_month),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${enddate.year}/${enddate.month}/${enddate.day}',
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 10),
                                    )
                                  ])
                                ])),
                          ),
                          //        subtitle: Text('${data['separationdate']?.toDate().year}-${data['separationdate']?.toDate().month.toString().padLeft(2, '0')}-${data['separationdate']?.toDate().day.toString().padLeft(2, '0')} ${data['separationdate']?.toDate().hour.toString().padLeft(2, '0')}:${data['separationdate']?.toDate().minute.toString().padLeft(2, '0')}:${data['separationdate']?.toDate().second.toString().padLeft(2, '0')}',style: const TextStyle(color: Colors.white),),
                        ));
                  }).toList(),
                );
                // if(snapshot.hasData && snapshot.data!.docs.isNotEmpty) {               return Center(child: const Text('No tasks found'));
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, 'leaverequest');
        },
        label: const Text('Leave Request'),
      ),
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Apply Leave',
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
