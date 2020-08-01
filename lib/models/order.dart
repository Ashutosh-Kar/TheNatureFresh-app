import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mushroomm/models/cart.dart';

part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  String address;
  Cart cart;
  @JsonKey(defaultValue: 0.0)
  double cgst;

  @JsonKey(defaultValue: 0.0)
  double sgst;

  @JsonKey(defaultValue: 0.0)
  double gst;

  @JsonKey(defaultValue: 50)
  double delivery_charge;

  String id;

  @JsonKey(defaultValue: "Confirmed")
  String orderStatus;

  String order_date;

  String order_day;

  String phone_number;

  @JsonKey(defaultValue: 0.0)
  double total;

  String user_id;

  String orderid;

  Order(
      {this.address,
      this.cart,
      this.cgst,
      this.delivery_charge,
      this.gst,
      this.id,
      this.orderStatus,
      this.order_date,
      this.phone_number,
      this.sgst,
      this.total,
      this.user_id,
      this.orderid});

  Future<bool> uploadOrder() async {
    print(jsonEncode(this));
    try {
      var ref = Firestore.instance.collection('orders').document();
      this
        ..id = ref.documentID
        ..orderStatus = "Confirmed"
        ..order_date = DateTime.now().toIso8601String();
      await ref.setData(this.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
