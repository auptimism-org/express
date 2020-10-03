import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: must_be_immutable
class ForgotPasswordScreen extends StatelessWidget {
  TextEditingController editController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler();
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xff2f2ea6),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.chevron_left),
                    color: Color(0xffffffff),
                    iconSize: scaler.getWidth(3.0),
                  ),
                  Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Montserrat',
                      fontSize: scaler.getTextSize(8.5),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        style: TextStyle(fontFamily: 'Montserrat'),
                        controller: editController,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                          hintText: 'Enter email to reset password',
                          hintStyle: TextStyle(
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: scaler.getHeight(1.0),
                    ),
                    RaisedButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          'Reset password',
                          style: TextStyle(
                              fontFamily: 'Montserrat', color: Colors.white),
                        ),
                        color: Theme.of(context).primaryColorLight,
                        onPressed: () {
                          resetPassword(context);
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void resetPassword(BuildContext context) async {
    if (editController.text.length == 0 || !editController.text.contains("@")) {
      _showAlertDialog(context);
      return;
    }

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: editController.text);
      showAlertDialog(
          context, 'Reset password link has been sent to your email');
    } catch (e) {
      showAlertDialog(
          context, 'There is no user record corresponding to this email!');
    }
  }

  void showAlertDialog(context, msg) {
    ScreenScaler scaler = ScreenScaler();

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(
              'Reset Password',
              style: TextStyle(
                color: Colors.black,
                fontSize: scaler.getTextSize(8.0),
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w800,
              ),
            ),
            content: new Text(
              msg,
              style: TextStyle(
                color: Colors.black,
                fontSize: scaler.getTextSize(7.0),
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  int count = 0;
                  Navigator.of(context).popUntil((_) => count++ >= 2);
                },
                child: Text(
                  'Dismiss',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: scaler.getTextSize(7.5),
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          );
        });
  }

  void _showAlertDialog(context) {
    ScreenScaler scaler = ScreenScaler();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(
              'Reset password',
              style: TextStyle(
                color: Colors.black,
                fontSize: scaler.getTextSize(8.0),
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w800,
              ),
            ),
            content: new Text(
              'Invalid email',
              style: TextStyle(
                color: Colors.black,
                fontSize: scaler.getTextSize(7.0),
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Dismiss',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: scaler.getTextSize(7.5),
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          );
        });
  }
}
