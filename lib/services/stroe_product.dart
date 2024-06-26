

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ebook_website/constants/strings_constants.dart';
import 'package:flutter_ebook_website/models/product_model.dart';

class Store {
  //add product to collection of products on firestore
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

  //get product data from firestore
  Stream<QuerySnapshot> loadProducts() {
    return firestore.collection(kProductsCollection).snapshots();
  }
  //delete product data from firestore

  deletePorduct(documentId) {
    firestore.collection(kProductsCollection).doc(documentId).delete();
  }
  //edit product data from firestore
  editProduct(data,documentId){
    firestore.collection(kProductsCollection).doc(documentId).update(data);
  }
}
