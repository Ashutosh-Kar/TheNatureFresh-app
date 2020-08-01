// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    address: json['address'] as String,
    cart: json['cart'] == null
        ? null
        : Cart.fromJson(json['cart'] as Map<String, dynamic>),
    cgst: (json['cgst'] as num)?.toDouble() ?? 0.0,
    delivery_charge: (json['delivery_charge'] as num)?.toDouble() ?? 50,
    gst: (json['gst'] as num)?.toDouble() ?? 0.0,
    id: json['id'] as String,
    orderStatus: json['orderStatus'] as String ?? 'Confirmed',
    order_date: json['order_date'] as String,
    phone_number: json['phone_number'] as String,
    sgst: (json['sgst'] as num)?.toDouble() ?? 0.0,
    total: (json['total'] as num)?.toDouble() ?? 0.0,
    user_id: json['user_id'] as String,
    orderid: json['orderid'] as String,
  )..order_day = json['order_day'] as String;
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'address': instance.address,
      'cart': instance.cart?.toJson(),
      'cgst': instance.cgst,
      'sgst': instance.sgst,
      'gst': instance.gst,
      'delivery_charge': instance.delivery_charge,
      'id': instance.id,
      'orderStatus': instance.orderStatus,
      'order_date': instance.order_date,
      'order_day': instance.order_day,
      'phone_number': instance.phone_number,
      'total': instance.total,
      'user_id': instance.user_id,
      'orderid': instance.orderid,
    };
