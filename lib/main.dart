import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ebook_website/pages/admin_panel/add_product_page.dart';
import 'package:flutter_ebook_website/pages/admin_panel/admin_home_page.dart';
import 'package:flutter_ebook_website/pages/admin_panel/edit_product_page.dart';
import 'package:flutter_ebook_website/pages/admin_panel/manage_product.dart';

import 'package:flutter_ebook_website/pages/customer_pages/home_page.dart';
import 'package:flutter_ebook_website/pages/login_page.dart';
import 'package:flutter_ebook_website/pages/register_page.dart';
import 'package:flutter_ebook_website/provider/admin_model.dart';
import 'package:flutter_ebook_website/provider/modal_hud.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const EBookStore());
}

class EBookStore extends StatelessWidget {
  const EBookStore({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModalHud>(
          create: (context) => ModalHud(),
        ),
        ChangeNotifierProvider<AdminModel>(
          create: (context) => AdminModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginPage.id: (context) => LoginPage(),
          RegisterPage.id: (context) => RegisterPage(),
          HomePage.id: (context) => const HomePage(),
          AdminHomePage.id: (context) => const AdminHomePage(),
          AddProductPage.id: (context) => AddProductPage(),
          ManageProductPage.id: (context) => ManageProductPage(),
          EditProductPage.id:(context) =>  EditProductPage(),
        },
        initialRoute: LoginPage.id,
      ),
    );
  }
}
