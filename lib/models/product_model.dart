import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/strings_constants.dart';

class ProductModel {
  String productName;
  String productDescription;
  String productPrice;
  String productLocation;
  String productCategory;
  String? productId;
  int? productQuantity;
  ProductModel(
      {this.productId,
      required this.productName,
      required this.productDescription,
      required this.productPrice,
      required this.productLocation,
      required this.productCategory, this.productQuantity});
  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return ProductModel(
        productId: doc.id,
        productName: data[kProductName],
        productDescription: data[kProductDescription],
        productPrice: data[kProductPrice],
        productLocation: data[kProductLocation],
        productCategory: data[kProductCategory],
        );
  }
}
