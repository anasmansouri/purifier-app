

import 'package:flutter/material.dart';
import 'package:purifiercompanyapp/Authentification/Login.dart';
import 'package:purifiercompanyapp/Authentification/SignUp.dart';
import 'package:purifiercompanyapp/Authentification/verify_info.dart';
import 'package:purifiercompanyapp/Client/update/changeEmail.dart';
import 'package:purifiercompanyapp/Client/update/changecontactName.dart';
import 'package:purifiercompanyapp/Authentification/forgotPassword.dart';
import 'package:purifiercompanyapp/Client/home.dart';
import 'package:purifiercompanyapp/Client/update/changePassword.dart';
import 'Client/update/updateInfo.dart';


void main() async {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/Login",
      routes: {
        '/Login' :(context) => Login(),
        '/SignUp' :(context)=>SignUp(),
        // '/personalInfo' :(context) => Profile_Client(),
        '/verify_info':(context)=>Verify_email(),
        '/forgotPassword':(context)=>ForgotPassword(),
        // working on home
        '/home':(context)=>FancyBottomBarPage(),
        '/updateInfo':(context)=>SettingsOnePage(),
        '/updatePassword':(context)=>ChangePassword(),
        '/updateContactName':(context)=>ChangecontactName(),
        '/changeEmail':(context)=>ChangeEmail(),
        '/verify_email_2':(context)=> Verify_email()
      }
  ));
}