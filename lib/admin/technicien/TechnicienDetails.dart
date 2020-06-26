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
import 'package:purifiercompanyapp/admin/technicien/UpdateTechnicien.dart';
class TechnicienDetails extends StatefulWidget {

  String staffcode ;
  String staffshort ;
  String staffname;
  String tocken;
  String staffcontact;
  String email;
  String userId;

  TechnicienDetails({this.staffcode,this.email,this.staffshort,this.staffcontact,this.staffname,this.tocken,this.userId});
  @override
  _TechnicienDetailsState createState() => _TechnicienDetailsState();
}

class _TechnicienDetailsState extends State<TechnicienDetails> {
  static Color color =Colors.blue;
  TextStyle style = new TextStyle(fontSize: 20,color: color);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                              SizedBox(height: 50,),
                              Icon(FontAwesomeIcons.userCog, size: 130, color: color,),
                              SizedBox(height: 50),
                              SizedBox(height: 20,),
                              Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[FlatButton.icon(
                                                          icon: Icon(FontAwesomeIcons.idCard, color: color,
                                                          ),
                                                          label: Text(widget.staffcode,
                                                          style: style,),
                                                          )
                                    ],
                              ),
                              Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[FlatButton.icon(
                                                        icon: Icon(Icons.mail, color: color,
                                                        ),
                                                        label: Text(widget.email,
                                                        style: style,),
                                                        ),
                                    ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[FlatButton.icon(
                                  icon: Icon(
                                    FontAwesomeIcons.user, color: color,
                                  ),
                                  label: Text(widget.staffname,
                                    style: style,),
                                ),
                                ],
                              ),SizedBox(height: 20,),
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
                                    MaterialPageRoute(builder: (context) =>UpdateTechnicien(tocken: widget.tocken,staffshort: widget.staffshort,
                                    staffname: widget.staffname,staffcontact: widget.staffcontact,staffcode: widget.staffcode,
                                    email: widget.email,userId:widget.userId))
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
                      ));
  }
}
