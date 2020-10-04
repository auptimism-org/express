import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/authentication.dart';
// import 'package:firebase_storage/firebase_storage.dart';

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
  String id;

  _loadUser() async {
    user = await FirebaseAuth.instance.currentUser();
    userEmail = user.email;
    id = user.uid;
  }

  @override
  void initState() {
    _loadUser();
    super.initState();
  }

  // _loadUrl(String loc) async {
  //   var ref = FirebaseStorage.instance.ref().child(loc);
  //   return (await ref.getDownloadURL()).toString();
  // }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = new ScreenScaler();

    Future<Null> _refresh() async {
      setState(() {});
      return null;
    }

    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 15),
              child: Image(image: AssetImage('assets/images/logo.png'), fit: BoxFit.contain, height: scaler.getHeight(1.0),)
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: IconButton(
                icon: Icon(
                  Icons.person_pin,
                ),
                iconSize: scaler.getWidth(2.0),
                color: Colors.black87,
                splashRadius: 20.0,
                onPressed: (){
                  widget.signOut();
                },
              ),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 0.0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left:10.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Home',
                    style: GoogleFonts.montserrat(
                      textStyle: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ),
                StreamBuilder(
                  stream: Firestore.instance.collection("doctors").document(id).snapshots(),
                  builder: (context, asyncSnapshot){
                    if(!asyncSnapshot.hasData && asyncSnapshot.connectionState == ConnectionState.waiting)
                      return CircularProgressIndicator();

                    if(asyncSnapshot.hasData){
                      for(var patient in asyncSnapshot.data['patients'].keys){
                        var p = asyncSnapshot.data['patients'][patient];

                        return GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(top:15),
                            width: scaler.getWidth(24.0),
                            height: scaler.getHeight(4.6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[300],
                                  blurRadius: 15.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(
                                    0.0,
                                    0.0, 
                                  ),
                                )
                              ]
                            ),
                            child: Material(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10.0),
                                splashColor: Colors.grey[300],
                                onTap: (){

                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.person_pin,
                                            size: scaler.getWidth(6.5),
                                            color: Colors.grey[500],
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: scaler.getWidth(8.0),
                                                child: Text(
                                                  p['name'],
                                                  style: GoogleFonts.montserrat(
                                                    textStyle: Theme.of(context).textTheme.headline4,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "Date of birth: ${p['dob']}",
                                                style: GoogleFonts.montserrat(
                                                  textStyle: Theme.of(context).textTheme.subtitle2,
                                                ),
                                              ),
                                              SizedBox(
                                                width: scaler.getWidth(10.0),
                                                child: Text(
                                                  "Parent: ${p['parentName']}",
                                                  style: GoogleFonts.montserrat(
                                                    textStyle: Theme.of(context).textTheme.subtitle2,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return Text('');
                    }
                    else{
                      CircularProgressIndicator();
                    }
                    return Text('');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}