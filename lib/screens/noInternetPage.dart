import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class NoInternetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DesForm',
          style: TextStyle(
            color: Colors.white,
            fontSize: scaler.getTextSize(9.0),
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w900,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red[600],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0))),
      ),
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async => false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: scaler.getWidth(18.0),
                      height: scaler.getWidth(18.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(140.0),
                        gradient: LinearGradient(
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight,
                          colors: [Colors.red[600], Colors.red[700]],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300],
                            blurRadius: 20.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/connError.png',
                            scale: scaler.getWidth(0.6),
                          ),
                          Text(
                            "*sad purrs*",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Montserrat',
                                color: Color(0xFFFCE8E8),
                                fontSize: scaler.getTextSize(8.5)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      "Oops..No Internet\nConnection!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                          color: Colors.red[600],
                          fontSize: scaler.getTextSize(8.0)),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      height: scaler.getWidth(5.0),
                      width: scaler.getWidth(5.0),
                      child: RaisedButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60.0)),
                        splashColor: Colors.white,
                        color: Color(0xFFFCE8E8),
                        child: Icon(Icons.refresh, color: Colors.red[600]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
