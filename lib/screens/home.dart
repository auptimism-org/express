import 'package:Express/screens/login_signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../profilePhoto.dart';
import '../services/authentication.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double mainCurve = 25.0;
  FirebaseUser user;
  String userEmail;

  _loadUser() async {
    user = await FirebaseAuth.instance.currentUser();
    userEmail = user.email;
  }

  @override
  void initState() {
    _loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = new ScreenScaler();

    signOut() async {
      try {
        await widget.auth.signOut();
        widget.logoutCallback();
        Navigator.pop(
            context, CustomNavRoute(builder: (context) => LoginSignupPage()));
      } catch (e) {
        print(e);
      }
    }

    Future<Null> _refresh() async {
      setState(() {});
      return null;
    }

    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(mainCurve),
                    bottomRight: Radius.circular(mainCurve),
                  ),
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Theme.of(context).primaryColorLight,
                      Theme.of(context).primaryColor
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[400],
                      blurRadius: 10.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: SafeArea(
                  child: SizedBox(
                    height: scaler.getHeight(9.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 22.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10.0),
                            child: ProfilePhoto(
                              signOut: signOut,
                            ),
                          ),
                          Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 36.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'DesForm',
                                  style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: scaler.getTextSize(10.6),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 2.0,
                                    ),
                                    Text(
                                      'Live to Create',
                                      style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontSize: scaler.getTextSize(7.0),
                                        fontFamily: 'Montserrat',
                                        letterSpacing: -0.5,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: scaler.getHeight(0.2)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomNavRoute<T> extends MaterialPageRoute<T> {
  CustomNavRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return new SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 1.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }
}
