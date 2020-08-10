import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mushroomm/models/product.dart';

part 'cart.g.dart';

@JsonSerializable(explicitToJson: true)
class Cart extends ChangeNotifier {
  List<Product> products;
  int itemCount = 0;

  int get countItem => itemCount;

  Cart() : products = List<Product>();

  void addProduct({Product product}) {
    int index = products.indexWhere((element) => element.id == product.id);
    if (index != -1) {
      if (products[index].qty_available > products[index].qty_purchased) {
        products[index].add();
      } else {
        return;
      }
    } else {
      if (product.qty_available > 1) {
        products.add(product);
      }
      else{
        return;
      }
    }
    itemCount = itemCount + 1;
    notifyListeners();
    print(products);
    print('itemCount in Class');
    print('Cart state');
    print(jsonEncode(this));
    print(countItem);
  }

  void removeProduct({Product product}) {
    int index = products.indexWhere((element) => element.id == product.id);
    if (index != null) {
      if (product.qty_purchased > 1) {
        product.remove();
      } else {
        products.removeAt(index);
      }
      --itemCount;
      notifyListeners();
    }
  }

  void clear(){
    products = List<Product>();
    itemCount = 0;
    notifyListeners();
  }

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);
}
