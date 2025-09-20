import 'package:flutter/material.dart';
import 'package:skincare_app/common/widgets/cbutton.dart';
import 'package:skincare_app/common/widgets/ctextformfield.dart';

class CheckPage extends StatelessWidget {
  const CheckPage({super.key});

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
                prefixIcon: Icon(Icons.info)
              ),
              CTextFormField(
                hintText: 'Name of ingredient 2', 
                labelText: 'Ingredient 2', 
                prefixIcon: Icon(Icons.info)
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20,
                  children: [
                    Icon(Icons.check_circle,color: Colors.green, size: 50),
                    Expanded(
                      child: Text(
                        'Combination recommended', 
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 32),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                  'Toutefois, ce n’est que dans les années 1960 que ce texte est devenu courant, lorsque Letraset a révolutionné le secteur de la publicité avec ses feuilles de décalcomanie par transfert. Ces feuilles innovantes permettaient aux concepteurs d’appliquer directement sur leurs maquettes et prototypes des textes lorem ipsum pré-imprimés dans différentes polices et différents formats.'
                )
              ),
              CButton(
                text: 'Find alternative',
                onPress: (){}
              ),
              Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 0),
                  child: GridView.builder(
                    padding: EdgeInsets.all(10),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Two columns
                      crossAxisSpacing: 15.0, // Spacing between columns
                      mainAxisSpacing: 15.0, // Spacing between rows
                      childAspectRatio: 1.0, // Aspect ratio of each item
                      mainAxisExtent: 60,
                    ),
                    itemCount: 9, // Total number of items
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(45, 210, 172, 142),
                          ),
                          child: Text('Niaciamine $index', textAlign: TextAlign.center,),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      )
    );
  }
}
extension StringExtension on String {
  String capitalize() {
     return 
       "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}