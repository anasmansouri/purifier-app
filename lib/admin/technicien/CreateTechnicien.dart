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

import 'package:purifiercompanyapp/global_constants/Constants.dart';


class CreateTechnicien extends StatefulWidget {

  String tocken;
  CreateTechnicien({this.tocken});
  @override
  _CreateTechnicienState createState() => _CreateTechnicienState();
}

class _CreateTechnicienState extends State<CreateTechnicien> {

  final formKey = GlobalKey<FormState>();
  String staffcode ;
  String staffshort ;
  String staffname;
  String staffcontact;
  String email;

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
      ));
    }else if(wrongInfo){
      return Text(wrongInfoMsg, textAlign: TextAlign.center,style: TextStyle(
          color: Colors.red,
          fontSize: 20,
      ));
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
                labelText: "Enter staffname",
            fillColor: Colors.white,
                border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
          ),
            prefixIcon: Icon(Icons.contacts,color: this.color)
        ),
        // ignore: missing_return
        validator: (username) {
          if((username==null)||(username.isEmpty)) {
            return "Please Enter staffname ";
          }
        },
        onSaved: (staffname){
          this.staffname=staffname;
        },
        keyboardType: TextInputType.text,
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
      ),
                  SizedBox(height: 20),
                  new TextFormField(
                    decoration: new InputDecoration(
                        labelText: "Enter staffcontact ",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        prefixIcon: Icon(Icons.contacts,color: this.color)
                    ),
                    // ignore: missing_return
                    validator: (staffcontact) {
                      if((staffcontact==null)||(staffcontact.isEmpty)) {
                        return "Please Enter staffcontact";
                      }
                    },
                    onSaved: (staffcontact){
                      this.staffcontact=staffcontact;
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),SizedBox(height: 20),
                  new TextFormField(
                    decoration: new InputDecoration(
                        labelText: "Enter staffshort ",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        prefixIcon: Icon(Icons.contacts,color: this.color)
                    ),
                    // ignore: missing_return
                    validator: (staffshort) {
                      if((staffshort==null)||(staffshort.isEmpty)) {
                        return "Please Enter a invitation code ";
                      }
                    },
                    onSaved: (staffshort){
                      this.staffshort=staffshort;
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(height: 20),
                  new TextFormField(
                    decoration: new InputDecoration(
                        labelText: "Enter staff code N",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        prefixIcon: Icon(FontAwesomeIcons.idCard,color: this.color)
                    ),
                    validator: (staffcode) {

                    },
                    onSaved: (staffcode){
                      this.staffcode=staffcode;
                    },
                    keyboardType: TextInputType.number,

                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),SizedBox(height: 20),
                new TextFormField(
                  decoration: new InputDecoration(
                      labelText: "Enter email",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                      prefixIcon: Icon(Icons.email,color: this.color)
                  ),
                    validator: (email) {
                    },
                  onSaved: (email){
                    this.email=email;
                  },
                  keyboardType: TextInputType.text,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
                  SizedBox(height: 30,),
                  Center(
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

  Future<http.Response> submitInfo({String staffcode,
  String staffshort ,
  String staffname,
  String tocken,
  String staffcontact,
  String email}) async {

    return http.post(
      Constants.server_ip+'management/Technicians/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':'Token $tocken'
      },
      body: jsonEncode(<String, dynamic>{
          "staffcode": staffcode,
          "staffshort":staffshort,
          "staffname": staffname,
          "staffcontact": staffcontact,
          "email": email
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
          submitInfo(tocken: widget.tocken,email: this.email,staffcode: this.staffcode,staffcontact: this.staffcontact,staffname: this.staffname,staffshort: this.staffshort).then((onValue) async {
            print(json.decode(onValue.body).toString());
            if (json.decode(onValue.body).containsKey("error")){
              wrongInfo=true;
              wrongInfoMsg = json.decode(onValue.body)["error"].toString();
              setState(() {

              });
            }else if(json.decode(onValue.body).containsKey("staffcode")){
              wrongInfo=false;
              wrongInfoMsg="";
              print("token "+json.decode(onValue.body)["token"].toString());
              Navigator.pop(context,true);
            }else{
              wrongInfo=true;
              wrongInfoMsg = "there is something wrong";
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