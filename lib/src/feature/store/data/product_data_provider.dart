import 'package:dio/dio.dart';
import 'package:ln_studio/src/feature/store/model/product.dart';

abstract interface class StoreDataProvider {
  Future<List<Product>> fetchProducts();
}

class StoreDataProviderImpl implements StoreDataProvider {
  StoreDataProviderImpl(Dio restClient) : _restClient = restClient;
  final Dio _restClient;

  @override
  Future<List<Product>> fetchProducts() async {
    final json = await _restClient.get('/api/v1/products/');
    final List<Product> products =
        List.from(json.data['data']).map((e) => Product.fromJson(e)).toList();
    return products;
  }
}
