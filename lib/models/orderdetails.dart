class OrderDetails {
  double packing_charges;
  double delivery_charges;
  double sgst;
  double cgst;
  double gst;
  double subtotal;
  double total;

  OrderDetails(
      {this.packing_charges,
      this.delivery_charges,
      this.sgst,
      this.cgst,
      this.subtotal,
      this.total});
}
