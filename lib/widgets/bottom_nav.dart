import 'package:flutter/material.dart';

class NavigationMenu extends StatefulWidget{
  const NavigationMenu({super.key});
  NavMenuState createState(){
    return NavMenuState();
  }
}

class NavMenuState extends State<NavigationMenu>{
  int currentPageIndex =0;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 80,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index)
        {setState(() {
          currentPageIndex = index;
        });},

        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label:'home'),
          NavigationDestination(icon: Icon(Icons.person), label:'account'),
          NavigationDestination(icon: Icon(Icons.info), label:'about us')
        ],
      ),
      body:Container(),
    );
  }
}