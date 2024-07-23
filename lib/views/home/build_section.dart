import 'package:flutter/material.dart';

Widget buildSection({required String title}) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                width: 120,
                margin:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                color: Colors.red,
              );
            },
          ),
        ),
      ],
    ),
  );
}
