import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:email_validator/email_validator.dart';
import 'package:purifiercompanyapp/Animations/animation.dart';
import 'package:purifiercompanyapp/home/home.dart';
import 'package:purifiercompanyapp/personalInfo/PersonalInformations.dart';
import 'dart:io';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final formKey = GlobalKey<FormState>();
  String username;
  String password;
  bool wrongInfo =false;
  bool good_internet= true;
  String wrongInfoMsg="";
  Widget Alert(){
    if(!good_internet){
      return Text("no internet connexion ",style: TextStyle(
          color: Colors.red,
          fontSize: 15
      ),);
    }else if(wrongInfo){
      return Text(wrongInfoMsg,style: TextStyle(
        color: Colors.red,
        fontSize: 15
      ),);
    }else{
      return SizedBox(height: 0,width: 0,);
    }
  }




  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var msg='';
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: height / 5,),
              Center(
                child: Text("Login",
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 50,
                      fontFamily: 'BalooBhai'
                  ),)
              ),SizedBox(height: 20,),
              Center(child: Alert()),
              SizedBox(height: height / 20,),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        onSaved: (input) {
                          username = input;
                        },
                        validator: (input) {
                          if((input==null)||(input.isEmpty)) {
                            return "Please Enter a username ";
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                            ),
                            labelText: "username",
                            prefixIcon: Icon(Icons.contacts,
                                color: Colors.deepPurple)
                        ),
                      ), SizedBox(height: height / 30,),
                      TextFormField(
                        onSaved: (input) {
                          password = input;
                        },
                        validator: (input) {
                          if (input.length > 8 || input.isNotEmpty) {} else {
                            return "there is a problem in the password ";
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                            ),
                            labelText: "Password",
                            prefixIcon: Icon(Icons.keyboard_hide,
                                color: Colors.deepPurple)
                        ),
                        obscureText: true,
                      ), SizedBox(height: height / 30,),
                      Center(
                        child: ProgressButton(
                            borderRadius: 20,
                            color: Colors.deepPurple,
                            defaultWidget: const Text('Submit',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),),
                            //  progressWidget: const CircularProgressIndicator(),
                            progressWidget: SpinKitRotatingCircle(
                              color: Colors.red,
                              size: 50.0,
                            ),
                            width: width / 3.5,
                            height: height / 22,
                            onPressed: submit
                        ),
                      ),SizedBox(height: 30,),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                // Sign up
                                Navigator.pushReplacementNamed(
                                    context, '/SignUp');
                              },
                              child: Text(
                                "create account",
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              ),
                            ),SizedBox(width: width/10,),
                            InkWell(
                              onTap: () {
                                // forget password

                                Navigator.pushReplacementNamed(
                                    context, '/forgotPassword');

                              },
                              child: Text(
                                "Forgot password",
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<http.Response> submitInfo(String username, String password) async {
   return http.post(
      'http://192.168.1.4:8000/security/api-token-auth/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password':password
      }),
    );
  }



  Future<http.Response> is_admin(String token) async {
    return http.get(
      'http://192.168.1.10:8000/is_admin/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':'token $token'
      }
    );
  }

  Future<void> submit() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print('connected');
          good_internet=true;
          print("password : " + this.password);
          print("username : " + this.username);
          submitInfo(this.username, this.password).then((onValue){
            if (json.decode(onValue.body)["token"] != null){
              print("info \n"+json.decode(onValue.body).toString());
              wrongInfo=false;
              wrongInfoMsg="";
            }else{
              wrongInfo=true;
              wrongInfoMsg=json.decode(onValue.body)["non_field_errors"][0].toString();
              print("we have an error "+json.decode(onValue.body)["non_field_errors"][0].toString());
              setState(() {

              });
            }
          });
        }
      } on SocketException catch (_) {
        print('not connected');
        setState(() {
          good_internet= false;
        });
      }
    /*  submitInfo(this.email, this.password).then((onValue){
        if(onValue){
          wrongInfo = false;
          if(Client){
            Navigator.push(context, SlideRightRoute(page: PersonalInformations(email: this.email)));
          }else{
            Navigator.push(context, SlideRightRoute(page: Home()));
          }
          print("client $Client");
        }else{
          print("client $Client");
          setState(() {
            wrongInfo = true;
          });
        }
      });  */
    }
  }
}