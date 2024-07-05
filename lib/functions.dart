 import 'models/product_model.dart';

List<ProductModel> getProductByCategory(
      String category, List<ProductModel> allproducts) {
    List<ProductModel> products = [];
    try {
      for (var product in allproducts) {
        if (product.productCategory == category) {
          products.add(product);
        }
      }
    } on Error catch (ex) {
      print(ex);
    }
    return products;
  }
