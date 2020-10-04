import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import '../screens/root_page.dart';
import '../services/authentication.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler();

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: scaler.getHeight(5),
            ),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image(
                    image: AssetImage('assets/images/logo_express.png'),
                    width: scaler.getWidth(5),
                    height: scaler.getHeight(5),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: new Image.asset('assets/images/logo.png'),
                )
              ],
            )),
            SizedBox(
              height: scaler.getHeight(0.2),
            ),
            Container(
              child: Image(
                image: AssetImage('assets/images/painting_vector.png'),
              ),
            ),
            SizedBox(
              height: scaler.getHeight(0.2),
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0)),
              onPressed: () {
                return new RootPage(auth: new Auth());
              },
              child: Text(
                "Get Started",
                style: TextStyle(
                  fontSize: scaler.getTextSize(7),
                ),
              ),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.fromLTRB(130, 13, 130, 13),
            ),
            Container(
              // padding: EdgeInsets.symmetric(vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("Have an account?"),
                  ),
                  FlatButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    textColor: Theme.of(context).primaryColor,
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
