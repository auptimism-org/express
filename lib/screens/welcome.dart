import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/authentication.dart';

class Welcome extends StatelessWidget {
  Welcome({this.auth, this.logoutCallback});

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler();

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: scaler.getHeight(2.0),
            ),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                    width: scaler.getWidth(5),
                    height: scaler.getHeight(5),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15.0),
                  child: Image(
                    image: AssetImage('assets/images/logo_express.png'),
                    width: scaler.getWidth(14.0),
                  ),
                )
              ],
            )),
            Container(
              child: Image(
                image: AssetImage('assets/images/painting_vector.png'),
              ),
            ),
            SizedBox(
              height: scaler.getHeight(0.2),
            ),
            SizedBox(
              width: scaler.getWidth(24.0),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0)),
                onPressed: () {
                  logoutCallback();
                },
                child: Text(
                  "Get Started",
                  style: GoogleFonts.montserrat(
                    textStyle: Theme.of(context).textTheme.headline5,
                  )
                ),
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Container(
              // padding: EdgeInsets.symmetric(vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "Beyond just pixels.",
                      style: GoogleFonts.montserrat(
                        textStyle: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
