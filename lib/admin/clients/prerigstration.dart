import 'dart:convert';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:purifiercompanyapp/Animations/animation.dart';
import 'package:purifiercompanyapp/Authentification/verify_info.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


// to test if it is an email
import 'package:email_validator/email_validator.dart';

//test json

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:io';


class Prerigstration extends StatefulWidget {
  @override
  _PrerigstrationState createState() => _PrerigstrationState();
}

class _PrerigstrationState extends State<Prerigstration> {

  final formKey = GlobalKey<FormState>();
  String userName;
  String contactName;
  String address1;
  String address2;
  String invitationcode;
  String mobile;
  String contactno;
  String comment;
  String source="Online";

  Color color = Colors.blue;

  bool wrongInfo =false;
  bool good_internet= true;
  String wrongInfoMsg="asljl";
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
                        color: this.color,
                        size: 130.0,
                      ),
                    //IconTheme
                  ),Center(child: Alert()),
                  SizedBox(height: 60,),
                new TextFormField(
                decoration: new InputDecoration(
                labelText: "Enter User Name",
            fillColor: Colors.white,
                border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
          ),
            prefixIcon: Icon(Icons.contacts,color: this.color)
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
      ),
                  SizedBox(height: 20),
                  new TextFormField(
                    decoration: new InputDecoration(
                        labelText: "Enter contact name ",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        prefixIcon: Icon(Icons.contacts,color: this.color)
                    ),
                    // ignore: missing_return
                    validator: (username) {
                      if((username==null)||(username.isEmpty)) {
                        return "Please Enter the contat name ";
                      }
                    },
                    onSaved: (contactName){
                      this.contactName=contactName;
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),SizedBox(height: 20),
                  new TextFormField(
                    decoration: new InputDecoration(
                        labelText: "Enter User invitation code ",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        prefixIcon: Icon(Icons.contacts,color: this.color)
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
                  ),
                  SizedBox(height: 20),
                  new TextFormField(
                    decoration: new InputDecoration(
                        labelText: "Enter mobile N",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        prefixIcon: Icon(Icons.phone,color: this.color)
                    ),
                    validator: (phone) {

                    },
                    onSaved: (mobile){
                      this.mobile=mobile;
                    },
                    keyboardType: TextInputType.phone,

                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),SizedBox(height: 20),
                new TextFormField(
                  decoration: new InputDecoration(
                      labelText: "Enter contact N",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                      prefixIcon: Icon(Icons.phone,color: this.color)
                  ),
                    validator: (phone) {
                    },
                  onSaved: (contactno){
                    this.contactno=contactno;
                  },
                  keyboardType: TextInputType.phone,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
                  SizedBox(height: 20),
                  new TextFormField(
                    decoration: new InputDecoration(
                      labelText: "client address",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                        prefixIcon: Icon(Icons.keyboard_hide,color: this.color)
                    ),
                    validator: (address1) {
                      if(address1.isEmpty) {
                        return "please provide the client address";
                      }
                    },
                    onSaved: (address1){
                      this.address1=address1;
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(height: 20),
                  new TextFormField(
                    decoration: new InputDecoration(
                        labelText: "client address 2",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        prefixIcon: Icon(Icons.keyboard_hide,color: this.color)
                    ),
                    validator: (address2) {

                    },
                    onSaved: (address2){
                      this.address2=address2;
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(height: 20),
                  new TextFormField(
                    decoration: new InputDecoration(
                        labelText: "comment",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        prefixIcon: Icon(Icons.keyboard_hide,color: this.color)
                    ),
                    validator: (comment) {

                    },
                    onSaved: (comment){
                      this.comment=comment;
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 10),
                      Text("source",
                        style: new TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 17
                        ),),
                      SizedBox(width: 60),
                      DropdownButton<String>(
                        value: source,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: color),
                        onChanged: (String newValue) {
                          setState(() {
                            source = newValue;
                          });
                        },
                        items: <String>['Online', 'Referral', 'Old', 'Phone']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(height: 20)
                  ,SizedBox(height: 30,),Center(
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


                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<http.Response> submitInfo({String username,String invitationcode,String contactName,String mobile,String contactno,String comment,String source,String address1,
  String address2}) async {

    return http.post(
      'http://192.168.1.3:8000/security/prerigstration/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
          "user":{
            "username":username
          },
          "contactname":contactName,
          "billingaddress1":address1,
          "billingaddress2":address2,
          "contactno":contactno,
          "mobile":mobile,
          "invitationcode":invitationcode,
          "comment":comment,
          "source":source
        }
      ),
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
          submitInfo(address1: this.address1,address2: this.address2,username: this.userName,contactName: this.contactno,comment: this.comment,contactno: this.contactno,
          invitationcode: this.invitationcode,mobile: this.mobile,source: this.source).then((onValue) async {
            if (json.decode(onValue.body)["response"] != null){
              wrongInfo=false;
              wrongInfoMsg="";
              print("token "+json.decode(onValue.body)["token"].toString());
              Navigator.pop(context,true);
            }else{
              wrongInfo=true;
              wrongInfoMsg ="there is something wrong in your info ";
              print(json.decode(onValue.body).toString());
              var list_name = ["contactname","billingaddress1","billingaddress2","contactno","mobile","invitationcode","comment","source"];
              wrongInfoMsg ="there something wrong in your info ";
              
              for (var i =0;i<list_name.length;i++){
                if (json.decode(onValue.body).containsKey(list_name[i])){
                  wrongInfoMsg = json.decode(onValue.body)[list_name[i]][0].toString();
                  break;
                }
              }
              if (json.decode(onValue.body).containsKey("user")){
                wrongInfoMsg =json.decode(onValue.body)["user"]["username"];
              }
              if (json.decode(onValue.body).containsKey("error")){
                wrongInfoMsg =json.decode(onValue.body)["error"]["username"].toString();
              }
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