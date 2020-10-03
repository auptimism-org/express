import 'package:Express/screens/patientHome.dart';
import 'package:flutter/material.dart';

// This class skips the authentication page in case already signed in.
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return PatientHome();
  }
}