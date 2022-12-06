import 'package:flutter/material.dart';

// ignore: camel_case_types
class comment extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;

  const comment({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Color.fromARGB(255, 206, 206, 206), width: 1))),
      child: Row(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage(
                  data["img"],
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data["name"],
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                child: Text(data["date"]),
              ),
              Text(
                data["comment"],
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w100,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
