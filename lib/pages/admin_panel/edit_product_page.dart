import 'package:flutter/material.dart';
import 'package:flutter_ebook_website/constants/strings_constants.dart';
import 'package:flutter_ebook_website/models/product_model.dart';
import 'package:flutter_ebook_website/services/stroe_product.dart';
import 'package:flutter_ebook_website/widgets/custom_text_field.dart';

import '../../widgets/custom_button.dart';

class EditProductPage extends StatelessWidget {
  EditProductPage({super.key});
  static String id = 'editProductPage';

  String? name, description, price, category, location;
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final Store store = Store();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    ProductModel productModel =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
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
                      store.editProduct((
                        kProductName: name,
                        kProductCategory: category,
                        kProductDescription: description,
                        kProductPrice: price,
                        kProductLocation: location,
                      ), productModel.productId);
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
