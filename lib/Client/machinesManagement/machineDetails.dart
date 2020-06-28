import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_icons/line_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
class MachineDetails extends StatefulWidget {

  String machineId;
  String main_pack_package_code;
  String location;
  String mac;
  String producttype;
  String nextservicedate;


  MachineDetails({this.machineId,this.main_pack_package_code,this.location,this.mac,this.producttype,this.nextservicedate});
  @override
  _MachineDetailsState createState() => _MachineDetailsState();
}

class _MachineDetailsState extends State<MachineDetails> {
  static Color color =Colors.blue;
  TextStyle style = new TextStyle(fontSize: 20,color: color);
  Map<String, String> typeOfMachine = {'WPU': 'Water Purifier', 'U': 'Under Sink', 'F': 'Filter'};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Colors.white,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 60,),
                  Icon(FontAwesomeIcons.cogs, size: 130, color: color,),
                  SizedBox(height: 50,),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[Flexible(child: FlatButton.icon(
                  icon: Icon(FontAwesomeIcons.idCard, color: color,
                  ),
                  label: Flexible(
                    child: Text(widget.machineId,
                    style: style,softWrap: true,overflow: TextOverflow.ellipsis),
                  ),
                  ))
                  ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: <Widget>[Flexible(
                      child: FlatButton.icon(

                        icon: Icon(FontAwesomeIcons.robot, color: color,
                        ),
                        label: Flexible(
                          child: Text(typeOfMachine[widget.producttype] ,
                            style: style,softWrap: true,overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: <Widget>[Flexible(child : FlatButton.icon(
                      icon: Icon(
                        FontAwesomeIcons.tools, color: color,
                      ),
                      label: Flexible(
                        child: Text(widget.nextservicedate,
                          style: style,softWrap: true,overflow: TextOverflow.ellipsis),
                      ),
                    )),
                    ],
                  ),Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: <Widget>[Flexible(
                      child: FlatButton.icon(
                          icon: Icon(FontAwesomeIcons.passport, color: color,
                          ),
                          label: Flexible(
                            child: Text(widget.mac,
                              style: style,softWrap: true,overflow: TextOverflow.ellipsis),
                          ),
                        ),
                    )
                      ],
                  ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[Flexible(child:FlatButton.icon(
                          icon: Icon(
                            FontAwesomeIcons.mapMarkerAlt, color: color,
                          ),
                          label: Flexible(child:  Text(widget.location,
                            softWrap: true,
                            style: new TextStyle(fontSize: 20,color: color),overflow: TextOverflow.ellipsis),)
                        )),
                        ],
                      ),

                ],
              )
          ),
        ),
      ),
    );;
  }
}
