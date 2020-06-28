import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_icons/line_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:purifiercompanyapp/admin/filters/UpdateFilter.dart';
import 'package:purifiercompanyapp/admin/machines/UpdateMachine.dart';
import 'package:purifiercompanyapp/admin/technicien/UpdateTechnicien.dart';
class MachineDetails extends StatefulWidget {

  String machineid ;
  String installaddress1 ;
  String photoncode ;
  String mac ;
  String main_pack ;
  String installdate ;
  String nextservicedate ;
  String producttype ;
  String price ;
  String tocken;
  String username;
  String userId;
  String installaddress2;

  MachineDetails({this.username,this.installaddress2,this.producttype,this.price,this.tocken,this.userId,this.nextservicedate,this.mac,this.machineid,this.photoncode,this.main_pack,this.installdate,this.installaddress1});
  @override
  _MachineDetailsState createState() => _MachineDetailsState();
}

class _MachineDetailsState extends State<MachineDetails> {
  static Color color =Colors.blue;
  TextStyle style = new TextStyle(fontSize: 20,color: color);

  Widget  managementofFilterdetails(){
    if (widget.installaddress2.isEmpty){
      return SizedBox();
    }else{
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Flexible(
          child: FlatButton.icon(
            icon: Icon(
              FontAwesomeIcons.mapMarkerAlt, color: color,
            ),
            label: Text(widget.installaddress2,
              style: style,overflow: TextOverflow.ellipsis,),
          ),
        ),
        ],
      );
    }
  }

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
                            children: <Widget>[
                                    SizedBox(height: 50,),
                                    Icon(FontAwesomeIcons.robot, size: 130, color: color,),
                                    SizedBox(height: 50),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget> [Flexible(child: FlatButton.icon(
                                  icon: Icon(FontAwesomeIcons.user, color: color,
                                  ),
                                  label: Flexible(
                                    child: Text(widget.username,
                                      style: style,softWrap: true,overflow: TextOverflow.ellipsis),
                                  ),
                                )),
                                ],
                              ),
                                    Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[Flexible(
                                            child: FlatButton.icon(
                                                                  icon: Icon(FontAwesomeIcons.idCard, color: color,
                                                                  ),
                                                                  label: Flexible(
                                                                    child: Text(widget.machineid,
                                                                    style: style,softWrap: true,overflow: TextOverflow.ellipsis),
                                                                  ),
                                                                  ),
                                          )
                                          ],
                                    ),Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[Flexible(child : FlatButton.icon(
                                          icon: Icon(
                                            FontAwesomeIcons.inbox, color: color,
                                          ),
                                          label: Flexible(
                                            child: Text(widget.main_pack,
                                              style: style,softWrap: true,overflow: TextOverflow.ellipsis),
                                          ),
                                        )),
                                        ],
                                      ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[Flexible(
                                        child: FlatButton.icon(
                                          icon: Icon(
                                            FontAwesomeIcons.moneyBill, color: color,
                                          ),
                                          label: Flexible(
                                            child: Text(widget.price,
                                              style: style,softWrap: true,overflow: TextOverflow.ellipsis),
                                          ),
                                        ),
                                      ),
                                      ],
                                    ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[Flexible(
                                  child: FlatButton.icon(
                                    icon: Icon(
                                      FontAwesomeIcons.hourglassStart, color: color,
                                    ),
                                    label: Flexible(
                                      child: Text(widget.installdate,
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
                                    FontAwesomeIcons.hourglassEnd, color: color,
                                  ),
                                  label: Flexible(
                                    child: Text(widget.nextservicedate,
                                      style: style,softWrap: true,overflow: TextOverflow.ellipsis),
                                  ),
                                )),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[Flexible(
                                  child: FlatButton.icon(
                                    icon: Icon(
                                      FontAwesomeIcons.signature, color: color,
                                    ),
                                    label: Flexible(
                                      child: Text(widget.mac,
                                        style: style, softWrap: true,overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[Flexible(
                                  child: FlatButton.icon(
                                    icon: Icon(
                                      FontAwesomeIcons.mapMarkerAlt, color: color,
                                    ),
                                    label: Flexible(
                                      child: Text(widget.installaddress1,
                                        style: style,softWrap: true,overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ),
                                ],
                              ),
                              managementofFilterdetails(),


                              Center(
                                  child:ProgressButton(
                                    borderRadius: 20,
                                    color: color,
                                    defaultWidget: const Text('Update',
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
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>UpdateMachine(tocken: widget.tocken,installaddress1:  widget.installaddress1,
                                          machineid:   widget.machineid,nextservicedate:  widget.nextservicedate,installaddress2:   widget.installaddress2,
                                          userId:widget.userId,))
                                      );
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
                            )),
        ),
      ),
    );
  }
}
