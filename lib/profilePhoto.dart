import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'screens/profile.dart';

class ProfilePhoto extends StatelessWidget {
  ProfilePhoto({
    this.signOut,
  });

  final double buttonCurve = 16.0;
  final Function signOut;

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = new ScreenScaler();

    final double size = scaler.getHeight(3);

    return Container(
      margin: EdgeInsets.only(right: 25.0),
      child: ButtonTheme(
        buttonColor: Color.fromARGB(0, 0, 0, 0),
        height: size,
        minWidth: size,
        child: RaisedButton(
          onPressed: () {
            Navigator.of(context).push(_createRoute(signOut));
          },
          padding: EdgeInsets.all(0.0),
          splashColor: Color.fromARGB(30, 200, 200, 200),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonCurve)),
          animationDuration: Duration(milliseconds: 200),
          child: Ink(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/dp.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(buttonCurve),
            ),
            child: Container(
              constraints: BoxConstraints(
                  maxHeight: size,
                  minHeight: size,
                  maxWidth: size,
                  minWidth: size),
              alignment: Alignment.center,
            ),
          ),
        ),
      ),
    );
  }
}

Route _createRoute(Function f) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Profile(
      so: f,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
