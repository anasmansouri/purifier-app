import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


//test json

import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:io';

import '../home.dart';


class UpdateMainPack extends StatefulWidget {

  String tocken;
  String packagecode ;
  bool isbytime ;
  bool isbyusage;
  String price;
  String exfiltermonth;
  String exfiltervolume;
  String packagedetail;
  String userId;
  UpdateMainPack({this.tocken,this.exfiltervolume,this.packagecode,this.exfiltermonth,this.packagedetail,this.price,this.userId,this.isbyusage,this.isbytime});
  @override
  _UpdateMainPackState createState() => _UpdateMainPackState();
}

class _UpdateMainPackState extends State<UpdateMainPack> {

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
                        Icons.inbox,
                        color: this.color,
                        size: 130.0,
                      ),
                    //IconTheme
                  ),Center(child: Alert()),
                  SizedBox(height: 60,),
                  SizedBox(height: 20),
                  new TextFormField(
                    initialValue: widget.price,
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
                     widget.price=price;
                    },
                    keyboardType: TextInputType.number,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),SizedBox(height: 20),
                  new TextFormField(
                    initialValue: widget.exfiltermonth,
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
                      widget.exfiltermonth=exfiltermonth;
                    },
                    keyboardType: TextInputType.number,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(height: 20),
                  new TextFormField(
                    initialValue: widget.exfiltervolume,
                    decoration: new InputDecoration(
                        labelText: "Enter exfiltervolume",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        prefixIcon: Icon(FontAwesomeIcons.prescriptionBottle,color: this.color)
                    ),
                    validator: (exfiltervolume) {

                    },
                    onSaved: (exfiltervolume){
                      widget.exfiltervolume=exfiltervolume;
                    },
                    keyboardType: TextInputType.number,

                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),SizedBox(height: 20),
                new TextFormField(
                  initialValue: widget.packagedetail,
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
                    widget.packagedetail=packagedetail;
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

  Future<http.Response> submitInfo({String packagecode,
  String price,
  String tocken,
  String packagedetail,
  String email,
  String exfiltervolume,
  String exfiltermonth}) async {

    return http.put(
      'http://anasmansouri.ddns.net:8000/management/update_main_pack_info/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':'Token $tocken'
      },
      body: jsonEncode(<String, dynamic>{
          "packagecode": packagecode,
          "packagedetail":packagedetail,
          "price": price,
          "exfiltervolume": exfiltervolume,
          "exfiltermonth": exfiltermonth
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
          submitInfo(tocken: widget.tocken,packagecode:  widget.packagecode,price: widget.price,packagedetail: widget.packagedetail,exfiltervolume: widget.exfiltervolume,exfiltermonth: widget.exfiltermonth).then((onValue) async {
            print(json.decode(onValue.body).toString());
            if (json.decode(onValue.body).containsKey("error")){
              wrongInfo=true;
              wrongInfoMsg = json.decode(onValue.body)["error"].toString();
              setState(() {

              });
            }else if(json.decode(onValue.body).containsKey("packagecode")){
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