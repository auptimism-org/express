import 'package:flutter/material.dart';
import '../screens/login_signup_page.dart';
import '../services/authentication.dart';
import '../screens/home.dart';
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool _connStatus;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _connStatus = true;
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
        }
        authStatus = (user?.isEmailVerified == true)
            ? AuthStatus.LOGGED_IN
            : AuthStatus.NOT_LOGGED_IN;
      });
    });
  }

  void loginCallback() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
      });
      if (user?.isEmailVerified == true) {
        setState(() {
          authStatus = AuthStatus.LOGGED_IN;
        });
      }
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  @override
  Widget build(BuildContext context) {
    if (_connStatus) {
      switch (authStatus) {
        case AuthStatus.NOT_DETERMINED:
          return buildWaitingScreen();
          break;
        case AuthStatus.NOT_LOGGED_IN:
          return new LoginSignupPage(
            auth: widget.auth,
            loginCallback: loginCallback,
          );
          break;
        case AuthStatus.LOGGED_IN:
          if (_userId.length > 0 && _userId != null) {
            return new HomePage(
              userId: _userId,
              auth: widget.auth,
              logoutCallback: logoutCallback,
            );
          } else
            return buildWaitingScreen();
          break;
        default:
          return buildWaitingScreen();
      }
    } else {
      return buildWaitingScreen();
    }
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      setState(() {
        _connStatus = false;
      });
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/noInternet',
          (route) => route.isCurrent || route.settings.name == '/noInternet'
              ? false
              : true);
    } else {
      setState(() {
        _connStatus = true;
      });
      if (Navigator.of(context).canPop()) Navigator.of(context).pop();
    }
  }
}
