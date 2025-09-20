import 'package:flutter/material.dart';
import 'package:skincare_app/common/widgets/cbutton.dart';
import 'package:skincare_app/common/widgets/cproducttag.dart';
import 'package:skincare_app/utils/formatter/cformatter.dart';

class Productdetailpage extends StatelessWidget {
  const Productdetailpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product detail'), centerTitle: true),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            spacing: 10,
            children: [
              SizedBox(
                height: 300,
                width: 300,
                child: Image.network(
                  'https://xachtaynhat.net/wp-content/uploads/2020/07/The-Ordinary-AHA-30-BHA-2-Peeling.jpg',
                  fit: BoxFit.contain,
                ),
              ),
          
              // ----------- all tags of usage of this product -----------
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                spacing: 15,
                children: [
                  CProductTag(name: 'Brightening'),
                  CProductTag(name: 'Anti-Aging'),
                ],
              ),
              // ----------- price of product -----------
              Text(
                CFormatter.formatMoney('190000'),
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
          
              // ----------- description -----------
              CTitleDivider(title: 'Description'),
              Text(
                'AHA 30% (bao gồm Glycolic/Lactic/Tartaric/Citric): Tẩy bỏ lớp tế bào chết cứng đầu, giúp làn da mịn màng, mềm mại hơn.\nBHA 2% (Salicylic Acid): Thấm sâu làm sạch lỗ chân lông, loại bỏ tình trạng tắc nghẽn, mụn đầu đen.\nVitamin B5: Làm trắng da, giúp giảm các vết thâm mụn, làm đều màu da.Chiết xuất thảo dược (Tasmannia Lanceolata Fruit/Leaf Extract): Giúp làm giảm kích ứng trên da khi sử dụng acid liều cao.\nNgoài ra sản phẩm còn chứa các thành phần khác như: Glycolic Acid, Aqua, Arginine, Propanediol, Cocamidopropyl Dimethylamine, Triethanolamine, Salicylic Acid,…',
                // textAlign: TextAlign.left,
              ),
          
              // ----------- usage -----------
              CTitleDivider(title: 'Usage'),
              Text(
                'Loại bỏ các tế bào chết sâu dưới da.\nLàm sạch sâu, giúp thông thoáng lỗ chân lông.\nĐẩy mụn ẩn dưới da.\nGiúp da láng mịn, căng bóng khỏe mạnh.\nSe nhỏ lỗ chân lông.\nGiảm mụn, các vết thâm, nám.\nLàm mờ nếp nhăn sau một thời gian sử dụng lâu dài.\nBảo vệ da, ngăn ngừa sự tác động của vi khuẩn.',
                // textAlign: TextAlign.start,
              ),
          
              // ----------- routine step -----------
              CTitleDivider(title: 'Routine step'),
              Text(
                'in the morning', 
                // textAlign: TextAlign.start
              ),
          
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
