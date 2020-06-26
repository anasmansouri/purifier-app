import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// to test if it is an email
import 'package:email_validator/email_validator.dart';

//test json

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:toast/toast.dart';

class CreateCase extends StatefulWidget {

  String tocken;
  List <String> techniciens ;
  List <String> machines ;
  List <String> filters;
  CreateCase({this.tocken,this.techniciens,this.machines,this.filters});
  @override
  _CreateCaseState createState() => _CreateCaseState();
}

class _CreateCaseState extends State<CreateCase> {

  final formKey = GlobalKey<FormState>();

  String scheduledate =DateTime.now().year.toString()+"-"+DateTime.now().month.toString()+"-"+DateTime.now().day.toString();
  String time=DateTime.now().hour.toString()+":"+DateTime.now().toString();
  String action;
  String suggest;
  String comment;
  String iscompleted;
  String handledby;
  List filters;
  List machines;

  Color color = Colors.blue;
  bool wrongInfo =false;
  bool good_internet= true;
  String wrongInfoMsg=" ";


  String caseType="Filter replacement";
  String technicien_id_choosen="";
  List <String> machines_choosen=new List<String>();
  List <String> filter_choosen=new List<String>();

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
  void initState() {
    super.initState();
    // main_pack_id = widget.main_packs[0];
    // user_name_choosen =widget.user_names[0]["username"];

  }


  //
  @override
  Widget build(BuildContext context)  {
    List <String>usernames = new List<String> ();
      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView( // hadi 7lina biha l mouchkil dyal l clavier kayghati l boutounate
          child: SafeArea(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 30,),
                    Center(
                      child :  Icon(
                        FontAwesomeIcons.screwdriver,
                        color: this.color,
                        size: 130.0,
                      ),
                      //IconTheme
                    ),SizedBox(height: 20,),Center(child: Alert()),
                    SizedBox(height: 60,),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 10),
                        Text("case type ",
                          style: new TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 17
                          ),),
                        SizedBox(width: 60),
                        DropdownButton<String>(
                          value: this.caseType,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: color),
                          onChanged: (String newValue) {
                            setState(() {
                              this.caseType = newValue;
                            });
                          },
                          items: <String>['Filter replacement', 'Urgent Repair',
                            'Installation','Checking']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 10),
                        Text("technicien ",
                          style: new TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 17
                          ),),
                        SizedBox(width: 60),
                        DropdownButton<String>(
                          value: technicien_id_choosen.isEmpty ? widget.techniciens[0] : technicien_id_choosen,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: color),
                          onChanged: (String newValue) {
                            setState(() {
                              technicien_id_choosen = newValue;
                            });
                          },
                          items: widget.techniciens
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 10),
                        Text("machines id ",
                          style: new TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 17
                          ),),
                        SizedBox(width: 60),
                        DropdownButton<String>(
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: color),
                          onChanged: (String newValue) {
                            setState(() {
                              machines_choosen.add(newValue);
                              widget.machines.remove(newValue);
                              Toast.show("the machine with the id "+newValue+" has been added to the case", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                            });
                          },
                          items: widget.machines.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 10),
                        Text("filter id ",
                          style: new TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 17
                          ),),
                        SizedBox(width: 60),
                        DropdownButton<String>(
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: color),
                          onChanged: (String newValue) {
                            setState(() {
                              filter_choosen.add(newValue);
                              widget.filters.remove(newValue);
                              Toast.show("the filter with the id "+newValue+" has been added to the case", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                            });
                          },
                          items: widget.filters.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),

                    new TextFormField(
                      decoration: new InputDecoration(
                          labelText: "Enter action ",
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
                        this.action=action;
                      },
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),SizedBox(height: 20),
                    new TextFormField(
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
                        this.suggest=suggest;
                      },
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                    SizedBox(height: 20,),
                    new TextFormField(
                      decoration: new InputDecoration(
                          labelText: "Enter comment",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                          ),
                          prefixIcon: Icon(FontAwesomeIcons.comment,color: this.color)
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
                    ),
                    SizedBox(height: 20,),

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
                            this.scheduledate =datetime.year.toString()+"-"+
                                datetime.month.toString()+"-"+
                                datetime.day.toString();
                          });
                        },
                      ),
                    ),
                    SizedBox(height:20 ,),
                    Text("time",style: new TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 20
                    ),),
                    SizedBox(
                      height: 80,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        use24hFormat: true,
                        maximumDate: DateTime(2100),
                        minimumDate: DateTime.now(),
                        onDateTimeChanged: (datetime){
                          setState(() {
                            this.time = datetime.hour.toString()+":"+datetime.hour.toString();
                          });
                        },
                      ),
                    ),
                    SizedBox(height:20 ,),
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


                    ),SizedBox(height: 40,),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }

  Future<http.Response> submitInfo({
    String caseType="Filter replacement",
    String scheduledate ,
    String time,
    String action,
    String suggest,
    String comment,
    String iscompleted,
    String handledby,
    String technicien_id_choosen,
    List <String> machines_choosen,
    List <String> filter_choosen,
   


    String tocken
  }) async {

    List  machine_ids=new List();
    List filters_ids = new List();
    machines_choosen.forEach((m)=>machine_ids.add({"machineid":m}));
    filter_choosen.forEach((f)=> filters_ids.add({"filtercode":f}));
    if(technicien_id_choosen.isEmpty){
      technicien_id_choosen = widget.techniciens[0];
    }

    return http.post(
      'http://anasmansouri.ddns.net:8000/management/Cases/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':'Token $tocken'
      },
      body: jsonEncode(<String, dynamic>{
          "handledby": {
            "staffcode":technicien_id_choosen
            },
          "machines":machine_ids,
          "filters":filters_ids,
          "casetype":caseType,
          "scheduledate":scheduledate,
          "time":time,
          "action":action,
        "suggest" :suggest,
        "comment" : comment,
        "iscompleted":"False"
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
          if(this.machines_choosen.isEmpty){
            wrongInfoMsg="please choose a machine";
            wrongInfo=true;
            setState(() {

            });
          }else{

          submitInfo(tocken: widget.tocken,comment: this.comment,action: this.action,caseType: this.caseType,filter_choosen: this.filter_choosen,
          handledby: this.handledby,machines_choosen: this.machines_choosen,scheduledate: this.scheduledate,suggest: this.suggest,
          technicien_id_choosen: this.technicien_id_choosen,time: this.time).then((onValue) async {
            print(json.decode(onValue.body).toString());

            if (json.decode(onValue.body).containsKey("error")){
              wrongInfo=true;
              wrongInfoMsg = json.decode(onValue.body)["error"].toString();
              setState(() {

              });
            }else if(json.decode(onValue.body).containsKey("casetype")){
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
        }}
      } on SocketException catch (_) {
        print('not connected');
        setState(() {
          good_internet= false;
        });
      }
    }
  }
  }