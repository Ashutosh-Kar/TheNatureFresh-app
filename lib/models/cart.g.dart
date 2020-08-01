// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) {
  return Cart()
    ..products = (json['products'] as List)
        ?.map((e) =>
            e == null ? null : Product.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..itemCount = json['itemCount'] as int;
}

Map<String, dynamic> _$CartToJson(Cart instance) =>
    <String, dynamic>{
      'products': instance.products?.map((e) => e?.toJson())?.toList(),
      'itemCount': instance.itemCount,
    };
