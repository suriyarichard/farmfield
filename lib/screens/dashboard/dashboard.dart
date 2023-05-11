import 'package:farmfield/e-commers/pages/home_page.dart';
import 'package:farmfield/e-commers/pages/intro_screen.dart';
import 'package:farmfield/screens/Crop/cropscreen.dart';
import 'package:farmfield/screens/HomeScreen/homeScreen.dart';
import 'package:farmfield/screens/maps/mapScreen.dart';
import 'package:farmfield/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import '../weatherapp/weatherapp.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int currentPage = 0;
  List<Widget> pages = [
    HomeScreen(),
    CropList(),
    MapScreen(),
    Profile(),
    HomePage(),
    // IntroScreen(),
    // Weather()
  ];
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: pages.elementAt(selectedIndex),
        ),
        bottomNavigationBar: Container(
          clipBehavior:
              Clip.hardEdge, //or better look(and cost) using Clip.antiAlias,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(24),
              topLeft: Radius.circular(24),
            ),
          ),
          child: BottomNavigationBar(
            elevation: 0,
            type: BottomNavigationBarType.fixed, // Fixed
            backgroundColor: Colors.white, // <-- This works for fixed
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_work_outlined,
                  size: 25,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.campaign,
                  size: 25,
                ),
                label: 'Market',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.location_pin,
                  size: 25,
                ),
                label: 'Field view',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle,
                  size: 25,
                ),
                label: 'profile',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.cloud,
                    size: 25,
                  ),
                  label: 'Weather'),
            ],
            currentIndex: selectedIndex,
            // fixedColor: Colors.deepPurple,
            onTap: onItemTapped,
          ),
        ));
  }
}
