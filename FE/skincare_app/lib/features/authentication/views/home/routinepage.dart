import 'package:flutter/material.dart';

class RoutinePage extends StatelessWidget {
  const RoutinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Routine'), automaticallyImplyLeading: false),
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              // --------- Morning Routine ---------
              Text(
                'Morning',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Column(
                children: [
                  ListTile(
                    leading: Image.asset(
                      'assets/icons/cleanser.png',
                      width: 32,
                      height: 32,
                    ),
                    title: Text('Cleanser'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/icons/serum.png',
                      width: 32,
                      height: 32,
                    ),
                    title: Text('Vitamin C Serum'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/icons/sunscreen.png',
                      width: 32,
                      height: 32,
                    ),
                    title: Text('Suncream'),
                    onTap: () {},
                  ),
                ],
              ),

              // --------- Night Routine ---------
              Text(
                textAlign: TextAlign.start,
                'Night',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Column(
                children: [
                  ListTile(
                    leading: Image.asset(
                      'assets/icons/makeup-remover.png',
                      width: 32,
                      height: 32,
                    ),
                    title: Text('Makeup remove'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/icons/cleanser.png',
                      width: 32,
                      height: 32,
                    ),
                    title: Text('Cleanser'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/icons/retinol.png',
                      width: 32,
                      height: 32,
                    ),
                    title: Text('Retinol'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/icons/moisturizing.png',
                      width: 32,
                      height: 32,
                    ),
                    title: Text('Moisture cream'),
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
