
import 'package:flutter/cupertino.dart';
import 'package:flutter_ebook_website/models/product_model.dart';

class CartItem extends ChangeNotifier {
  List<ProductModel> products = [];

  addProduct(ProductModel product) {
    products.add(product);
    notifyListeners();
  }

  deleteProduct(ProductModel product) {
    products.remove(product);
    notifyListeners();
  }
}