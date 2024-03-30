import 'package:flutter/material.dart';
import 'package:flutter_ebook_website/services/stroe_product.dart';

import '../../models/product_model.dart';

class EditProductPage extends StatelessWidget {
  EditProductPage({super.key});
  static String id = "EditProductPage";
  final store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ProductModel>>(
          future: store.loadProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return FutureBuilder(
                future: store.loadProducts(),
                builder: ((context, snapshot) => ListView.builder(
                      itemBuilder: (context, index) =>
                          Text(snapshot.data![index].productName),
                      itemCount: snapshot.data!.length,
                    )),
              );
            } else {
              return const Text('Loading...');
            }
          }),
    );
  }
}
