import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_icons/line_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
class ClientDetails extends StatefulWidget {

  String username;
  String email;
  String mobile;
  String billingaddress1;
  String billingaddress2;
  bool is_confirmed;

  ClientDetails({this.username,this.email,this.mobile,this.billingaddress1,this.billingaddress2,this.is_confirmed});
  @override
  _ClientDetailsState createState() => _ClientDetailsState();
}

class _ClientDetailsState extends State<ClientDetails> {
  static Color color =Colors.blue;
  TextStyle style = new TextStyle(fontSize: 20,color: color);

  Widget managing_the_billing_adress2(){
    if (widget.billingaddress2.isEmpty){
      return SizedBox();
    }else{
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Flexible(child: FlatButton.icon(
          icon: Icon(
            FontAwesomeIcons.mapMarkerAlt, color: color,
          ),
          label: Flexible(
            child: Text(widget.billingaddress2,
              style: style,softWrap: true,overflow: TextOverflow.ellipsis),
          ),
        )),
        ],
      );

    }
  }
  Widget is_confirmed(){
      if (widget.is_confirmed){
        return SizedBox();
      }else{
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Flexible(
            child: FlatButton.icon(
              icon: Icon(
                FontAwesomeIcons.exclamationTriangle, color: color,
              ),
              label: Flexible(
                child: Text("email not verified",
                  style: style,softWrap: true,overflow: TextOverflow.ellipsis),
              ),
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
                                    Icon(Icons.perm_identity, size: 130, color: color,),
                                    SizedBox(height: 50),
                                    SizedBox(height: 20,),
                                    Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[Flexible(child :FlatButton.icon(
                                                                icon: Icon(FontAwesomeIcons.idCard, color: color,
                                                                ),
                                                                label: Flexible(
                                                                  child: Text(widget.username,
                                                                  style: style,softWrap: true,overflow: TextOverflow.ellipsis),
                                                                ),
                                                                ))
                                          ],
                                    ),
                                    widget.email.isEmpty ?
                                    SizedBox():
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Flexible(
                                          child: FlatButton.icon(
                                            icon: Icon(Icons.mail, color: color,
                                            ),
                                            label:   Flexible(child:  Text(widget.email,
                                              style: style,softWrap: true,overflow: TextOverflow.ellipsis),),
                                          ),
                                        ),

                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[Flexible(child :FlatButton.icon(
                                        icon: Icon(
                                          FontAwesomeIcons.mapMarkerAlt, color: color,
                                        ),
                                        label: Flexible(
                                          child: Text(widget.billingaddress1,
                                            style: style,softWrap: true,overflow: TextOverflow.ellipsis),
                                        ),
                                      )),
                                      ],
                                    ),
                                    managing_the_billing_adress2(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[Flexible(
                                  child: FlatButton.icon(
                                    icon: Icon(
                                      FontAwesomeIcons.phone, color: color,
                                    ),
                                    label: Flexible(
                                      child: Text(widget.mobile,
                                        style: style,softWrap: true,overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ),
                                ],
                              ),
                              is_confirmed()

                            ],
                            )),
        ),
      ),
    );
  }
}
