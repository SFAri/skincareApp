import 'package:skincare_app/features/product/data/product_api.dart';
import 'package:skincare_app/features/product/models/product.dart';

class ProductRepo {
  final ProductApi api = ProductApi();

  Future<List<Product>> getProducts(int page) async {
    final res = await api.getProducts(page);
    final list = res.data["data"] as List;

    return list.map((e) => Product.fromJson(e)).toList();
  }

  Future<Product> getProductById(String id) async {
    final res = await api.getProduct(id);
    print(res.data);
    return Product.fromJson(res.data);
  }

  Future<List<Product>> searchProducts({
    String? keyword,
    int page = 1,
    int? minPrice,
    int? maxPrice,
    String sort = 'newest',
  }) async {
    final res = await api.searchProducts(
      keyword: keyword,
      page: page,
      minPrice: minPrice,
      maxPrice: maxPrice,
      sort: sort,
    );
    final list = res.data["data"] as List;

    return list.map((e) => Product.fromJson(e)).toList();
  }
}
