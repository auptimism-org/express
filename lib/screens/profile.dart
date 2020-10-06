import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  final Function signOut;
  // ignore: avoid_init_to_null
  String name = null;

  ProfilePage({this.signOut, this.name});

  @override
  _ProfilePageState createState() => _ProfilePageState(so: signOut);
}

class _ProfilePageState extends State<ProfilePage> {
  _ProfilePageState({this.so});
  FirebaseUser user;
  String userEmail;
  String id;
  final Function so;
  

  _loadUser() async {
    user = await FirebaseAuth.instance.currentUser();
    setState(() {
      userEmail = user.email;
      id = user.uid;
    });
  }

  @override
  void initState() {
    _loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Container(
            margin: EdgeInsets.only(top: 5.0),
            child: Text(
              'Settings',
              style: GoogleFonts.montserrat(
                textStyle: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
        ),
      body: Container(
        margin: EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            Container(
              height: scaler.getHeight(4.0),
              color: Colors.grey[100],
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20.0, right: 10.0),
                    child: Icon(
                      Icons.person_pin,
                      size: scaler.getWidth(5.5),
                      color: Colors.grey[500],
                    ),
                  ),
                  StreamBuilder(
                    stream: Firestore.instance.collection("doctors").snapshots(),
                    builder: (context, snapshot){
                      if(!snapshot.hasData && snapshot.connectionState == ConnectionState.waiting)
                        return Text('');

                      if(widget.name != null)
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: scaler.getWidth(14.0),
                              child: Text(
                                widget.name,
                                style: GoogleFonts.montserrat(
                                  textStyle: Theme.of(context).textTheme.headline4,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: scaler.getWidth(14.0),
                              child: Text(
                                "$userEmail",
                                style: GoogleFonts.montserrat(
                                  textStyle: Theme.of(context).textTheme.overline,
                                ),
                              ),
                            ),
                          ],
                        );

                      for(int i=1; i<snapshot.data.documents.length; i++){
                        var doc = snapshot.data.documents[i];
                        if(doc['patients'].containsKey(id)){
                          var patient = doc['patients'][id];
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: scaler.getWidth(14.0),
                                child: Text(
                                  patient['name'],
                                  style: GoogleFonts.montserrat(
                                    textStyle: Theme.of(context).textTheme.headline4,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: scaler.getWidth(14.0),
                                child: Text(
                                  "$userEmail",
                                  style: GoogleFonts.montserrat(
                                    textStyle: Theme.of(context).textTheme.overline,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      }
                      return Text('');  
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: scaler.getHeight(1.0),
            ),
            ProfileRow(
              scaler: scaler,
              text: 'About Express',
              icon: Icons.info,
            ),
            ProfileRow(
              scaler: scaler,
              text: 'Help',
              icon: Icons.help,
            ),
            ProfileRow(
              scaler: scaler,
              text: 'Follow us',
              icon: Icons.person_add,
            ),
            ProfileRow(
              scaler: scaler,
              text: 'Send Feedback',
              icon: Icons.feedback,
            ),
            SizedBox(
              height: scaler.getHeight(1.0),
            ),
            GestureDetector(
              child: Container(
                height: scaler.getHeight(2.0),
                child: Material(
                  color: Colors.grey[100],
                  child: InkWell(
                    splashColor: Colors.grey[300],
                    onTap: (){
                      so();
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical:10.0, horizontal: 20.0),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left:10.0),
                            child: Icon(
                              Icons.logout,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 25.0,
                          ),
                          Text(
                            'Sign out',
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: scaler.getTextSize(7.0),
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileRow extends StatelessWidget {
  const ProfileRow({
    Key key,
    @required this.text,
    @required this.icon,
    @required this.scaler,
  }) : super(key: key);

  final ScreenScaler scaler;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: scaler.getHeight(2.0),
        child: Material(
          color: Colors.grey[100],
          child: InkWell(
            splashColor: Colors.grey[300],
            onTap: (){
              
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical:10.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left:10.0),
                        child: Icon(
                          icon,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 25.0,
                      ),
                      Text(
                        text,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: scaler.getTextSize(7.0),
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey[400],
                    size: 30.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
