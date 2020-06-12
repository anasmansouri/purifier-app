import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_icons/line_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
class CaseDetails extends StatefulWidget {

  String casetype;
  String scheduledate;
  var listMachines;

  CaseDetails({this.casetype,this.scheduledate,this.listMachines});
  @override
  _CaseDetailsState createState() => _CaseDetailsState();
}

class _CaseDetailsState extends State<CaseDetails> {
  static Color color =Colors.blue;
  TextStyle style = new TextStyle(fontSize: 20,color: color);
  Map<String, String> typeOfMachine = {'WPU': 'Water Purifier', 'U': 'Under Sink', 'F': 'Filter'};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
          padding: EdgeInsets.fromLTRB(10, 200, 10, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(FontAwesomeIcons.screwdriver, size: 130, color: color,),
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Icon(FontAwesomeIcons.idCard,color: color,),
                  SizedBox(width: 20,),
                  Text(widget.casetype,style: style,)
                  ,
                ],
              ),SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Icon(FontAwesomeIcons.calendarAlt,color: color,),
                  SizedBox(width: 20,),
                  Text(widget.scheduledate,style: style,)
                ],
              ),SizedBox(height: 11,),Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  shrinkWrap: true,
                  itemCount:widget.listMachines.length,
                  itemBuilder: (BuildContext ctxt, int index) =>  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(FontAwesomeIcons.robot,color: Colors.blue,),
                      SizedBox(width: 20,),
                      Text(widget.listMachines[index]["machineid"],style: style,),
                      SizedBox(width: 20,),
                      Text(typeOfMachine[widget.listMachines[index]["producttype"]] ,style: style,),
                      SizedBox(height: 39,),
                    ],
                  ),
                ),
              ),
            ],
          )
      ),
    );;
  }
}
