import 'dart:convert';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:http/http.dart' as http;
import 'package:purifiercompanyapp/global_constants/Constants.dart';
import 'package:toast/toast.dart';

import 'Login.dart';



class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String username ;
  String invitationcode;

  bool wrongInfo =false;
  bool good_internet= true;
  String wrongInfoMsg="";
  Color color = Colors.blue;
  final formKey = GlobalKey<FormState>();

  Widget Alert(){
    if(!good_internet){
      return Text("no internet connexion ",textAlign: TextAlign.center,style: TextStyle(
          color: Colors.red,
          fontSize: 15
      ),overflow: TextOverflow.ellipsis);
    }else if(wrongInfo){
      return Text(wrongInfoMsg,textAlign: TextAlign.center,style: TextStyle(
          color: Colors.red,
          fontSize: 15
      ),overflow: TextOverflow.ellipsis);
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
                  color: this.color,
                  fontSize: 30
              ),overflow: TextOverflow.ellipsis),SizedBox(height: height/10,),
              Center(child: Alert()),
              SizedBox(height: 20,),
              TextFormField(
                onSaved: (input) {
                  this.invitationcode = input;
                },
                validator: (invitationcode) {
                  if((invitationcode==null)||(invitationcode.isEmpty)) {
                    return "Please Enter your invitation code ";
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                    labelText: "invitationcode",
                    prefixIcon: Icon(Icons.contacts,
                        color: this.color)
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
                        color: this.color)
                ),
              ),SizedBox(height: height/30,),Center(
                  child:ProgressButton(
                    borderRadius: 20,
                    color: this.color,
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
  Future<http.Response> submitInfo(String username, String invitationcode) async {
    return http.post(
      Constants.server_ip+'security/forgotpassword/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'invitationcode': invitationcode,
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
          print("invitation code : " + this.invitationcode);
          print("username : " + this.username);
          submitInfo(this.username, this.invitationcode).then((onValue){
            if (json.decode(onValue.body)["response"] != null){
              Toast.show(json.decode(onValue.body)["response"], context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
              Route route = MaterialPageRoute(builder: (context) => Login());
              Navigator.pushAndRemoveUntil(context,route,(Route<dynamic> route)=> false);
            }else{
              wrongInfo=true;
              wrongInfoMsg=json.decode(onValue.body)["error"].toString();
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
