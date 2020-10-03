import 'package:Express/screens/draw.dart';
import 'package:Express/screens/login_signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    // ignore: unused_local_variable
    ScreenScaler scaler = new ScreenScaler();

    signOut() async {
      try {
        await widget.auth.signOut();
        widget.logoutCallback();
        Navigator.pushReplacement(context,
            CupertinoPageRoute(builder: (context) => LoginSignupPage()));
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
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: RaisedButton(
                    child: Text('Sign Out'),
                    onPressed: () {
                      signOut();
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: RaisedButton(
                    child: Text('Draw'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Draw()),
                      );
                    },
                  ),
                )
              ],
            ),
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
