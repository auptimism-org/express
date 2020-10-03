import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../services/authentication.dart';

class DoctorHome extends StatefulWidget {
  DoctorHome({this.signOut,this.auth,this.logoutCallback});
  
  final Function signOut;
  final BaseAuth auth;
  final VoidCallback logoutCallback;

  @override
  _DoctorHomeState createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
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
            child: Container(
              alignment: Alignment.center,
              child: RaisedButton(
                child: Text('me is doc lol'),
                onPressed: (){
                  widget.signOut();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}