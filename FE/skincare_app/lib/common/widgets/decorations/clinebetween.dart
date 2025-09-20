import 'package:flutter/material.dart';

class CLineBetween extends StatelessWidget {
  const CLineBetween({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 2,
      width: 300,
      child: Container(
        color: Colors.grey.shade100,
      ),
    );
  }
}