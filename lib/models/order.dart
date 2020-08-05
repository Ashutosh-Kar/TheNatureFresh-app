import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
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

  Map<String, dynamic> order_date;

  String order_day;

  String phone_number;

  @JsonKey(defaultValue: 0.0)
  double total;

  String user_id;

  int orderid;

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
    try {
      var ref = await Firestore.instance.collection('orders').document().get();
      this
        ..id = ref.documentID
        ..orderStatus = "Confirmed"
        ..order_date = {
          "_nanoseconds": Timestamp.now().nanoseconds.toString(),
          "_seconds": Timestamp.now().seconds.toString()
        }
        ..order_day = DateFormat('E M-d-y').format(DateTime.now());
      var documentref =
          Firestore.instance.collection('references').document('orders');
      var document = await documentref.get();
      int orderId = await document.data['orderId'];
      print('Order Id ${orderId}');
      this.orderid = orderId;
      print(jsonEncode(this));
      await Firestore.instance
          .collection('orders')
          .document(this.id)
          .setData(this.toJson());
      await documentref.updateData({'orderId': FieldValue.increment(1)});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}