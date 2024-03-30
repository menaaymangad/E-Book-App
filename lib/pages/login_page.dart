import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_ebook_website/pages/admin_panel/admin_home_page.dart';
import 'package:flutter_ebook_website/pages/customer_pages/home_page.dart';
import 'package:flutter_ebook_website/pages/register_page.dart';
import 'package:flutter_ebook_website/provider/admin_model.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../constants/color_constants.dart';
import '../constants/show_snack_bar.dart';
import '../provider/modal_hud.dart';
import '../services/authentication.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  static String id = 'login';

  String? emailAddress;
  String? password;
  String adminPassword = 'Admin1234';

  GlobalKey<FormState> formKey = GlobalKey();
  final bool _passwordVisible = false;
  final auth = Auth();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    final model = Provider.of<ModalHud>(context);
   

    return Scaffold(
      backgroundColor: kMainColor,
      body: Form(
        key: formKey,
        child: ModalProgressHUD(
          inAsyncCall: Provider.of<ModalHud>(context).isLoading,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image(
                      height: MediaQuery.of(context).size.height * .2,
                      image: const AssetImage(
                        'assets/icons/ebook.png',
                      ),
                    ),
                    const Positioned(
                      bottom: 0,
                      child: Text(
                        'E-Book',
                        style: TextStyle(
                          fontFamily: 'Pacifico',
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * .1,
              ),
              CustomTextField(
                prefixIcon: Icons.email,
                function: (data) {
                  emailAddress = data;
                },
                hint: 'Enter your email address',
              ),
              SizedBox(
                height: height * .03,
              ),
              CustomTextField(
                prefixIcon: Icons.lock,
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    model.togglePasswordVisibility();
                  },
                ),
                obsecure: !model.isPasswordVisible,
                function: (data) {
                  password = data;
                },
                hint: 'Enter your password',
              ),
              SizedBox(
                height: height * .05,
              ),
              CustomButton(
                function: () {
                  _validate(context);
                },
                buttonName: 'Login',
              ),
              SizedBox(
                height: height * .05,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RegisterPage.id,
                      );
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Provider.of<AdminModel>(context, listen: false)
                          .changeIsAdmin(true);
                    },
                    child: Text(
                      'I\'m an admin',
                      style: TextStyle(
                        color: Provider.of<AdminModel>(context).isAdmin
                            ? Colors.white
                            : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .1,
                  ),
                  GestureDetector(
                    onTap: () {
                      Provider.of<AdminModel>(context, listen: false)
                          .changeIsAdmin(false);
                    },
                    child: Text(
                      'I\'m a user',
                      style: TextStyle(
                        color: Provider.of<AdminModel>(context).isAdmin
                            ? Colors.black
                            : Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validate(BuildContext context) async {
    final model = Provider.of<ModalHud>(context, listen: false);
    // context.watch<ModalHud>().changeIsLoading(true);
    model.changeIsLoading(true);
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      if (Provider.of<AdminModel>(context, listen: false).isAdmin) {
        if (password == adminPassword) {
          try {
            await auth.loginUser(
                emailAddress: emailAddress!, password: password!);
            model.changeIsLoading(false);
            if (!context.mounted) return;
            Navigator.pushNamed(context, AdminHomePage.id);
          } on FirebaseAuthException catch (e) {
            ShowSnackBar(context, e.message!);
          }
        } else {
          ShowSnackBar(context, 'Your email address or password is invalid');
        }
      } else {
        try {
          await auth.loginUser(
              emailAddress: emailAddress!, password: password!);
          model.changeIsLoading(false);
          if (!context.mounted) return;
          Navigator.pushNamed(context, HomePage.id);
        } on FirebaseAuthException catch (e) {
          ShowSnackBar(context, e.message!);
        }
      }
    }
    model.changeIsLoading(false);
  }
}
