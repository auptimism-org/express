import 'package:Express/dynBackground.dart';
import 'package:Express/screens/forgotPassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import '../services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

var h = 18.0;
bool name = true;
bool dob = true;
bool phone = true;
bool email = true;
bool psw = true;

class LoginSignupPage extends StatefulWidget {
  LoginSignupPage({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;
  @override
  State<StatefulWidget> createState() => new _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final _formKey = new GlobalKey<FormState>();
  ScreenScaler scaler = ScreenScaler();

  String _email;
  String _password;
  String _errorMessage;
  String _name;
  String _dob;
  String _mobNo;

  bool _isLoginForm;
  bool _isLoading;

  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave()) {
      String userId = "";
      try {
        if (_isLoginForm) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
        } else {
          userId = await widget.auth.signUp(_email, _password);
          widget.auth.sendEmailVerification();
          _showVerifyEmailSentDialog();
          print('Signed up user: $userId');

          Firestore.instance.collection('users').document(userId).setData({
            'name': _name,
            'dob': _dob,
            'email': _email,
            'courses': [],
            'mobno': _mobNo,
          });
        }
        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null) {
          widget.loginCallback();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          if (h < 22.0) {
            h = 22.0;
          }
          _isLoading = false;
          _errorMessage = e.message;
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
  }

  void toggleFormMode() {
    resetForm();
    setState(
      () {
        _errorMessage = "";
        _isLoginForm = !_isLoginForm;
        h = (_isLoginForm) ? 18.0 : 27.0;
        name = true;
        dob = true;
        phone = true;
        email = true;
        psw = true;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: new Scaffold(
        body: Stack(
          children: <Widget>[
            Positioned.fill(child: AnimatedBackground()),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: Container(
                  height: scaler.getHeight(h),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                        spreadRadius: 1.0,
                        offset: Offset(0.0, 8.0),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            _showForm(),
            _showCircularProgress()
          ],
        ),
      ),
    );
  }

  Widget _showCircularProgress() {
    if (_isLoading && _errorMessage == null) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Verify your account",
            style: TextStyle(
              color: Colors.black,
              fontSize: scaler.getTextSize(8.0),
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w800,
            ),
          ),
          content: new Text(
            "Link to verify account has been sent to your email",
            style: TextStyle(
              color: Colors.black,
              fontSize: scaler.getTextSize(7.0),
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                "Dismiss",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: scaler.getTextSize(7.5),
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
              onPressed: () {
                toggleFormMode();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _showForm() {
    return new Form(
      key: _formKey,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 5.0, 40.0, 5.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                showLogo(),
                showNameInput(),
                showDobInput(),
                showMobNoInput(),
                showEmailInput(),
                showPasswordInput(),
                showErrorMessage(),
                showPrimaryButton(),
                SizedBox(
                  height: scaler.getHeight(0.5),
                ),
                if (_isLoginForm) showForgotPassword(context),
                SizedBox(
                  height: scaler.getHeight(0.5),
                ),
                showSecondaryButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      if (_errorMessage ==
          "The password is invalid or the user does not have a password.")
        _errorMessage = "The email/password combination does not exist.";

      resetForm();

      return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 5.0),
        child: new Text(
          _errorMessage,
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            fontFamily: 'Montserrat',
            height: 1.0,
          ),
        ),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget showLogo() {
    ScreenScaler scaler = ScreenScaler();
    return new Hero(
      tag: 'hero',
      child: Container(
        margin: EdgeInsets.only(top: 10.0, left: 10.0),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.fromLTRB(0.0, 0, 0.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Express',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
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
                  'insert fucking tag line',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: scaler.getTextSize(7.0),
                    fontFamily: 'Montserrat',
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget showNameInput() {
    if (!_isLoginForm) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        child: new TextFormField(
          maxLines: 1,
          keyboardType: TextInputType.text,
          autofocus: false,
          style: TextStyle(fontFamily: 'Montserrat'),
          decoration: new InputDecoration(
              hintText: 'Name',
              hintStyle: TextStyle(fontFamily: 'Montserrat'),
              icon: new Icon(
                Icons.face,
                color: Colors.grey[400],
              )),
          validator: (value) {
            if (value.isEmpty && name) {
              h += 1.0;
              name = false;
              return 'Name can\'t be empty';
            } else if (value.isEmpty) {
              return 'Name can\'t be empty';
            } else {
              name = true;
              return null;
            }
          },
          onSaved: (value) => _name = value,
        ),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget showDobInput() {
    final format = DateFormat("dd-MM-yyyy");
    if (!_isLoginForm) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        child: DateTimeField(
          format: format,
          style: TextStyle(fontFamily: 'Montserrat'),
          decoration: InputDecoration(
            hintText: 'dd/mm/yyyy',
            icon: Icon(
              Icons.calendar_today,
              color: Colors.grey[400],
            ),
          ),
          onShowPicker: (context, currentValue) {
            return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100),
              builder: (BuildContext context, Widget child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                      buttonTheme:
                          ButtonThemeData(textTheme: ButtonTextTheme.primary),
                      colorScheme: ColorScheme.light(
                        primary: Color(0xff2f2ea6),
                      ),
                      dialogBackgroundColor: Colors.white),
                  child: child,
                );
              },
            );
          },
          onSaved: (value) =>
              _dob = '${value.day}/${value.month}/${value.year}',
        ),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget showMobNoInput() {
    if (!_isLoginForm) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        child: new TextFormField(
          maxLines: 1,
          keyboardType: TextInputType.phone,
          autofocus: false,
          style: TextStyle(fontFamily: 'Montserrat'),
          inputFormatters: [
            LengthLimitingTextInputFormatter(10),
          ],
          decoration: new InputDecoration(
              hintText: 'Mobile Number',
              hintStyle: TextStyle(fontFamily: 'Montserrat'),
              icon: new Icon(
                Icons.call,
                color: Colors.grey[400],
              )),
          validator: (value) {
            if (value.isEmpty && phone) {
              h += 1.0;
              phone = false;
              return 'Phone No. can\'t be empty';
            } else if (value.isEmpty) {
              return 'Phone No. can\'t be empty';
            } else {
              phone = true;
              return null;
            }
          },
          onSaved: (value) => _mobNo = value,
        ),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget showPadding() {
    if (_isLoginForm) {
      return Container(
        height: 5.0,
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        style: TextStyle(fontFamily: 'Montserrat'),
        decoration: new InputDecoration(
            hintText: 'Email',
            hintStyle: TextStyle(fontFamily: 'Montserrat'),
            icon: new Icon(
              Icons.mail,
              color: Colors.grey[400],
            )),
        validator: (value) {
          if (value.isEmpty && email) {
            h += 1.0;
            email = false;
            return 'Email can\'t be empty';
          } else if (value.isEmpty) {
            return 'Email can\'t be empty';
          } else {
            email = true;
            return null;
          }
        },
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showPasswordInput() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      margin: EdgeInsets.only(bottom: 10.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        style: TextStyle(fontFamily: 'Montserrat'),
        decoration: new InputDecoration(
            hintText: 'Password',
            hintStyle: TextStyle(fontFamily: 'Montserrat'),
            icon: new Icon(
              Icons.lock,
              color: Colors.grey[400],
            )),
        validator: (value) {
          if (value.isEmpty && psw) {
            h += 1.0;
            psw = false;
            return 'Password can\'t be empty';
          } else if (value.isEmpty) {
            return 'Password can\'t be empty';
          } else {
            psw = true;
            return null;
          }
        },
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  Widget showSecondaryButton() {
    ScreenScaler scaler = ScreenScaler();
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: Align(
        child: SizedBox(
          width: scaler.getWidth(22.0),
          child: new FlatButton(
              child: new Text(
                  _isLoginForm
                      ? 'Create an account'
                      : 'Have an account?  Sign in',
                  style: new TextStyle(
                      fontSize: scaler.getTextSize(7.0),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Montserrat')),
              onPressed: toggleFormMode),
        ),
      ),
    );
  }

  Widget showPrimaryButton() {
    ScreenScaler scaler = ScreenScaler();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.0),
      child: Align(
        child: SizedBox(
          width: scaler.getWidth(18.0),
          child: new RaisedButton(
            elevation: 2.0,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            color: Theme.of(context).primaryColor,
            child: new Text(
              _isLoginForm ? 'Login' : 'Create Account',
              style: new TextStyle(
                  fontSize: scaler.getTextSize(8.0),
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat'),
            ),
            onPressed: validateAndSubmit,
          ),
        ),
      ),
    );
  }
}

Widget showForgotPassword(context) {
  return GestureDetector(
    child: Text(
      'Forgot Password?',
      style: TextStyle(
        fontFamily: 'Montserrat',
      ),
    ),
    onTap: () {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
    },
  );
}
