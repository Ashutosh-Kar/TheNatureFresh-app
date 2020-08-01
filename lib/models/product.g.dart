// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'],
    image_url: json['image_url'] as String,
    item_description: json['item_description'] as String,
    item_name: json['item_name'] as String,
    price: (json['price'] as num)?.toDouble(),
    qty_available: json['qty_available'] as int ?? 0,
  )..qty_purchased = json['qty_purchased'] as int ?? 1;
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'image_url': instance.image_url,
      'item_description': instance.item_description,
      'item_name': instance.item_name,
      'price': instance.price,
      'qty_available': instance.qty_available,
      'qty_purchased': instance.qty_purchased,
    };
