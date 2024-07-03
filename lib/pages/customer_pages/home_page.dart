import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ebook_website/constants/color_constants.dart';
import 'package:flutter_ebook_website/services/authentication.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String id = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final auth = Auth();
  late User _loggedUser;
  int tabIndex = 0;
  @override
  void initState() {
    getCurrenUser();
  }

  getCurrenUser() async {
    _loggedUser = (await auth.getUser())!;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                indicatorColor: kMainColor,
                onTap: (value) {
                  setState(() {
                    tabIndex = value;
                  });
                },
                tabs: [
                  Text(
                    'Web Development',
                    style: TextStyle(
                      color: tabIndex == 0 ? Colors.black : kSecondaryColor,
                      fontSize: tabIndex == 0 ? 16 : null,
                    ),
                  ),
                  Text(
                    'Android Development',
                    style: TextStyle(
                      color: tabIndex == 0 ? Colors.black : kSecondaryColor,
                      fontSize: tabIndex == 0 ? 16 : null,
                    ),
                  ),
                  Text(
                    'Flutter Development',
                    style: TextStyle(
                      color: tabIndex == 0 ? Colors.black : kSecondaryColor,
                      fontSize: tabIndex == 0 ? 16 : null,
                    ),
                  ),
                  Text(
                    'Backend Development',
                    style: TextStyle(
                      color: tabIndex == 0 ? Colors.black : kSecondaryColor,
                      fontSize: tabIndex == 0 ? 16 : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
