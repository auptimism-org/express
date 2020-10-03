import 'package:Express/screens/noInternetPage.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'services/authentication.dart';
import 'screens/root_page.dart';
import 'screens/home.dart';

void main() {
  Paint.enableDithering = true;
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primaryColor: Color(0xFF56CCF2),
        primaryColorLight: Color(0x7756CCF2),
        accentColor: Color(0xFFE5E5E5),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: MyApp(),
      routes: {
        '/home': (context) => new Home(),
        '/noInternet': (context) => new NoInternetPage(),
      }));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 4,
        navigateAfterSeconds: AfterSplash(),
        image: new Image.asset('assets/images/logo.png'),
        backgroundColor: Colors.white,
        photoSize: 150.0);
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new RootPage(auth: new Auth());
  }
}
