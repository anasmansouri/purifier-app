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

import '../home.dart';

class ChangecontactName extends StatefulWidget {
  @override
  _ChangecontactNameState createState() => _ChangecontactNameState();
}

class _ChangecontactNameState extends State<ChangecontactName> {
  String password;
  String new_contact_name;
  bool wrongInfo =false;
  bool good_internet= true;
  String wrongInfoMsg="";
  Map data={};
  final formKey = GlobalKey<FormState>();
  String token="";
  Color color =Colors.blue;
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
    // token ='e6d5f02d4e504682a8914469f65ff5153209a637';
    print(data["userId"]);

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
              Text("Change contact name",style: TextStyle(
                  color: color,
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
                        color: color)
                ),
                obscureText: true,
              ),SizedBox(height: 18,),
              TextFormField(
                onSaved: (input) {
                  new_contact_name = input;
                },
                validator: (input) {
                  if (input.isEmpty) {
                    return "the contact name can't be empty";
                  }

                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                    labelText: "contact name",
                    prefixIcon: Icon(Icons.contacts,
                        color: color)
                ),
              ),SizedBox(height: 18,),
              Center(
                  child:ProgressButton(
                    borderRadius: 20,
                    color: color,
                    defaultWidget: const Text('Submit',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),overflow: TextOverflow.ellipsis),
//  progressWidget: const CircularProgressIndicator(),
                    progressWidget:SpinKitRotatingCircle   (
                      color: color,
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

      Constants.server_ip+'security/update_contact_name/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':'token $token'
      },
      body: jsonEncode(<String, String>{
        'password': password,
        'new_contact_name':new_contact_name
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
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => FancyBottomBarPage(token:token,userId: data["userId"].toString(),), ));
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
