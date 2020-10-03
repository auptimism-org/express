import 'package:Express/screens/forgotPassword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatelessWidget {
  Profile({this.so});

  final Function so;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      },
      child: ProfilePage(sOut: so),
    );
  }
}

class ProfilePage extends StatefulWidget {
  ProfilePage({this.sOut});

  final Function sOut;

  @override
  _ProfilePageState createState() => _ProfilePageState(signOut: sOut);
}

class _ProfilePageState extends State<ProfilePage> {
  _ProfilePageState({this.signOut});
  final double mainCurve = 25.0;
  final Function signOut;
  FirebaseUser user;
  String userEmail;

  _loadUser() async {
    user = await FirebaseAuth.instance.currentUser();
    userEmail = user.email;
  }

  @override
  Widget build(BuildContext context) {
    _loadUser();
    ScreenScaler scaler = ScreenScaler();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: FutureBuilder(
        future: Firestore.instance
            .collection('users')
            .where('email', isEqualTo: userEmail)
            .getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.waiting)
            return const Text('');

          return StreamBuilder(
            stream: Firestore.instance
                .collection('users')
                .where('email', isEqualTo: userEmail)
                .getDocuments()
                .asStream(),
            // ignore: missing_return
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState != ConnectionState.waiting) {
                var user = snapshot.data.documents[0];

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 30.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            colors: [
                              Theme.of(context).primaryColorLight,
                              Theme.of(context).primaryColor
                            ]),
                      ),
                      child: SafeArea(
                        child: SizedBox(
                          height: scaler.getHeight(11.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 10.0),
                                child: IconButton(
                                  icon: Icon(Icons.chevron_left),
                                  iconSize: 30.0,
                                  color: Theme.of(context).accentColor,
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(mainCurve),
                              topRight: Radius.circular(mainCurve)),
                          color: Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 25.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 25, 20, 0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Account Settings',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      fontSize: scaler.getTextSize(7.0),
                                    ),
                                  ),
                                  InkWell(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Change password',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w600,
                                            fontSize: scaler.getTextSize(7.5),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.chevron_right),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ForgotPasswordScreen()));
                                          },
                                          iconSize: 25.0,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ],
                                    ),
                                    splashColor: Colors.black,
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ForgotPasswordScreen()));
                                    },
                                  ),
                                  SizedBox(
                                    height: scaler.getHeight(1.5),
                                  ),
                                  Text(
                                    'Support',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      fontSize: scaler.getTextSize(7.0),
                                    ),
                                  ),
                                  InkWell(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'About DesForm',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w600,
                                            fontSize: scaler.getTextSize(7.5),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.chevron_right),
                                          onPressed: () {
                                            _about();
                                          },
                                          iconSize: 25.0,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ],
                                    ),
                                    splashColor: Colors.black,
                                    onTap: () {
                                      _about();
                                    },
                                  ),
                                  InkWell(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Contact Us',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w600,
                                            fontSize: scaler.getTextSize(7.5),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.chevron_right),
                                          onPressed: () {
                                            _contact();
                                          },
                                          iconSize: 25.0,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ],
                                    ),
                                    splashColor: Colors.black,
                                    onTap: () {
                                      _contact();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  'Version 1.0.0',
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w400,
                                    fontSize: scaler.getTextSize(7.0),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: signOut,
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 30.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.exit_to_app),
                                          iconSize: 40.0,
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          onPressed: signOut,
                                        ),
                                        Text(
                                          'Sign Out',
                                          style: TextStyle(
                                              color: Colors.grey[700],
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: -1.0,
                                              fontSize:
                                                  scaler.getTextSize(8.0)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const Text('');
            },
          );
        },
      ),
    );
  }

  _about() async {
    const url = 'https://www.des-form.com/about-us';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _contact() async {
    const url = 'https://www.des-form.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
