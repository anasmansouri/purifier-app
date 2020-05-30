import 'dart:convert';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:purifiercompanyapp/Animations/animation.dart';
import 'package:purifiercompanyapp/Authentification/verify_info.dart';


// to test if it is an email
import 'package:email_validator/email_validator.dart';

//test json

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:io';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final formKey = GlobalKey<FormState>();
  String email;
  String password;
  String password2;
  String userName;
  String invitationcode;


  bool wrongInfo =false;
  bool good_internet= true;
  String wrongInfoMsg="";
  Widget Alert(){
    String msg ="";
    if(!good_internet){
      return Text("no internet connexion ",textAlign: TextAlign.center,style: TextStyle(
          color: Colors.red,
          fontSize: 15
      ),);
    }else if(wrongInfo){
      return Text(wrongInfoMsg, textAlign: TextAlign.center,style: TextStyle(
          color: Colors.red,
          fontSize: 20,

      ),);
    }else{
      return SizedBox(height: 0,width: 0,);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView( // hadi 7lina biha l mouchkil dyal l clavier kayghati l boutounate
        child: SafeArea(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30,),
                  Center(
                   child :  Icon(
                        Icons.perm_identity,
                        color: Colors.deepPurple,
                        size: 130.0,
                      ),
                    //IconTheme
                  ),Center(child: Alert()),
                  SizedBox(height: 60,),
                  new TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Enter Email",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                        prefixIcon: Icon(Icons.email,color: Colors.deepPurple)
                    ),
                    validator: (email) {
                      if(!EmailValidator.validate(email)) {
                        return "Please Enter an Email";
                      }

                    },
                    onSaved: (email){
                      this.email=email;
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),SizedBox(height: 20),
                new TextFormField(
                decoration: new InputDecoration(
                labelText: "Enter User Name",
            fillColor: Colors.white,
                border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
          ),
            prefixIcon: Icon(Icons.contacts,color: Colors.deepPurple)
        ),
        // ignore: missing_return
        validator: (username) {
          if((username==null)||(username.isEmpty)) {
            return "Please Enter a username ";
          }
        },
        onSaved: (username){
          this.userName=username;
        },
        keyboardType: TextInputType.text,
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
      ),SizedBox(height: 20),new TextFormField(
                    decoration: new InputDecoration(
                        labelText: "Enter User invitation code ",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        prefixIcon: Icon(Icons.contacts,color: Colors.deepPurple)
                    ),
                    // ignore: missing_return
                    validator: (invitation_code) {
                      if((invitation_code==null)||(invitation_code.isEmpty)) {
                        return "Please Enter a invitation code ";
                      }
                    },
                    onSaved: (invitation_code){
                      this.invitationcode=invitation_code;
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),SizedBox(height: 20),
                  new TextFormField(
                    decoration: new InputDecoration(
                        labelText: "Enter Password",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        prefixIcon: Icon(Icons.keyboard_hide,color: Colors.deepPurple)
                    ),
                    validator: (password) {
                      if(password.length<8 || password.isEmpty) {
                        return "Please The lenghtof the Password should be greather than 8 characters";
                      }
                    },
                    onSaved: (password){
                      this.password=password;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),SizedBox(height: 20)
                  ,new TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Password Confirm",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                        prefixIcon: Icon(Icons.keyboard_hide,color: Colors.deepPurple)
                    ),
                    validator: (password2) {
                      if(password2.length<8 || password2.isEmpty) {
                        return "The lenghtof the Password should be greather than 8 characters or the password must match ";
                      }
                    },
                    onSaved: (password2){
                      this.password2=password2;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  )

                  ,SizedBox(height: 20),SizedBox(height: 20)

                  ,SizedBox(height: 30,),Center(
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


                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Future<http.Response> submitInfo({String email, String password,String password2,String username,String invitationcode}) async {
    return http.put(
      'http://192.168.1.10:8000/security/registration/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
          "user":{
            "username":username,
            "email":email,
            "password":password
          },
          "invitationcode":invitationcode,
          "password2":password2
        }
      ),
    );
  }
  Future<void> submit() async {
    print("rahna brakna ");
    if (formKey.currentState.validate()) {
      print("rahna d5alna");
      formKey.currentState.save();
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print('connected');
          good_internet=true;
          print("password : " + this.password);
          print("email : " + this.email);
          submitInfo(email: this.email,password: this.password,password2: this.password2,username: this.userName,invitationcode: this.invitationcode).then((onValue) async {
            if (json.decode(onValue.body)["response"] != null){
              wrongInfo=false;
              wrongInfoMsg="";
              print("token "+json.decode(onValue.body)["token"].toString());
              Navigator.pushNamed(
                  context, '/verify_info', arguments: {
                "token": json.decode(onValue.body)["token"].toString()
              });
            }else{
              wrongInfo=true;
              wrongInfoMsg = json.decode(onValue.body)["error"].toString();
              if( json.decode(onValue.body)["error"].toString()=="null"){
                wrongInfoMsg ="there something wrong in your info ";
              }
              print("we have an error "+json.decode(onValue.body)["error"].toString());
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

