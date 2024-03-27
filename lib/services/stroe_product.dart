import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ebook_website/constants/strings_constants.dart';
import 'package:flutter_ebook_website/models/product_model.dart';

class AddProduct {
  final firestore = FirebaseFirestore.instance;
  addProduct(ProductModel product) {
    firestore.collection(kProductsCollection).add({
      kProductName: product.productName,
      kProductPrice: product.productPrice,
      kProductDescription: product.productDescription,
      kProductCategory: product.productCategory,
      kProductLocation: product.productLocation,
    });
  }
}
