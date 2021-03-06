import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import './addDonation.dart';
import '../authentication/login.dart';

class WrapperAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    
    // return either the Home or Authenticate widget
    if (user == null){
      return LoginScreen();
    } else {
      return AddDonation();
    }
    
  }
}