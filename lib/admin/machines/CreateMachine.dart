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

import 'package:purifiercompanyapp/global_constants/Constants.dart';


class CreateMachine extends StatefulWidget {

  String tocken;
  List user_names;
  List <String>main_packs;
  CreateMachine({this.tocken,this.user_names,this.main_packs});
  @override
  _CreateMachineState createState() => _CreateMachineState();
}

class _CreateMachineState extends State<CreateMachine> {

  final formKey = GlobalKey<FormState>();
  String machineid ;
  String installaddress1 ;
  String photoncode ;
  String mac ;
  String main_pack ;
  String installdate ;
  String nextservicedate ;
  String producttype ="F";
  int price ;
  String username;
  String userId;
  String installaddress2;
  Color color = Colors.blue;
  bool wrongInfo =false;
  bool good_internet= true;
  String wrongInfoMsg=" ";

  List main_pack_ids;
  String user_name_choosen;
  String user_id_choosen;
  String main_pack_id;
  DateTime _installdate;
  DateTime _next_service_date;


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
  void initState() {
    super.initState();
    main_pack_id = widget.main_packs[0];
    user_name_choosen =widget.user_names[0]["username"];

  }


  //
  @override
  Widget build(BuildContext context)  {
    List <String>usernames = new List<String> ();
    widget.user_names.forEach((f)=>usernames.add(f["username"]));

    for(int i=0;i<widget.user_names.length;i++){
      if(widget.user_names[i]["username"]== user_name_choosen){
        user_id_choosen = widget.user_names[i]["id"].toString();
      }
    }

      return Scaffold(
        backgroundColor: Colors.white,
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
                        FontAwesomeIcons.robot,
                        color: this.color,
                        size: 130.0,
                      ),
                      //IconTheme
                    ),Center(child: Alert()),
                    SizedBox(height: 60,),
                    new TextFormField(
                      decoration: new InputDecoration(
                          labelText: "Enter machine id",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                          ),
                          prefixIcon: Icon(FontAwesomeIcons.idCard,color: this.color)
                      ),
                      // ignore: missing_return
                      validator: (machineid) {
                        if((machineid==null)||(machineid.isEmpty)) {
                          return "Please Enter machine id ";
                        }
                      },
                      onSaved: (machineid){
                        this.machineid=machineid;
                      },
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                    SizedBox(height: 20),
                    new TextFormField(
                      decoration: new InputDecoration(
                          labelText: "Enter install address1 ",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                          ),
                          prefixIcon: Icon(FontAwesomeIcons.mapMarkerAlt,color: this.color)
                      ),
                      // ignore: missing_return
                      validator: (address1) {
                        if((address1==null)||(address1.isEmpty)) {
                          return "Enter install address1";
                        }
                      },
                      onSaved: (address1){
                        this.installaddress1=address1;
                      },
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),SizedBox(height: 20),
                    new TextFormField(
                      decoration: new InputDecoration(
                          labelText: "Enter instalation address 2",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                          ),
                          prefixIcon: Icon(FontAwesomeIcons.mapMarkerAlt,color: this.color)
                      ),
                      // ignore: missing_return
                      validator: (address2) {

                      },
                      onSaved: (adress2){
                        this.installaddress2=adress2;
                      },
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                    SizedBox(height: 20),
                    new TextFormField(
                      decoration: new InputDecoration(
                          labelText: "Enter mac address",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                          ),
                          prefixIcon: Icon(FontAwesomeIcons.signature,color: this.color)
                      ),
                      validator: (mac) {
                        if((mac==null)||(mac.isEmpty)) {
                          return "Enter mac address";
                        }
                      },
                      onSaved: (mac){
                        this.mac=mac;
                      },
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                    SizedBox(height:20 ,),
                    new TextFormField(
                      decoration: new InputDecoration(
                          labelText: "Enter price ",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                          ),
                          prefixIcon: Icon(FontAwesomeIcons.signature,color: this.color)
                      ),
                      validator: (price) {
                        if((price==null)||(price.isEmpty)) {
                          return "Enter price please";
                        }
                      },
                      onSaved: (price){
                        this.price= int.parse( price);
                      },
                      keyboardType: TextInputType.number,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 10),
                        Text("product type ",
                          style: new TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 17
                          ),),
                        SizedBox(width: 60),
                        DropdownButton<String>(
                          value: this.producttype,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: color),
                          onChanged: (String newValue) {
                            setState(() {
                              this.producttype = newValue;
                            });
                          },
                          items: <String>['WPU', 'U', 'F',]
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
                        Text("user id ",
                          style: new TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 17
                          ),),
                        SizedBox(width: 60),
                        DropdownButton<String>(
                          value: user_name_choosen,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: color),
                          onChanged: (String newValue) {
                            setState(() {
                              user_name_choosen = newValue;
                              for(int i=0;i<widget.user_names.length;i++){
                                if(widget.user_names[i]["username"]== user_name_choosen){
                                  user_id_choosen = widget.user_names[i]["id"].toString();
                                }
                              }
                            });
                          },
                          items: usernames
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
                        Text("main pack id ",
                          style: new TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 17
                          ),),
                        SizedBox(width: 60),
                        DropdownButton<String>(

                          value: main_pack_id,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: color),
                          onChanged: (String newValue) {
                            setState(() {
                              main_pack_id = newValue;
                            });
                          },
                          items: widget.main_packs.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),Text("install date ",style: new TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 20
                    ),),SizedBox(
                      height: 80,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        use24hFormat: true,
                        maximumDate: DateTime(2100),
                        minimumDate: DateTime.now(),
                        onDateTimeChanged: (datetime){
                          print(datetime);
                          setState(() {
                            _installdate =datetime;
                          });
                        },
                      ),
                    ),

                    SizedBox(height: 20,),Text("next service date ",style: new TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 20
                    ),),SizedBox(
                      height: 80,
                      child: CupertinoDatePicker(
                        use24hFormat: true,
                        maximumDate: DateTime(2100),
                        minimumDate: DateTime.now(),
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (datetime){
                          print(datetime);
                          setState(() {
                            _next_service_date = datetime;
                          });
                        },
                        backgroundColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 40,),


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
    String userId,
    String main_pack_id,
    String machineid ,
    String installaddress1,
    String installaddress2,
    String mac,
    DateTime installdate,
    String producttype,
    DateTime nextservicedate,
    int price,
    String tocken
  }) async {
    _installdate =DateTime.now();
    _next_service_date= DateTime.now();
    if (installdate == null){
      installdate = DateTime.now();
    }
    if (nextservicedate == null){
      nextservicedate= DateTime.now();
    }

    return http.post(
      Constants.server_ip+'management/Machines/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':'Token $tocken'
      },
      body: jsonEncode(<String, dynamic>{
          "user": userId,
          "main_pack":main_pack_id,
          "machineid": machineid,
          "installaddress1": installaddress1,
          "installaddress2":installaddress2,
          "mac":mac,
          "installdate":installdate.year.toString()+'-'+installdate.month.toString()+'-'+installdate.day.toString(),
          "nextservicedate":nextservicedate.year.toString()+'-'+nextservicedate.month.toString()+'-'+nextservicedate.day.toString(),
          "producttype":producttype,
          "price":price
        }
      ),
    );
  }



  Future<http.Response> updateMainPackPrice({
    String main_pack_id,
    int price,
    String tocken
  }) async {
    return http.put(
      Constants.server_ip+'management/update_main_pack_price/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':'Token $tocken'
      },
      body: jsonEncode(<String, dynamic>{
        "packagecode":main_pack_id,
        "price":price
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

          submitInfo(tocken: widget.tocken,price: this.price,machineid: this.machineid,nextservicedate:  _next_service_date,installaddress2:   this.installaddress2
          ,installaddress1: this.installaddress1,installdate: _installdate,mac: this.mac,main_pack_id:  main_pack_id,producttype: producttype,userId:  user_id_choosen).then((onValue) async {
            print(json.decode(onValue.body).toString());
            if (json.decode(onValue.body).containsKey("error")){
              wrongInfo=true;
              wrongInfoMsg = json.decode(onValue.body)["error"].toString();
              setState(() {

              });
            }else if(json.decode(onValue.body).containsKey("machineid")){
              wrongInfo=false;
              wrongInfoMsg="";
              updateMainPackPrice(tocken: widget.tocken,main_pack_id: main_pack_id,price: this.price).then((onValue){
                Navigator.pop(context,true);
              });
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