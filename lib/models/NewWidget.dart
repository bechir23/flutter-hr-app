// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class NewTask extends StatelessWidget {
  final String name;
  final String press;
  final String ImageUrl;
  const NewTask(
      {super.key,
      required this.name,
      required this.press,
      required this.ImageUrl});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, press);
          },
          child: Stack(
            children: [
              AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        ImageUrl,
                        height: 250,
                        fit: BoxFit.cover,
                      ))),
              Container(
                padding: const EdgeInsets.all(10.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Text(name,
                    style: const TextStyle(fontSize: 30, color: Colors.white)),
              )
            ],
          )),
    );
  }
}
