import 'package:flutter/material.dart';
import 'package:purifiercompanyapp/Authentification/Login.dart';
import 'package:purifiercompanyapp/Authentification/SignUp.dart';
import 'package:purifiercompanyapp/Authentification/verify_info.dart';
import 'package:purifiercompanyapp/home/home.dart';
import 'package:purifiercompanyapp/personalInfo/ClientInfo.dart';
import 'package:purifiercompanyapp/personalInfo/PersonalInformations.dart';
import 'package:purifiercompanyapp/Authentification/forgotPassword.dart';
void main() async {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/Login",
      routes: {
        '/Login' :(context) => Login(),
        '/SignUp' :(context)=>SignUp(),
        '/ClientInfo' :(context) => ClientInfo(),
        '/home' : (context) => Home(),
        '/personalInfo' :(context) => PersonalInformations(email: "anas.mansouri@gmail.com"),
        '/verify_info':(context)=>Verify_email(),
        '/forgotPassword':(context)=>ForgotPassword()
      }
  ));
}