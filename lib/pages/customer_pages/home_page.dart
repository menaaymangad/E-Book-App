import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ebook_website/constants/color_constants.dart';
import 'package:flutter_ebook_website/constants/strings_constants.dart';
import 'package:flutter_ebook_website/services/authentication.dart';

import '../../widgets/product_view.dart';

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

  int _bottomTabIndex = 0;

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
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: kMainColor,
              currentIndex: _bottomTabIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                setState(() {
                  _bottomTabIndex = value;
                });
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'test'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'test'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'test'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'test'),
              ],
            ),
            appBar: AppBar(
              title: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('DISCOVER'),
              ),
              actions: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.shopping_cart),
                )
              ],
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
                    kCategoryWeb,
                    style: TextStyle(
                      color: tabIndex == 0 ? Colors.black : kSecondaryColor,
                      fontSize: tabIndex == 0 ? 16 : null,
                    ),
                  ),
                  Text(
                    kCategoryAndroid,
                    style: TextStyle(
                      color: tabIndex == 1 ? Colors.black : kSecondaryColor,
                      fontSize: tabIndex == 1 ? 16 : null,
                    ),
                  ),
                  Text(
                    kCategoryFlutter,
                    style: TextStyle(
                      color: tabIndex == 2 ? Colors.black : kSecondaryColor,
                      fontSize: tabIndex == 2 ? 16 : null,
                    ),
                  ),
                  Text(
                    kCategoryBackend,
                    style: TextStyle(
                      color: tabIndex == 3 ? Colors.black : kSecondaryColor,
                      fontSize: tabIndex == 3 ? 16 : null,
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                getProductItems(kCategoryWeb),
                getProductItems(kCategoryAndroid),
                getProductItems(kCategoryFlutter),
                getProductItems(kCategoryBackend),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
