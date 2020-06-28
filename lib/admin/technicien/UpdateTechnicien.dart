import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


//test json

import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:purifiercompanyapp/global_constants/Constants.dart';
import 'dart:io';

import '../home.dart';


class UpdateTechnicien extends StatefulWidget {

  String tocken;
  String staffcode ;
  String staffshort ;
  String staffname;
  String staffcontact;
  String email;
  String userId;
  UpdateTechnicien({this.tocken,this.staffshort,this.staffname,this.staffcontact,this.staffcode,this.email,this.userId});
  @override
  _UpdateTechnicienState createState() => _UpdateTechnicienState();
}

class _UpdateTechnicienState extends State<UpdateTechnicien> {

  final formKey = GlobalKey<FormState>();


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
      ),overflow: TextOverflow.ellipsis);
    }else if(wrongInfo){
      return Text(wrongInfoMsg, textAlign: TextAlign.center,style: TextStyle(
          color: Colors.red,
          fontSize: 20,
      ),overflow: TextOverflow.ellipsis);
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
                  initialValue: widget.staffname,
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
          widget.staffname=staffname;
        },
        keyboardType: TextInputType.text,
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
      ),
                  SizedBox(height: 20),
                  new TextFormField(
                    initialValue: widget.staffcontact,
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
                     widget.staffcontact=staffcontact;
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),SizedBox(height: 20),
                  new TextFormField(
                    initialValue: widget.staffshort,
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
                      widget.staffshort=staffshort;
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(height: 20),
                new TextFormField(
                  initialValue: widget.email,
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
                    widget.email=email;
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

    return http.put(
      Constants.server_ip+'management/update_technicien_info/',
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
          submitInfo(tocken: widget.tocken,email: widget.email,staffcode: widget.staffcode,staffcontact: widget.staffcontact,staffname: widget.staffname,staffshort: widget.staffshort).then((onValue) async {
            print(json.decode(onValue.body).toString());
            if (json.decode(onValue.body).containsKey("error")){
              wrongInfo=true;
              wrongInfoMsg = json.decode(onValue.body)["error"].toString();
              setState(() {

              });
            }else if(json.decode(onValue.body).containsKey("staffcode")){
              wrongInfo=false;
              wrongInfoMsg="";
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context)
                  => FancyBottomBarPageAdmin(token:widget.tocken ,
                    userId: widget.userId,), ));
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