import 'package:flutter/material.dart';
import 'package:skincare_app/common/widgets/cbutton.dart';
import 'package:skincare_app/common/widgets/ctextformfield.dart';
import 'package:skincare_app/core/enums/interaction_level.dart';
import 'package:skincare_app/features/check-interaction/data/check_interaction_repository.dart';
import 'package:skincare_app/features/check-interaction/models/check_result.dart';

class CheckPage extends StatefulWidget {
  const CheckPage({super.key});

  @override
  State<CheckPage> createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  final _ingredient1 = TextEditingController();
  final _ingredient2 = TextEditingController();
  CheckResult? data;

  Future<void> _checkInteraction(String first, String second) async {
    final res = await CheckInteractionRepository().checkInteraction(
      first,
      second,
    );
    setState(() {
      data = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check Ingredient'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            spacing: 10,
            children: [
              CTextFormField(
                hintText: 'Name of ingredient 1',
                labelText: 'Ingredient 1',
                prefixIcon: Icon(Icons.info),
                controller: _ingredient1,
              ),
              CTextFormField(
                hintText: 'Name of ingredient 2',
                labelText: 'Ingredient 2',
                prefixIcon: Icon(Icons.info),
                controller: _ingredient2,
              ),
              CButton(
                text: 'Check interaction',
                onPress: () =>
                    _checkInteraction(_ingredient1.text, _ingredient2.text),
              ),
              if (data != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 20,
                    children: [
                      if (data!.level == InteractionLevel.GOOD)
                        Icon(Icons.check_circle, color: Colors.green, size: 50),
                      if (data!.level == InteractionLevel.WARNING)
                        Icon(Icons.warning, color: Colors.orange, size: 50),
                      if (data!.level == InteractionLevel.AVOID)
                        Icon(Icons.dangerous, color: Colors.red, size: 50),
                      Expanded(
                        child: Text(
                          data!.message,
                          // maxLines: 3,
                          // overflow: TextOverflow,
                          style: TextStyle(fontSize: 30),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
