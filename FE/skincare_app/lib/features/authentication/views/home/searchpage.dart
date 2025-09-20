import 'package:flutter/material.dart';
import 'package:skincare_app/common/widgets/cproductcard.dart';
import 'package:skincare_app/common/widgets/ctextformfield.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Product'),
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
                hintText: 'Search', 
                labelText: 'Search', 
                prefixIcon: Icon(Icons.search)
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shop',
                    style: TextStyle(
                      fontSize: 22,

                    ),
                  ),
                  TextButton(
                    onPressed: (){}, 
                    child: Text('All')
                  )
                ],
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
          )
        )
      )
    );
  }
}