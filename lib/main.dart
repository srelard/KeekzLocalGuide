import 'package:flutter/material.dart';
import 'package:keekz_local_guide/models/user_data.dart';
import 'package:keekz_local_guide/screens/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:keekz_local_guide/screens/home_screen.dart';
import 'package:keekz_local_guide/screens/inspire_me/inspire_me_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget _getScreenId() {
    return StreamBuilder<auth.User>(
      stream: auth.FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          Provider.of<UserData>(context).currentUserId = snapshot.data.uid;
          return HomeScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserData(),
      child: MaterialApp(
        title: 'Instagram Clone',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryIconTheme: Theme.of(context).primaryIconTheme.copyWith(
                color: Colors.black,
              ),
        ),
        home: _getScreenId(),
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          //SignupScreen.id: (context) => SignupScreen(),
          InspireMeScreen.id: (context) => InspireMeScreen(),
        },
      ),
    );
  }
}
