import 'package:flutter/material.dart';

class CCard extends StatelessWidget {
  const CCard({
    super.key,
    this.title = '',
    this.subtitle = '',
    this.image = '',
    required this.function,
  });

  final String title;
  final String subtitle;
  final String image;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Container(
        width: 150,
        height: 170,
        padding: EdgeInsets.all(5),
        color: const Color.fromARGB(255, 253, 249, 243),
        child: Column(
          spacing: 3,
          children: [
            Text(title, style: TextStyle(fontSize: 18)),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                overflow: TextOverflow.ellipsis,
                fontStyle: FontStyle.italic,
                color: Colors.grey.shade600,
              ),
              maxLines: 2,
            ),
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(image),
              backgroundColor: Colors.white,
            ),
            ElevatedButton(
              onPressed: function,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 210, 172, 142),
                foregroundColor: Colors.white,
              ),
              child: Text('Do test'),
            ),
          ],
        ),
      ),
    );
  }
}
