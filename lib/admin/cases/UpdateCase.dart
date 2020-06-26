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


class UpdateCase extends StatefulWidget {

  String case_id;
  String scheduledate; // done
  String time; // done
  String action;  // done
  String suggest; // done
  String comment; // done
  bool iscompleted; // done
  String tocken;
  String userId;

  UpdateCase({this.case_id,this.tocken,this.time,this.userId,this.suggest,this.scheduledate,this.action,this.comment,this.iscompleted});
  @override
  _UpdateCaseState createState() => _UpdateCaseState();
}

class _UpdateCaseState extends State<UpdateCase> {

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

    var arr = widget.scheduledate.split('-');
    String year = arr[0];
    String month=arr[1];
    String day = arr[2];

    var arrTime = widget.time.split(':');
    String hour = arrTime[0];
    String min = arrTime[1];
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
                        FontAwesomeIcons.screwdriver,
                        color: this.color,
                        size: 130.0,
                      ),
                    //IconTheme
                  ),Center(child: Alert()),
                  SizedBox(height: 60,),
                  SizedBox(height: 20),
                  new TextFormField(
                    initialValue: widget.action,
                    decoration: new InputDecoration(
                        labelText: "Enter action",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        prefixIcon: Icon(FontAwesomeIcons.handRock,color: this.color)
                    ),
                    // ignore: missing_return
                    validator: (action) {

                    },
                    onSaved: (action){
                     widget.action=action;
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(height: 20),
                  new TextFormField(
                    initialValue: widget.suggest,
                    decoration: new InputDecoration(
                        labelText: "Enter suggest",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        prefixIcon: Icon(FontAwesomeIcons.comment,color: this.color)
                    ),
                    // ignore: missing_return
                    validator: (suggest) {

                    },
                    onSaved: (suggest){
                      widget.suggest=suggest;
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(height: 20),
                  new TextFormField(
                    initialValue: widget.comment,
                    decoration: new InputDecoration(
                        labelText: "Enter comment ",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        prefixIcon: Icon(FontAwesomeIcons.comment,color: this.color)
                    ),
                    // ignore: missing_return
                    validator: (comment) {

                    },
                    onSaved: (comment){
                      widget.comment=comment;
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 10),
                      Text("is completed ",
                        style: new TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 17
                        ),),
                      SizedBox(width: 60),
                      DropdownButton<String>(
                        value: widget.iscompleted.toString(),
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: color),
                        onChanged: (String newValue) {
                          setState(() {
                            
                            widget.iscompleted = (newValue=="true")? true:false;
                          });
                        },
                        items: ["true","false"].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text("scheduledate",style: new TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 20
                  ),),
                  SizedBox(
                    height: 80,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      use24hFormat: true,
                      maximumDate: DateTime(2100),
                      minimumDate: DateTime.now(),
                      onDateTimeChanged: (datetime){
                        print(datetime);
                        setState(() {
                          widget.scheduledate =datetime.year.toString()+"-"+
                              datetime.month.toString()+"-"+
                              datetime.day.toString();
                        });
                      },
                    ),
                  ),
                  SizedBox(height:20 ,),
                  SizedBox(height: 20),
                  Text("time",style: new TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 20
                  ),),
                  SizedBox(
                    height: 80,
                    child: CupertinoDatePicker(
                      initialDateTime: DateTime(int.parse(year),int.parse(month),int.parse(day),int.parse(hour),int.parse(min)),
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: true,

                      maximumDate: DateTime(2100),
                      minimumDate: DateTime.now(),
                      onDateTimeChanged: (datetime){
                        setState(() {
                          widget.time = datetime.hour.toString()+":"+datetime.hour.toString();
                        });
                      },
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
    String case_id,
    String scheduledate ,
    String time,
    String action,
    String suggest,
    String comment,
    bool iscompleted,
    String tocken,
  }) async {
    return http.put(
      'http://anasmansouri.ddns.net:8000/management/update_case_info/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':'Token $tocken'
      } ,
      body: jsonEncode(<String, dynamic>{
          "case_id":case_id ,
          "scheduledate":scheduledate,
          "time": time,
          "action": action,
          "suggest":suggest,
          "comment" : comment,
          "iscompleted" : iscompleted
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
          submitInfo(tocken: widget.tocken,
              time: widget.time,
              suggest:   widget.suggest,
              iscompleted:   widget.iscompleted,
              comment:  widget.comment,
              scheduledate: widget.scheduledate,
              action: widget.action,
              case_id: widget.case_id).then((onValue) async {
            if (json.decode(onValue.body).containsKey("error")){
              wrongInfo=true;
              wrongInfoMsg = json.decode(onValue.body)["error"].toString();
              setState(() {

              });
            }else if(json.decode(onValue.body).containsKey("case_id")){
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