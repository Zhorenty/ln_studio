import 'package:ln_studio/src/feature/store/data/product_data_provider.dart';
import 'package:ln_studio/src/feature/store/model/product.dart';

abstract interface class StoreRepository {
  Future<List<Product>> fetchProducts();
}

class StoreRepositoryImpl implements StoreRepository {
  StoreRepositoryImpl(this._storeDataProvider);

  final StoreDataProvider _storeDataProvider;

  @override
  Future<List<Product>> fetchProducts() => _storeDataProvider.fetchProducts();
}
