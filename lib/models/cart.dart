import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mushroomm/models/product.dart';

part 'cart.g.dart';

@JsonSerializable(explicitToJson: true)
class Cart extends ChangeNotifier {
  List<Product> products;
  int itemCount = 0;

  Cart() : products = List<Product>();

  Product addProduct({Product product}) {
    int index = products.indexWhere((element) => element.id == product.id);
    print(index);
    if (index != -1) {
      products[index].add();
    } else {
      products.add(product);
    }
    ++itemCount;
    return product;
  }

  Product removeProduct({Product product}) {
    int index = products.indexWhere((element) => element.id == product.id);
    if (index != null) {
      if (product.qty_purchased > 1) {
        product.remove();
      } else {
        products.removeAt(index);
      }
      notifyListeners();
    }
  }

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);
}
