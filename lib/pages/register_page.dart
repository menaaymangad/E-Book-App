import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_ebook_website/pages/customer_pages/home_page.dart';
import 'package:flutter_ebook_website/provider/modal_hud.dart';
import 'package:flutter_ebook_website/services/authentication.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../constants/color_constants.dart';
import '../constants/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  static String id = 'RegisterPage';

  String? emailAddress;
  String? password;
  String? name;

  GlobalKey<FormState> formKey = GlobalKey();

  final auth = Auth();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    final model = Provider.of<ModalHud>(context);
    return Scaffold(
      backgroundColor: kMainColor,
      body: Form(
        key: formKey,
        child: ModalProgressHUD(
          inAsyncCall: model.isLoading,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image(
                      height: height * .2,
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
                hint: 'Enter Your Name',
                function: (data) {
                  name = data;
                },
                prefixIcon: Icons.person,
              ),
              SizedBox(
                height: height * .03,
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
                    model.isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    model.togglePasswordVisibility();
                  },
                ),
                obsecure: model.isPasswordVisible,
                function: (data) {
                  password = data;
                },
                hint: 'Enter your password',
              ),
              SizedBox(
                height: height * .05,
              ),
              CustomButton(
                function: () async {
                  model.changeIsLoading(true);
                  if (formKey.currentState!.validate()) {
                    model.changeIsLoading(false);
                    formKey.currentState?.save();
                    try {
                      final result = await auth.registerUser(
                          emailAddress: emailAddress!, password: password!);
                      debugPrint(result.user?.uid);
                      if (!context.mounted) return;
                      ShowSnackBar(context, 'Success.');

                      model.changeIsLoading(false);
                      Navigator.pushNamed(context, HomePage.id,
                          arguments: emailAddress);
                    } on FirebaseAuthException catch (e) {
                      model.changeIsLoading(false);
                      ShowSnackBar(context, e.code);
                    } catch (e) {
                      if (kDebugMode) {
                        print(e);
                      }
                    }
                  }
                  model.changeIsLoading(false);
                },
                buttonName: 'Register',
              ),
              SizedBox(
                height: height * .05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'You already have an account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
