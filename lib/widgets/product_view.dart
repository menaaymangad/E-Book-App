import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ebook_website/pages/customer_pages/product_info.dart';

import '../functions.dart';
import '../models/product_model.dart';
import '../pages/admin_panel/edit_product_page.dart';
import '../services/stroe_product.dart';

List<ProductModel> _products = [];
final store = Store();
Widget getProductItems(String category) {
  return StreamBuilder<QuerySnapshot>(
    stream: store.loadProducts(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        List<ProductModel> products = [];
        for (var doc in snapshot.data!.docs) {
          products.add(ProductModel.fromFirestore(doc));
        }
        _products = [...products];
        products.clear();
        products = getProductByCategory(category, _products);

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTapUp: (details) {
                double dx = details.globalPosition.dx;
                double dy = details.globalPosition.dy;
                double dr = MediaQuery.of(context).size.width - dx;
                double db = MediaQuery.of(context).size.width - dy;
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(dx, dy, dr, db),
                  items: [
                    PopupMenuItem(
                      onTap: () {
                        Navigator.pushNamed(context, EditProductPage.id,
                            arguments: products[index]);
                      },
                      child: const Text('Edit'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        store.deletePorduct(products[index].productId);
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                );
              },
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductInfo.id,arguments: products[index]);
                },
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image(
                        image: AssetImage(
                          products[index].productLocation,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Opacity(
                        opacity: .6,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                products[index].productName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                products[index].productPrice,
                                style: const TextStyle(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          itemCount: products.length,
        );
      } else {
        return const Text('Loading...');
      }
    },
  );
}
