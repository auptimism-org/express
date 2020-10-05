import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 30.0),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 40.0, 20.0, 40.0),
                    child: Row(
                      children: [
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.arrow_back),
                            iconSize: 25.0,
                            color: Colors.black,
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Settings',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w800,
                            fontSize: scaler.getTextSize(8.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                    color: Colors.grey[100],
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 5.0, 10.0, 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: new BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 8,
                                    color: Colors.black.withOpacity(0.06),
                                    offset: Offset(0, 10))
                              ],
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/images/stockimg.jpg'),
                              ),
                            ),
                            width: scaler.getWidth(5),
                            height: 69,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text('Lorem Ipsum',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w700,
                                      fontSize: scaler.getTextSize(7.0),
                                    )),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Text(
                                  'loremipsum@sample.com',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    fontSize: scaler.getTextSize(6.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 50.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    color: Colors.grey[100],
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 5.0, 10.0, 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.info),
                          SizedBox(
                            width: scaler.getWidth(2),
                          ),
                          Text(
                            'About Express',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: scaler.getTextSize(7.0),
                            ),
                          ),
                          SizedBox(
                            width: scaler.getWidth(8),
                          ),
                          IconButton(
                            icon: Icon(Icons.chevron_right),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: scaler.getWidth(35),
                    color: Colors.grey[100],
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 5.0, 10.0, 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.help),
                          SizedBox(
                            width: scaler.getWidth(2),
                          ),
                          Text(
                            'Help',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: scaler.getTextSize(7.0),
                            ),
                          ),
                          SizedBox(
                            width: scaler.getWidth(16),
                          ),
                          IconButton(
                            icon: Icon(Icons.chevron_right),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.grey[100],
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 5.0, 10.0, 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.message),
                          SizedBox(
                            width: scaler.getWidth(2),
                          ),
                          Text(
                            'Send Feedback',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: scaler.getTextSize(7.0),
                            ),
                          ),
                          SizedBox(
                            width: scaler.getWidth(7),
                          ),
                          IconButton(
                            icon: Icon(Icons.chevron_right),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  FlatButton(
                    onPressed: () {},
                    color: Colors.grey[100],
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(2, 5.0, 0, 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.exit_to_app),
                          SizedBox(
                            width: scaler.getWidth(2),
                          ),
                          Text(
                            'Sign Out',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: scaler.getTextSize(7.0),
                            ),
                          ),
                          SizedBox(
                            width: scaler.getWidth(12.5),
                          ),
                          IconButton(
                            icon: Icon(Icons.chevron_right),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
