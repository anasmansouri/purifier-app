import 'dart:convert';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:http/http.dart' as http;



class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String username ;
  String email;

  bool wrongInfo =false;
  bool good_internet= true;
  String wrongInfoMsg="";
  final formKey = GlobalKey<FormState>();

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
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Enter your informations ",style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 30
              )),SizedBox(height: height/10,),
              TextFormField(
                onSaved: (input) {
                  this.email = input;
                },
                validator: (email) {
                  if(!EmailValidator.validate(email)) {
                    return "Please Enter an Email";
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                    labelText: "email",
                    prefixIcon: Icon(Icons.email,
                        color: Colors.deepPurple)
                ),
              ),SizedBox(height: height/40,)
              ,TextFormField(
                onSaved: (input) {
                  username = input;
                },
                validator: (username) {

                  if((username==null)||(username.isEmpty)) {
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
              ),SizedBox(height: height/30,),Center(
                  child:ProgressButton(
                    borderRadius: 20,
                    color: Colors.deepPurple,
                    defaultWidget: const Text('Submit',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),),
//  progressWidget: const CircularProgressIndicator(),
                    progressWidget:SpinKitRotatingCircle   (
                      color: Colors.red,
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
    );;
  }
  Future<http.Response> submitInfo(String username, String email) async {
    return http.post(
      'http://192.168.1.10:8000/forgotpassword/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'username':username
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
          print("email : " + this.email);
          print("username : " + this.username);
          submitInfo(this.username, this.email).then((onValue){
            if (json.decode(onValue.body)["response"] == "true"){
              print("response "+json.decode(onValue.body)["response"].toString());
            }else{
              wrongInfo=true;
              print("we have an error "+json.decode(onValue.body)["response"].toString());
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
