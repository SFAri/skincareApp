import 'package:flutter/material.dart';
import 'package:skincare_app/common/widgets/cbutton.dart';
import 'package:skincare_app/common/widgets/cproducttag.dart';
import 'package:skincare_app/common/widgets/text/ctexttitle.dart';
import 'package:skincare_app/features/product/data/product_repo.dart';
import 'package:skincare_app/features/product/models/product.dart';
import 'package:skincare_app/utils/formatter/cformatter.dart';

class Productdetailpage extends StatefulWidget {
  const Productdetailpage({super.key, required this.id});
  final String id;

  @override
  State<Productdetailpage> createState() => _ProductdetailpageState();
}

class _ProductdetailpageState extends State<Productdetailpage> {
  late Product product;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchProduct();
    // print(product.ingredients[0].ingredient!.name);
  }

  Future<void> fetchProduct() async {
    setState(() => isLoading = true);
    final newProduct = await ProductRepo().getProductById(widget.id);
    print(newProduct.ingredients.length);
    // print(newProduct.ingredients[0].ingredient!.name);
    setState(() {
      product = newProduct;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return Center(child: CircularProgressIndicator());
    return Scaffold(
      appBar: AppBar(title: Text('Product detail'), centerTitle: true),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            spacing: 10,
            children: [
              SizedBox(
                height: 300,
                width: 300,
                child: Image.network(
                  // 'https://xachtaynhat.net/wp-content/uploads/2020/07/The-Ordinary-AHA-30-BHA-2-Peeling.jpg',
                  product.imageUrl ??
                      'https://xachtaynhat.net/wp-content/uploads/2020/07/The-Ordinary-AHA-30-BHA-2-Peeling.jpg',
                  fit: BoxFit.contain,
                ),
              ),
              Text(product.name, style: TextStyle(fontSize: 28), textAlign: TextAlign.center,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  Icon(Icons.bookmark_rounded, color: Colors.blueGrey),
                  Text(
                    product.brand ?? 'Brand',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                  ),
                ],
              ),

              // ----------- all tags of ingredients of this product -----------
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                spacing: 15,
                // children: [
                //   CProductTag(name: 'Brightening'),
                //   CProductTag(name: 'Anti-Aging'),
                // ],
                children: product.ingredients.map((e) {
                  final name = e.ingredient?.name ?? '';

                  return CProductTag(name: name);
                }).toList(),
              ),
              // ----------- price of product -----------
              Text(
                CFormatter.formatMoney(product.price.toString()),
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // ----------- description -----------
              CTitleDivider(title: 'Description'),
              // Text(
              //   'AHA 30% (bao gồm Glycolic/Lactic/Tartaric/Citric): Tẩy bỏ lớp tế bào chết cứng đầu, giúp làn da mịn màng, mềm mại hơn.\nBHA 2% (Salicylic Acid): Thấm sâu làm sạch lỗ chân lông, loại bỏ tình trạng tắc nghẽn, mụn đầu đen.\nVitamin B5: Làm trắng da, giúp giảm các vết thâm mụn, làm đều màu da.Chiết xuất thảo dược (Tasmannia Lanceolata Fruit/Leaf Extract): Giúp làm giảm kích ứng trên da khi sử dụng acid liều cao.\nNgoài ra sản phẩm còn chứa các thành phần khác như: Glycolic Acid, Aqua, Arginine, Propanediol, Cocamidopropyl Dimethylamine, Triethanolamine, Salicylic Acid,…',
              // ),
              Column(
                children: product.ingredients.map((e) {
                  final name = e.ingredient?.name ?? '';
                  final description = e.ingredient?.description ?? '';

                  return Text('$name:$description');
                }).toList(),
              ),

              // ----------- usage -----------
              CTitleDivider(title: 'Usage'),
              Text(
                // 'Loại bỏ các tế bào chết sâu dưới da.\nLàm sạch sâu, giúp thông thoáng lỗ chân lông.\nĐẩy mụn ẩn dưới da.\nGiúp da láng mịn, căng bóng khỏe mạnh.\nSe nhỏ lỗ chân lông.\nGiảm mụn, các vết thâm, nám.\nLàm mờ nếp nhăn sau một thời gian sử dụng lâu dài.\nBảo vệ da, ngăn ngừa sự tác động của vi khuẩn.',
                // // textAlign: TextAlign.start,
                product.usage ?? 'description',
              ),

              // ----------- routine step -----------
              CTitleDivider(title: 'Routine step'),
              Text(''),

              // ----------- button -----------
              CButton(text: 'See on Shopee', onPress: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

class CTitleDivider extends StatelessWidget {
  const CTitleDivider({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 30,
      children: [
        Expanded(child: Divider(thickness: 1)),
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Expanded(child: Divider(thickness: 1)),
      ],
    );
  }
}
