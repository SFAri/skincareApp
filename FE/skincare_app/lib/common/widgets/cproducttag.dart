import 'package:flutter/material.dart';

class CProductTag extends StatelessWidget {
  const CProductTag({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 253, 249, 243),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(name),
    );
  }
}
