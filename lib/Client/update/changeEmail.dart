import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:purifiercompanyapp/global_constants/Constants.dart';
import 'package:toast/toast.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:email_validator/email_validator.dart';

class ChangeEmail extends StatefulWidget {
  @override
  _ChangeEmailState createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  String password;
  String new_email;
  String current_email;
  bool wrongInfo =false;
  bool good_internet= true;
  String wrongInfoMsg="";
  Color color =Colors.blue;

  Map data={};
  final formKey = GlobalKey<FormState>();
  String token="";

  Widget Alert(){
    if(!good_internet){
      return Text("no internet connexion ",style: TextStyle(
          color: Colors.red,
          fontSize: 15
      ),overflow: TextOverflow.ellipsis);
    }else if(wrongInfo){
      return Text(wrongInfoMsg,style: TextStyle(
          color: Colors.red,
          fontSize: 15
      ),overflow: TextOverflow.ellipsis);
    }else{
      return SizedBox(height: 0,width: 0,);
    }
  }
  @override
  Widget build(BuildContext context) {
    data=ModalRoute.of(context).settings.arguments;
    token =data["token"].toString();
    // token ='325a307825e6639db1ac6d1f287e99196b8568d9';

    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Change email address",style: TextStyle(
                  color: this.color,
                  fontSize: 29
              ),overflow: TextOverflow.ellipsis),Center(child: Alert()),SizedBox(height: height/20,),
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
              ),SizedBox(height: 18,),
              TextFormField(
                onSaved: (input) {
                  current_email = input;
                },
                validator: (input) {
                  if (EmailValidator.validate(input)) {} else {
                    return "please provide a valid email address";
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                    labelText: "current email",
                    prefixIcon: Icon(Icons.mail,
                        color: this.color)
                ),
              ),SizedBox(height: 18,),
              TextFormField(
                onSaved: (input) {
                  new_email = input;
                },
                validator: (input) {
                  if (EmailValidator.validate(input)) {} else {
                    return "please provide a valid email address";
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                    labelText: "new email",
                    prefixIcon: Icon(Icons.mail,
                        color: this.color)
                ),
              ),SizedBox(height: 18,)
              ,Center(
                  child:ProgressButton(
                    borderRadius: 20,
                    color: this.color,
                    defaultWidget: const Text('Submit',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),overflow: TextOverflow.ellipsis),
//  progressWidget: const CircularProgressIndicator(),
                    progressWidget:SpinKitRotatingCircle   (
                      color: this.color,
                      size: 50.0,
                    ) ,
                    width: 120,
                    height: 50,
                    onPressed: () async {
                      await submit();
// After [onPressed], it will trigger animation running backwards, from end to beginning
                      return () {
// Optional returns is returning a function that can be called
// after the animation is stopped at the beginning.
// A best practice would be to do time-consuming task in [onPressed],
// and do page navigation in the returned function.
// So that user won't missed out the reverse animation.
                      };
                    },
                  )


              )

            ],
          ),
        ),
      ),
    );
  }


  Future<http.Response> submitInfo() async {
    return http.post(
      Constants.server_ip+'security/update_email_address/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':'token '+token
      },
      body: jsonEncode(<String, String>{
        'password': password,
        'current_email':current_email,
        'new_email':new_email
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

          submitInfo().then((onValue){
            if (json.decode(onValue.body)["response"] != null){
              wrongInfo=false;
              wrongInfoMsg="";
              Toast.show(json.decode(onValue.body)["response"], context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
              print(json.decode(onValue.body)["response"]);
              Navigator.pushReplacementNamed(
                  context, '/verify_email_2', arguments: {
                "token": '$token',
                "userId":data["userId"].toString()
              });
            }else{
              wrongInfo=true;
              wrongInfoMsg = json.decode(onValue.body)["error"].toString();
              if( json.decode(onValue.body)["error"].toString()=="null"){
                wrongInfoMsg ="there something wrong in your code";
              }
              print("we have an error"+json.decode(onValue.body)["error"].toString());
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
