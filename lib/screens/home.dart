import 'package:Express/screens/doctorHome.dart';
import 'package:Express/screens/loadingScreen.dart';
import 'package:Express/screens/login_signup_page.dart';
import 'package:Express/screens/patientHome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  FirebaseUser user;
  String userEmail;

  _loadUser() async {
    user = await FirebaseAuth.instance.currentUser();
    userEmail = user.email;
  }

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  @override
  Widget build(BuildContext context) {
    signOut() async {
      try {
        await widget.auth.signOut();
        widget.logoutCallback();
        Navigator.pop(
            context,
            CupertinoPageRoute(
                builder: (context) => LoginSignupPage(
                      auth: new Auth(),
                    )));
      } catch (e) {
        print(e);
      }
    }

    Function so = signOut;

    return StreamBuilder(
      stream: Firestore.instance.collection('doctors').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData &&
            snapshot.connectionState == ConnectionState.waiting)
          return LoadingScreen();

        if(snapshot.hasData){
          for (int i = 1; i < snapshot.data.documents.length; i++) {
            if (userEmail.compareTo(snapshot.data.documents[i]['email']) == 0) {
              return DoctorHome(
                signOut: so,
                auth: widget.auth,
                logoutCallback: widget.logoutCallback,
              );
            }
          }
          return PatientHome(
            signOut: so,
            auth: widget.auth,
            logoutCallback: widget.logoutCallback,
          );
        }
        else{
          return LoadingScreen();
        }
        
      },
    );
  }
}
