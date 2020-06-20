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


class UpdateFilter extends StatefulWidget {
  String filtercode;
  String tocken;
  String filtername ;
  String filterdetail;
  String price;
  String userId;
  UpdateFilter({this.filtercode,this.tocken,this.filtername,this.filterdetail,this.userId,this.price});
  @override
  _UpdateFilterState createState() => _UpdateFilterState();
}

class _UpdateFilterState extends State<UpdateFilter> {

  final formKey = GlobalKey<FormState>();


  Color color = Colors.blue;

  bool wrongInfo =false;
  bool good_internet= true;
  String wrongInfoMsg=" ";
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
                        FontAwesomeIcons.filter,
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
                        labelText: "Enter price",
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
                    initialValue: widget.filtername,
                    decoration: new InputDecoration(
                        labelText: "Enter filter name ",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        prefixIcon: Icon(FontAwesomeIcons.signature,color: this.color)
                    ),
                    // ignore: missing_return
                    validator: (filtername) {
                      if((filtername==null)||(filtername.isEmpty)) {
                        return "Please Enter a filter name";
                      }
                    },
                    onSaved: (filtername){
                      widget.filtername=filtername;
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(height: 20),
                  new TextFormField(
                    initialValue: widget.filterdetail,
                    decoration: new InputDecoration(
                        labelText: "Enter filter detail",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        prefixIcon: Icon(FontAwesomeIcons.comment,color: this.color)
                    ),
                    validator: (filterdetail) {

                    },
                    onSaved: (filterdetail){
                      widget.filterdetail=filterdetail;
                    },
                    keyboardType: TextInputType.number,

                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),SizedBox(height: 20),
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
    String filtercode,
    String filtername ,
    String filterdetail,

  String price,
  String tocken,
  }) async {

    return http.put(
      'http://anasmansouri.ddns.net:8000/management/update_filter_info/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':'Token $tocken'
      },
      body: jsonEncode(<String, dynamic>{
          "filtercode": filtercode,
          "filtername":filtername,
          "price": price,
          "filterdetail": filterdetail
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
          submitInfo(tocken: widget.tocken,filtername:   widget.filtername,price: widget.price,filterdetail:  widget.filterdetail,filtercode: widget.filtercode,).then((onValue) async {
            print(json.decode(onValue.body).toString());
            if (json.decode(onValue.body).containsKey("error")){
              wrongInfo=true;
              wrongInfoMsg = json.decode(onValue.body)["error"].toString();
              setState(() {

              });
            }else if(json.decode(onValue.body).containsKey("filtercode")){
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