import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product extends ChangeNotifier {
  final id;
  final image_url;
  final item_description;
  final item_name;
  final price;

  @JsonKey(defaultValue: 0)
  final qty_available;

  int qty_purchased;

  // ignore: non_constant_identifier_names
  Product(
      {this.id,
      this.image_url,
      this.item_description,
      this.item_name,
      this.price,
      this.qty_available})
      : qty_purchased = 1;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  add() {
    ++qty_purchased;
    notifyListeners();
  }

  remove() {
    --qty_purchased;
    notifyListeners();
  }
}
