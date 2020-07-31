import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mushroomm/models/product.dart';

enum LoadingState { Loading, Loaded, Error }

class Products {
  List<Product> productList;
  LoadingState _state;

  LoadingState get state => _state;

  List<Product> get products => productList;

  Products() {
    productList = List<Product>();
    _state = LoadingState.Loading;
  }

  Future<void> getProducts() async {
    var snapshots =
        await Firestore.instance.collection('products').getDocuments();
    snapshots.documents.forEach((element) {
      productList.add(Product.fromJson(element.data));
    });
    _state = LoadingState.Loaded;
    print('got products');
    return;
  }
}
