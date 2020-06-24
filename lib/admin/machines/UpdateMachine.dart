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


class UpdateMachine extends StatefulWidget {
  String machineid;
  String tocken;
  String installaddress1 ;
  String installaddress2;
  String userId;
  String nextservicedate;

  UpdateMachine({this.nextservicedate,this.tocken,this.installaddress1,this.userId,this.installaddress2,this.machineid});
  @override
  _UpdateMachineState createState() => _UpdateMachineState();
}

class _UpdateMachineState extends State<UpdateMachine> {

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

    var arr = widget.nextservicedate.split('-');
    String year = arr[0];
    String month=arr[1];
    String day = arr[2];
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
                    initialValue: widget.installaddress1,
                    decoration: new InputDecoration(
                        labelText: "Enter installation adresse 1",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        prefixIcon: Icon(FontAwesomeIcons.mapMarkerAlt,color: this.color)
                    ),
                    // ignore: missing_return
                    validator: (installaddress1) {
                      if((installaddress1==null)||(installaddress1.isEmpty)) {
                        return "Please Enter installation adresse 1";
                      }
                    },
                    onSaved: (installaddress1){
                     widget.installaddress1=installaddress1;
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),SizedBox(height: 20),
                  new TextFormField(
                    initialValue: widget.installaddress2,
                    decoration: new InputDecoration(
                        labelText: "Enter installation adresse 2",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        prefixIcon: Icon(FontAwesomeIcons.signature,color: this.color)
                    ),
                    // ignore: missing_return
                    validator: (installaddress2) {

                    },
                    onSaved: (installaddress2){
                      widget.installaddress2=installaddress2;
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                  height: 80,
                  child: CupertinoDatePicker(
                    initialDateTime: DateTime(int.parse(year),int.parse(month),int.parse(day)),
                    use24hFormat: true,
                    maximumDate: DateTime(2100),
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (datetime){
                      setState(() {
                        widget.nextservicedate = datetime.year.toString()+'-'+datetime.month.toString()+'-'+datetime.day.toString();
                      });
                    },
                    backgroundColor: Colors.white,
                   ),
                  ),
                  SizedBox(height: 20),
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
    String machineid,
    String installaddress1 ,
    String installaddress2,
    String nextservicedate,
    String tocken,
  }) async {
    return http.put(
      'http://anasmansouri.ddns.net:8000/management/update_machine_info/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':'Token $tocken'
      } ,
      body: jsonEncode(<String, dynamic>{
          "machineid":machineid ,
          "installaddress1":installaddress1,
          "installaddress2": installaddress2,
          "nextservicedate": widget.nextservicedate
        }
      ),
    );
  }
  Future<void> submit() async {
    if (formKey.currentState.validate()){
      formKey.currentState.save();
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print('connected');
          good_internet=true;
          submitInfo(tocken: widget.tocken,installaddress2:widget.installaddress2,nextservicedate:  widget.nextservicedate,machineid:  widget.machineid,installaddress1:  widget.installaddress1,).then((onValue) async {
            if (json.decode(onValue.body).containsKey("error")){
              wrongInfo=true;
              wrongInfoMsg = json.decode(onValue.body)["error"].toString();
              setState(() {

              });
            }else if(json.decode(onValue.body).containsKey("machineid")){
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