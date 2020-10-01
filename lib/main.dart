import 'package:flutter/material.dart';
import 'screens/wrapper.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  final ScreenScaler scaler = new ScreenScaler();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Express',
      theme: ThemeData(
        primaryColor: Color(0xFF56CCF2),
        primaryColorLight: Color(0x7756CCF2),
        scaffoldBackgroundColor: Colors.white,
        accentColor: Color(0xFFE5E5E5),
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.white,
            fontSize: scaler.getTextSize(8.0),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4
          ),
          headline2: TextStyle(
            color: Colors.grey,
            fontSize: scaler.getTextSize(6.5),
            fontWeight: FontWeight.w400,
            letterSpacing: 0.4
          ),
        ),
      ),
      home: Wrapper(),
    );
  }
}