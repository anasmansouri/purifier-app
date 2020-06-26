import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toast/toast.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:io';

import 'Login.dart';

class Verify_email extends StatefulWidget {
  @override
  _Verify_emailState createState() => _Verify_emailState();
}

class _Verify_emailState extends State<Verify_email> {
  String code ;
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
    data=ModalRoute.of(context).settings.arguments;
    token =data["token"].toString();
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
            Text("Email verification",style: TextStyle(
                color: this.color,
                fontSize: 29
            )),Center(child: Alert()),SizedBox(height: height/20,),
            TextFormField(
              onSaved: (input) {
                code = input;
              },
              validator: (input) {
                if (( input !=null ||input.isNotEmpty || int.parse(input) is int)) {} else {
                  return "please make sure that the code is correct";
                }
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                  ),
                  labelText: "Enter the verification code",
                  prefixIcon: Icon(Icons.security,
                      color: this.color)
              ),
            ),SizedBox(height: 18,),Center(
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
    );
  }


  Future<http.Response> submitInfo({String code}) async {
    return http.post(
      'http://anasmansouri.ddns.net:8000/security/verify_email/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':'token $token'
      },
      body: jsonEncode(<String, String>{
        'code': code.toString(),
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

          submitInfo(code: this.code).then((onValue){
            if (json.decode(onValue.body)["response"] != null){
              wrongInfo=false;
              wrongInfoMsg="";
              Toast.show("your email is verified", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);

              Route route = MaterialPageRoute(builder: (context) => Login());
              Navigator.pushAndRemoveUntil(context,route,(Route<dynamic> route)=> false);
                        }else{
              wrongInfo=true;
              wrongInfoMsg = json.decode(onValue.body)["error"].toString();
              if( json.decode(onValue.body)["error"].toString()=="null"){
                wrongInfoMsg ="there something wrong in your code ";
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
