import 'package:flutter/material.dart';
import 'package:skincare_app/common/widgets/cbutton.dart';
import 'package:skincare_app/common/widgets/ccard.dart';
import 'package:skincare_app/common/widgets/cproductcard.dart';
import 'package:skincare_app/common/widgets/decorations/clinebetween.dart';
import 'package:skincare_app/common/widgets/text/ctexttitle.dart';
import 'package:skincare_app/features/survey/testpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        automaticallyImplyLeading: false, // Turn off icon back
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.all(10),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              spacing: 10,
              children: [
                CTextTitle(title: 'Skin Tone'),
                Text(
                  'Answer the question below to discover your skin - structure, tone and so on...',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 10,
                    children: [
                      CCard(
                        title: 'Tone',
                        subtitle:
                            'Take this test to see what is your tone of makeup',
                        image:
                            'https://cdn5.vectorstock.com/i/1000x1000/86/19/skin-color-palette-level-icon-vector-33818619.jpg',
                        function: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TestingPage()),
                          );
                        },
                      ),
                      CCard(
                        title: 'Shape',
                        subtitle:
                            'Take this test to see what is your face shape',
                        image:
                            'https://t4.ftcdn.net/jpg/05/11/45/91/360_F_511459113_jY6uaHOEg8HR2mhNGsLPls579fC2rwdI.jpg',
                        function: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TestingPage()),
                          );
                        },
                      ),
                      CCard(
                        title: 'Skin Type',
                        subtitle:
                            'Take this test to see what is your skin type',
                        image:
                            'https://static.vecteezy.com/system/resources/thumbnails/048/313/469/small_2x/for-all-skin-types-icon-linear-logo-mark-in-black-and-white-vector.jpg',
                        function: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TestingPage()),
                          );
                        },
                      ),
                      CCard(
                        title: 'Acne Test',
                        subtitle: 'Take this test to check your acne case',
                        image:
                            'https://cdn-icons-png.freepik.com/512/8023/8023901.png',
                        function: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TestingPage()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                // CButton(
                //   text: 'See all results',
                //   onPress: (){},
                // ),
                CLineBetween(),

                // Routine ++
                CTextTitle(title: 'Suggesting routine'),
                Text(
                  'Answer the question below to discover your skin - structure, tone and so on...',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 500,
                  child: ListView.separated(
                    itemCount: 7,
                    itemBuilder: (BuildContext context, int index) {
                      return Material(
                        color: Color.fromARGB(255, 253, 249, 243),
                        shape: BeveledRectangleBorder(),
                        child: InkWell(
                          onTap: () {
                            print('Tapped on Item ${index + 1}');
                          },
                          child: ListTile(
                            leading: Icon(Icons.sunny), // Leading icon
                            title: Text('Routine ${index + 1}'), // Title text
                            subtitle: Text(
                              'This is a subtitle for routine ${index + 1}',
                            ), // Subtitle text
                            trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.bookmark),
                            ), // Trailing icon
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: Colors.white,
                        height: 8,
                        thickness: 1,
                      ); // A simple horizontal line separator
                    },
                  ),
                ),
                CLineBetween(),

                // Hot Products:
                CTextTitle(title: 'Hot products'),
                Text(
                  'Hot products that are recommended for all type of skins, click for more detail',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 0),
                  child: GridView.builder(
                    padding: EdgeInsets.all(10),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Two columns
                      crossAxisSpacing: 15.0, // Spacing between columns
                      mainAxisSpacing: 15.0, // Spacing between rows
                      childAspectRatio: 1.0, // Aspect ratio of each item
                      mainAxisExtent: 250,
                    ),
                    itemCount: 9, // Total number of items
                    itemBuilder: (BuildContext context, int index) {
                      return CProductCard(
                        id: index.toString(),
                        imageProduct:
                            'https://ordinary.com.vn/wp-content/uploads/2020/09/The-Ordinary-Niacinamide10-Zinc-1.jpg',
                        productName: 'The ordinary niacinamide 10 + zinc 1',
                        productBrand: 'The ordinary',
                        price: '190000',
                        
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}