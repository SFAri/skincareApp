import 'package:flutter/material.dart';
import 'package:skincare_app/features/product/views/productdetailpage.dart';
import 'package:skincare_app/utils/formatter/cformatter.dart';

class CProductCard extends StatelessWidget {
  const CProductCard({
    super.key,
    required this.id,
    required this.imageProduct,
    required this.productName,
    required this.productBrand,
    required this.price,
    this.salePrice = '0',
    this.rateStar = 5,
  });

  final String id;
  final double rateStar;
  final String imageProduct, productName, productBrand;
  final String price;
  final String salePrice;

  @override
  Widget build(BuildContext context) {
    // final bool dark = CHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (_) => ProductDetail(id: id),
        //   ),
        // );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Productdetailpage()),
        );
      },
      child: Container(
        width: 170,
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Màu bóng
              spreadRadius: 2, // Kích thước bóng
              blurRadius: 5, // Độ mờ của bóng
              offset: Offset(0, 3), // Vị trí bóng (x, y)
            ),
          ],
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Product image
            Container(
              width: 170,
              // height: 130,
              padding: EdgeInsets.all(0),
              // radius: CSizes.productImageRadius,
              // // backgroundColor: dark ? CColors.dark : CColors.light,
              child: Column(
                children: [
                  Stack(
                    children: [
                      // Image
                      Container(
                        alignment: Alignment.center,
                        width: 160,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Image.network(imageProduct),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ----- PRODUCT DETAIL:
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CProductCardTitle(title: productName, smallSize: false),
                  Text(
                    productBrand,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.green.shade500,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (double.parse(price) * double.parse(salePrice) / 100 > 0)
                    Text(
                      CFormatter.formatMoney(
                        (double.parse(price) -
                                double.parse(price) *
                                    double.parse(salePrice) /
                                    100)
                            .toString(),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  if (double.parse(price) * double.parse(salePrice) / 100 > 0)
                    Text(
                      CFormatter.formatMoney(price),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.grey.shade600,
                        decorationThickness: 1.7,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  if (double.parse(price) * double.parse(salePrice) / 100 == 0)
                    Text(
                      CFormatter.formatMoney(price),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  // Rate and button
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CProductCardTitle extends StatelessWidget {
  const CProductCardTitle({
    super.key,
    required this.title,
    this.smallSize = false,
    this.maxLines = 2,
    this.textAlign = TextAlign.left,
  });

  final String title;
  final bool smallSize;
  final int maxLines;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: smallSize
          ? Theme.of(context).textTheme.labelLarge
          : Theme.of(context).textTheme.titleSmall,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}

class CRoundedContainer extends StatelessWidget {
  const CRoundedContainer({
    super.key,
    this.height,
    this.width,
    this.margin,
    this.padding,
    this.showBorder = false,
    this.radius = 10,
    this.borderColor = Colors.grey,
    this.backgroundColor = Colors.white,
    this.child,
  });

  final double? height, width;
  final double radius;
  final EdgeInsetsGeometry? padding, margin;
  final Color borderColor;
  final Color backgroundColor;
  final Widget? child;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}
