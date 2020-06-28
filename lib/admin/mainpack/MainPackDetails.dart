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
import 'package:purifiercompanyapp/admin/mainpack/UpdateMainPack.dart';
import 'package:purifiercompanyapp/admin/technicien/UpdateTechnicien.dart';
class MainPackDetails extends StatefulWidget {

  String packagecode ;
  bool isbytime ;
  bool isbyusage;
  String tocken;
  String price;
  String exfiltermonth;
  String exfiltervolume;
  String packagedetail;
  String userId;

  MainPackDetails({this.userId,this.packagecode,this.isbytime,this.isbyusage,this.exfiltermonth,this.exfiltervolume,this.tocken,this.price,this.packagedetail});
  @override
  _MainPackDetailsState createState() => _MainPackDetailsState();
}

class _MainPackDetailsState extends State<MainPackDetails> {
  static Color color =Colors.blue;
  TextStyle style = new TextStyle(fontSize: 20,color: color);

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
                                    Icon(Icons.inbox, size: 130, color: color,),
                                    SizedBox(height: 50),
                                    SizedBox(height: 20,),
                                    Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[Flexible(
                                            child: FlatButton.icon(
                                                                  icon: Icon(FontAwesomeIcons.idCard, color: color,
                                                                  ),
                                                                  label: Flexible(
                                                                    child: Text(widget.packagecode,overflow: TextOverflow.ellipsis,softWrap: true,
                                                                    style: style,),
                                                                  ),
                                                                  ),
                                          )
                                          ],
                                    ),
                                    Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[Flexible(child: FlatButton.icon(
                                                              icon: Icon(FontAwesomeIcons.coins, color: color,
                                                              ),
                                                              label: Flexible(
                                                                child: Text(widget.price,overflow: TextOverflow.ellipsis,
                                                                style: style,softWrap: true,),
                                                              ),
                                                              )),
                                          ],
                                    ),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[Flexible(
                                        child: FlatButton.icon(
                                          icon: Icon(
                                            FontAwesomeIcons.prescriptionBottle, color: color,
                                          ),
                                          label: Flexible(
                                            child: Text(widget.exfiltervolume,
                                              style: style,overflow: TextOverflow.ellipsis,softWrap: true,),
                                          ),
                                        ),
                                      ),
                                      ],
                                    ),SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[Flexible(child: FlatButton.icon(
                                  icon: Icon(
                                    FontAwesomeIcons.hourglassHalf, color: color,
                                  ),
                                  label: Flexible(
                                    child: Text(widget.exfiltermonth,
                                      style: style,softWrap: true,overflow: TextOverflow.ellipsis),
                                  ),
                                )),
                                ],
                              ),SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[Flexible(
                                  child: FlatButton.icon(
                                    icon: Icon(
                                      FontAwesomeIcons.hourglassEnd, color: color,
                                    ),
                                    label: Flexible(
                                      child: Text(widget.isbytime.toString(),
                                        style: style,softWrap: true,overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ),
                                ],
                              ),SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[Flexible(child: FlatButton.icon(
                                  icon: Icon(
                                    FontAwesomeIcons.batteryEmpty, color: color,
                                  ),
                                  label: Flexible(
                                    child: Text(widget.isbyusage.toString(),
                                      style: style,softWrap: true,overflow: TextOverflow.ellipsis),
                                  ),
                                )),
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
                                          MaterialPageRoute(builder: (context) =>UpdateMainPack(tocken: widget.tocken,exfiltervolume:  widget.exfiltervolume,
                                          packagecode:  widget.packagecode,packagedetail:  widget.packagedetail,price:  widget.price,
                                          isbyusage:  widget.isbyusage,isbytime: widget.isbytime,exfiltermonth: widget.exfiltermonth,userId:widget.userId))
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
