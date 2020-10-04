import 'package:Express/screens/draw.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/authentication.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PatientHome extends StatefulWidget {
  PatientHome({this.signOut,this.auth,this.logoutCallback});
  
  final Function signOut;
  final BaseAuth auth;
  final VoidCallback logoutCallback;

  @override
  _PatientHomeState createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
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

  _loadUrl(String loc) async {
    var ref = FirebaseStorage.instance.ref().child(loc);
    return (await ref.getDownloadURL()).toString();
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.person_pin,
              ),
              iconSize: scaler.getWidth(2.0),
              color: Colors.black87,
              splashRadius: 20.0,
              onPressed: (){

              },
            ),
            IconButton(
              icon: Icon(
                Icons.person_pin,
              ),
              iconSize: scaler.getWidth(2.0),
              color: Colors.black87,
              splashRadius: 20.0,
              onPressed: (){

              },
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Home',
                  style: GoogleFonts.montserrat(
                    textStyle: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                width: scaler.getWidth(30.0),
                height: scaler.getHeight(30.0),
                child: GridView(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(15.0),
                      child: RaisedButton(
                        onPressed: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => Draw()));
                        },
                        elevation: 5.0,
                        color: Colors.grey[100],
                        child: Icon(
                          Icons.add,
                          color: Colors.grey[500],
                          size: scaler.getWidth(5.0),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                    StreamBuilder(
                      stream: Firestore.instance.collection("doctors").snapshots(),
                      builder: (context, snapshot){
                        if(!snapshot.hasData && snapshot.connectionState == ConnectionState.waiting)
                          return Text('');

                        for(int i=1; i<snapshot.data.documents.length; i++){
                          var doc = snapshot.data.documents[i];
                          if(doc['patients'].containsKey(id)){
                            if(doc['patients'][id]['submitions'].length != 0){
                              var sub = doc['patients'][id]['submitions'];
                              for(int j=0; j<sub.length; j++){
                                for(var k in sub[j].keys){
                                  int l = sub[j][k]['drawingURLs'].length;
                                  return FutureBuilder(
                                    future: _loadUrl(sub[j][k]['drawingURLs'][l-1]),
                                    builder: (context, snapshot){
                                      print(snapshot.data);
                                      return Container(
                                        margin: EdgeInsets.all(15.0),
                                        child: RaisedButton(
                                          elevation: 5.0,
                                          color: Colors.grey[100],
                                          child: Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(snapshot.data),
                                                  fit: BoxFit.fill),
                                            ),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15.0),
                                          ),
                                          onPressed: () {
                                          },
                                        ),
                                      );
                                    },
                                  );
                                }
                              }
                            }
                          }
                          return Text('');
                        }

                        return Text('');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: [
                Material(
                  color: Colors.transparent,
                  child: IconButton(
                    icon: Icon(Icons.camera),
                    onPressed: (){},
                    color: Colors.white,
                    splashRadius: 24.0,
                    splashColor: Colors.white,
                  ),
                ),
                Text(
                  '|',
                  style: TextStyle(color: Colors.white, fontSize: scaler.getTextSize(8.0), fontWeight: FontWeight.w300),
                ),
                Material(
                  color: Colors.transparent,
                  child: IconButton(
                    icon: Icon(Icons.insert_photo),
                    onPressed: (){},
                    color: Colors.white,
                    splashRadius: 24.0,
                    splashColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}