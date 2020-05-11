
import 'package:flutter/material.dart';
import 'package:purifiercompanyapp/Authentification/Login.dart';
import 'package:purifiercompanyapp/Authentification/SignUp.dart';
import 'package:purifiercompanyapp/home/home.dart';
import 'package:purifiercompanyapp/personalInfo/ClientInfo.dart';
import 'package:purifiercompanyapp/personalInfo/PersonalInformations.dart';
void main() async {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/SignUp",
      routes: {
        '/Login' :(context) => Login(),
        '/SignUp' :(context)=>SignUp(),
        '/ClientInfo' :(context) => ClientInfo(),
        '/home' : (context) => Home(),
        '/personalInfo' :(context) => PersonalInformations(email: "anas.mansouri@gmail.com")
      }
  ));
}