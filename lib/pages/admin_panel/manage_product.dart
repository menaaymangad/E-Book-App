import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_ebook_website/pages/admin_panel/edit_product_page.dart';

import 'package:flutter_ebook_website/services/stroe_product.dart';


import '../../models/product_model.dart';

class ManageProductPage extends StatelessWidget {
  ManageProductPage({super.key});
  static String id = "ManageProductPage";
  final store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: store.loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ProductModel> products = [];
            for (var doc in snapshot.data!.docs) {
              products.add(ProductModel.fromFirestore(doc));
            }
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
                            Navigator.pushNamed(context, EditProductPage.id,arguments: products[index]);
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
              itemCount: products.length,
            );
          } else {
            return const Text('Loading...');
          }
        },
      ),
    );
  }
}
