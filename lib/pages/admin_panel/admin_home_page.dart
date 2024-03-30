import 'package:flutter/material.dart';
import 'package:flutter_ebook_website/pages/admin_panel/add_product_page.dart';
import 'package:flutter_ebook_website/pages/admin_panel/edit_product.dart';
import 'package:flutter_ebook_website/widgets/custom_button.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});
  static String id = 'admin-home-page';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomButton(
            buttonName: 'Add Product',
            function: () {
              Navigator.pushNamed(context, AddProductPage.id);
            },
          ),
          SizedBox(
            height: height * .03,
          ),
          CustomButton(
            buttonName: 'Edit Product',
            function: () {
              Navigator.pushNamed(context, EditProductPage.id);
            },
          ),
          SizedBox(
            height: height * .03,
          ),
          CustomButton(
            buttonName: 'View Orders',
            function: () {},
          ),
        ],
      ),
    );
  }
}
