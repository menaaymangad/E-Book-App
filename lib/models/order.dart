class OrderItem {
  String? documentId;
  int? totallPrice;
  String? address;
  OrderItem({this.totallPrice, this.address, this.documentId});
  factory OrderItem.fromMap(Map<String, dynamic> data) {
    return OrderItem(
      documentId: data['documentId'] as String?,
      totallPrice: data['totalPrice'] as int?,
      address: data['address'] as String?,
    );
  }

  // Example toMap method
  Map<String, dynamic> toMap() {
    return {
      'documentId': documentId,
      'totalPrice': totallPrice,
      'address': address,
    };
  }
}