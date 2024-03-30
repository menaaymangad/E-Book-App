import 'package:flutter/material.dart';
import 'package:flutter_ebook_website/models/product_model.dart';
import 'package:flutter_ebook_website/services/stroe_product.dart';
import 'package:flutter_ebook_website/widgets/custom_button.dart';
import 'package:flutter_ebook_website/widgets/custom_text_field.dart';

// ignore: must_be_immutable
class AddProductPage extends StatelessWidget {
  static String id = 'AddProductPage';
  String? name, description, price, category, location;
  final GlobalKey<FormState> _globalKey = GlobalKey();

  AddProductPage({super.key});
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: SafeArea(
          top: true,
          child: ListView(
            children: [
              CustomTextField(
                hint: 'Product Name',
                function: (value) {
                  name = value;
                },
              ),
              SizedBox(
                height: screenHeight * .03,
              ),
              CustomTextField(
                hint: 'Product Price',
                function: (value) {
                  price = value;
                },
              ),
              SizedBox(
                height: screenHeight * .03,
              ),
              CustomTextField(
                hint: 'Product Description',
                function: (value) {
                  description = value;
                },
              ),
              SizedBox(
                height: screenHeight * .03,
              ),
              CustomTextField(
                hint: 'Product Category',
                function: (value) {
                  category = value;
                },
              ),
              SizedBox(
                height: screenHeight * .03,
              ),
              CustomTextField(
                hint: 'Product Image',
                function: (value) {
                  location = value;
                },
              ),
              SizedBox(
                height: screenHeight * .05,
              ),
              CustomButton(
                buttonName: 'Add Product',
                function: () {
                  if (_globalKey.currentState!.validate()) {
                    _globalKey.currentState?.save();
                    final addProduct = Store();
                    addProduct.addProduct(ProductModel(
                        productName: name!,
                        productDescription: description!,
                        productPrice: price!,
                        productLocation: location!,
                        productCategory: category!));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
