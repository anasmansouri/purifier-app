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
import 'package:purifiercompanyapp/Client/home.dart';
import 'package:purifiercompanyapp/admin/home.dart';
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
  Color color =Colors.blue;
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
                      color: this.color,
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
                                color: this.color)
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
                                color: this.color)
                        ),
                        obscureText: true,
                      ), SizedBox(height: height / 30,),
                      Center(
                        child: ProgressButton(
                            borderRadius: 20,
                            color: this.color,
                            defaultWidget: const Text('Submit',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),),
                            //  progressWidget: const CircularProgressIndicator(),
                            progressWidget: SpinKitRotatingCircle(
                              color: this.color,
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
                                    color: this.color,
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
                                    color: this.color,
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
      'http://192.168.1.3:8000/security/api-token-auth/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password':password
      }),
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
            print(onValue.body.toString());
            if (json.decode(onValue.body)["token"] != null){
              print("token \n"+json.decode(onValue.body)["token"]);
              wrongInfo=false;
              wrongInfoMsg="";
              if (json.decode(onValue.body)["is_admin"]){
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context)
                    => FancyBottomBarPageAdmin(token:json.decode(onValue.body)["token"] ,
                      userId: json.decode(onValue.body)["user_id"].toString(),), ));
              }else{
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context)
                    => FancyBottomBarPage(token:json.decode(onValue.body)["token"] ,
                      userId: json.decode(onValue.body)["user_id"].toString(),), ));
              }

            }else if(json.decode(onValue.body)["error"] != null){
              wrongInfo=true;
              wrongInfoMsg=json.decode(onValue.body)["error"].toString();
              setState(() {

              });
            }else{
              wrongInfo=true;
              wrongInfoMsg=json.decode(onValue.body)["non_field_errors"][0].toString();
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
    }
  }
}