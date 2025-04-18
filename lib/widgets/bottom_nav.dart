import 'package:flutter/material.dart';
import 'package:group_4_final_project_library_app/views/about_us_page.dart';
import 'package:group_4_final_project_library_app/views/books_page.dart';

class NavigationMenu extends StatefulWidget {
  @override
  NavMenuState createState() => NavMenuState();
}

class NavMenuState extends State<NavigationMenu> {
  int currentPageIndex = 0;

  final List<Widget> pages = [
    BooksPage(),
    AccountPage(),
    AboutUsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Library App"),
      ),
      body: pages[currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPageIndex,
        onTap: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Books',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About Us',
          ),
        ],
      ),
    );
  }
}
