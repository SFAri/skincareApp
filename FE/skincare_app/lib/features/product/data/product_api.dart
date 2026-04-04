import 'package:dio/dio.dart';
import 'package:skincare_app/core/api/api_provider.dart';

class ProductApi {
  final Dio dio = apiClient.dio;

  Future<Response> getProducts(int page) {
    return dio.get("/products", queryParameters: {"page": page, "limit": 10});
  }

  Future<Response> getProduct(String id) {
    return dio.get("/products/$id");
  }

  Future<Response> searchProducts({
    String? keyword,
    int page = 1,
    String sort = 'newest',
    int? minPrice,
    int? maxPrice,
  }) {
    return dio.get(
      "/products/search",
      queryParameters: {
        "q": keyword,
        "page": page,
        "sort": sort,
        "limit": 10,
        "minPrice": minPrice,
        "maxPrice": maxPrice,
      },
    );
  }
}
