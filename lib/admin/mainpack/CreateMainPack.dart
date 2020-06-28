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


class CreateMainPack extends StatefulWidget {

  String tocken;
  CreateMainPack({this.tocken});
  @override
  _CreateMainPackState createState() => _CreateMainPackState();
}

class _CreateMainPackState extends State<CreateMainPack> {

  final formKey = GlobalKey<FormState>();

  String packagecode ;
  bool isbytime ;
  bool isbyusage;
  String price;
  String exfiltermonth;
  String exfiltervolume;
  String packagedetail;

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
                        Icons.inbox,
                        color: this.color,
                        size: 130.0,
                      ),
                    //IconTheme
                  ),Center(child: Alert()),
                  SizedBox(height: 60,),
                new TextFormField(
                decoration: new InputDecoration(
                labelText: "Enter packagecode",
            fillColor: Colors.white,
                border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
          ),
            prefixIcon: Icon(FontAwesomeIcons.idCard,color: this.color)
        ),
        // ignore: missing_return
        validator: (packagecode) {
          if((packagecode==null)||(packagecode.isEmpty)) {
            return "Please Enter packagecode ";
          }
        },
        onSaved: (packagecode){
          this.packagecode=packagecode;
        },
        keyboardType: TextInputType.text,
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
      ),
                  SizedBox(height: 20),
                 /* new TextFormField(
                    decoration: new InputDecoration(
                        labelText: "Enter price ",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        prefixIcon: Icon(FontAwesomeIcons.moneyBill,color: this.color)
                    ),
                    // ignore: missing_return
                    validator: (price) {
                      if((price==null)||(price.isEmpty)) {
                        return "Please Enter price";
                      }
                    },
                    onSaved: (price){
                      this.price=price;
                    },
                    keyboardType: TextInputType.number,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),SizedBox(height: 20),*/
                  new TextFormField(
                    decoration: new InputDecoration(
                        labelText: "Enter exfiltermonth ",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        prefixIcon: Icon(FontAwesomeIcons.hourglassHalf,color: this.color)
                    ),
                    // ignore: missing_return
                    validator: (exfiltermonth) {
                      if((exfiltermonth==null)||(exfiltermonth.isEmpty)) {
                        return "Please Enter a exfiltermonth";
                      }
                    },
                    onSaved: (exfiltermonth){
                      this.exfiltermonth=exfiltermonth;
                    },
                    keyboardType: TextInputType.number,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(height: 20),
                  new TextFormField(
                    decoration: new InputDecoration(
                        labelText: "Enter exfiltervolume",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        prefixIcon: Icon(FontAwesomeIcons.prescriptionBottle,color: this.color)
                    ),
                    validator: (exfiltervolume) {
                      if((exfiltervolume==null)||(exfiltervolume.isEmpty)) {
                        return "Please Enter a exfiltervolume";
                      }
                    },
                    onSaved: (exfiltervolume){
                      this.exfiltervolume=exfiltervolume;
                    },
                    keyboardType: TextInputType.number,

                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),SizedBox(height: 20),
                new TextFormField(
                  decoration: new InputDecoration(
                      labelText: "Enter packagedetail",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                      prefixIcon: Icon(FontAwesomeIcons.info,color: this.color)
                  ),
                    validator: (packagedetail) {
                    },
                  onSaved: (packagedetail){
                    this.packagedetail=packagedetail;
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

  Future<http.Response> submitInfo({
    String packagecode ,
    String price,
    String exfiltermonth,
    String exfiltervolume,
    String packagedetail,
    String tocken
  }) async {

    return http.post(
      Constants.server_ip+'management/MainPacks/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':'Token $tocken'
      },
      body: jsonEncode(<String, dynamic>{
          "packagecode": packagecode,
          "price":0,
          "exfiltermonth": exfiltermonth,
          "exfiltervolume": exfiltervolume,
          "packagedetail": packagedetail
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
          submitInfo(tocken: widget.tocken,price: this.price,packagedetail: this.packagedetail,exfiltermonth: this.exfiltermonth,packagecode: this.packagecode,exfiltervolume:  this.exfiltervolume).then((onValue) async {
            print(json.decode(onValue.body).toString());
            if (json.decode(onValue.body).containsKey("error")){
              wrongInfo=true;
              wrongInfoMsg = json.decode(onValue.body)["error"].toString();
              setState(() {

              });
            }else if(json.decode(onValue.body).containsKey("packagecode")){
              wrongInfo=false;
              wrongInfoMsg="";
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