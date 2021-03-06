import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keekz_local_guide/models/user_data.dart';
import 'package:keekz_local_guide/screens/activity/activity_screen.dart';
import 'package:keekz_local_guide/screens/create_keekz/create_keekz_screen.dart';
import 'package:keekz_local_guide/screens/inspire_me/inspire_me_screen.dart';
import 'package:keekz_local_guide/screens/map/map_screen.dart';
import 'package:keekz_local_guide/screens/profile/profile_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    final String currentUserId = Provider.of<UserData>(context).currentUserId;
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          InspireMeScreen(currentUserId: currentUserId),
          MapScreen(),
          CreateKeekzScreen(),
          ActivityScreen(currentUserId: currentUserId),
          ProfileScreen(
            currentUserId: currentUserId,
            userId: currentUserId,
          ),
        ],
        onPageChanged: (int index) {
          setState(() {
            _currentTab = index;
          });
        },
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _currentTab,
        onTap: (int index) {
          setState(() {
            _currentTab = index;
          });
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
        },
        activeColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 32.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.map_outlined,
              size: 32.0,
            ),
            label: "Karte",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              size: 32.0,
            ),
            label: "Keekz",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              size: 32.0,
            ),
            label: "Benachrichtigung",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 32.0,
            ),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}
