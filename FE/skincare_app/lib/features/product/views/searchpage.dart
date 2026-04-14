import 'dart:async';

import 'package:flutter/material.dart';
import 'package:skincare_app/common/widgets/cproductcard.dart';
import 'package:skincare_app/common/widgets/ctextformfield.dart';
import 'package:skincare_app/common/widgets/skeletonCard.dart';
import 'package:skincare_app/features/product/data/product_repo.dart';
import 'package:skincare_app/features/product/models/product.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int page = 1;
  bool isLoadingProduct = false;
  bool hasMore = true;
  List<Product> products = [];
  final ScrollController _scrollController = ScrollController();
  final _searchController = TextEditingController();
  Timer? _debounce;
  String keyword = '';
  int minPrice = 0;
  int maxPrice = 100000000;
  String sort = 'newest';
  @override
  void initState() {
    super.initState();
    fetchProducts();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        fetchProducts();
      }
    });
  }

  Future<void> fetchProducts() async {
    if (isLoadingProduct || !hasMore) return;

    setState(() => isLoadingProduct = true);

    final newProducts = await ProductRepo().searchProducts(
      keyword: keyword,
      sort: sort,
      page: page,
    );

    setState(() {
      page++;
      isLoadingProduct = false;

      if (newProducts.isEmpty) {
        hasMore = false;
      } else {
        products.addAll(newProducts);
      }
    });
  }

  void reloadProducts() {
    page = 1;
    hasMore = true;
    products.clear();
    fetchProducts();
  }

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
        child: ListView(
          controller: _scrollController,
          children: [
            Column(
              spacing: 10,
              children: [
                SizedBox(height: 10),
                CTextFormField(
                  hintText: 'Search',
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  controller: _searchController,
                  onChange: (value) {
                    // debounce ở đây
                    if (_debounce?.isActive ?? false) _debounce!.cancel();

                    _debounce = Timer(const Duration(milliseconds: 500), () {
                      keyword = value;
                      reloadProducts();
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Shop', style: TextStyle(fontSize: 22)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            sort = 'asc';
                            reloadProducts();
                          },
                          child: Icon(Icons.vertical_align_bottom),
                        ),
                        TextButton(
                          onPressed: () {
                            sort = 'desc';
                            reloadProducts();
                          },
                          child: Icon(Icons.vertical_align_top),
                        ),
                        TextButton(
                          onPressed: () {
                            sort = 'newest';
                            reloadProducts();
                          },
                          child: Text('All'),
                        ),
                      ],
                    ),
                  ],
                ),
                if (products.isEmpty) Center(child: Text('No products found')),
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
                    itemCount:
                        products.length +
                        (isLoadingProduct ? 2 : 0), // Total number of items
                    itemBuilder: (BuildContext context, int index) {
                      if (index < products.length) {
                        final product = products[index];
                        return CProductCard(
                          id: product.id,
                          imageProduct:
                              product.imageUrl ??
                              'https://ordinary.com.vn/wp-content/uploads/2020/09/The-Ordinary-Niacinamide10-Zinc-1.jpg',
                          productName: product.name,
                          productBrand: product.brand ?? 'Skinlab',
                          price: (product.price ?? 0).toString(),
                        );
                      }

                      // Skeleton loading:
                      return SkeletonCard();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
