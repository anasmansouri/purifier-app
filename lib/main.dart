

import 'package:flutter/material.dart';
import 'package:purifiercompanyapp/Authentification/Login.dart';
import 'package:purifiercompanyapp/Authentification/SignUp.dart';
import 'package:purifiercompanyapp/Authentification/verify_info.dart';
import 'package:purifiercompanyapp/personalInfo/ClientInfo.dart';
import 'package:purifiercompanyapp/personalInfo/PersonalInformations.dart';
import 'package:purifiercompanyapp/Authentification/forgotPassword.dart';
import 'package:purifiercompanyapp/Client/home.dart';
void main() async {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/SignUp",
      routes: {
        '/Login' :(context) => Login(),
        '/SignUp' :(context)=>SignUp(),
        '/ClientInfo' :(context) => ClientInfo(),
        '/personalInfo' :(context) => Profile_Client(),
        '/verify_info':(context)=>Verify_email(),
        '/forgotPassword':(context)=>ForgotPassword(),
        // working on home
        '/home':(context)=>FancyBottomBarPage()
      }
  ));
}