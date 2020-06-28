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
import 'package:purifiercompanyapp/admin/technicien/UpdateTechnicien.dart';
class FilterDetails extends StatefulWidget {

  String filtercode ;
  String filtername ;
  String filterdetail;
  String tocken;
  String price;
  String userId;

  FilterDetails({this.filtername,this.filtercode,this.filterdetail,this.price,this.tocken,this.userId});
  @override
  _FilterDetailsState createState() => _FilterDetailsState();
}

class _FilterDetailsState extends State<FilterDetails> {
  static Color color =Colors.blue;
  TextStyle style = new TextStyle(fontSize: 20,color: color);
  Widget managementofFilterdetails(){
    if (widget.filterdetail.isEmpty){
      return SizedBox();
    }else{
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Flexible(child : FlatButton.icon(
          icon: Icon(
            FontAwesomeIcons.commentDots, color: color,
          ),
          label: Text(widget.filterdetail,
            style: style,softWrap: true,overflow: TextOverflow.ellipsis,),
        )),
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
                                    Icon(FontAwesomeIcons.filter, size: 130, color: color,),
                                    SizedBox(height: 50),
                                    Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[Flexible(
                                            child: FlatButton.icon(
                                                                  icon: Icon(FontAwesomeIcons.idCard, color: color,
                                                                  ),
                                                                  label: Flexible(
                                                                    child: Text(widget.filtercode,
                                                                    style: style,softWrap: true,overflow: TextOverflow.ellipsis),
                                                                  ),
                                                                  ),
                                          )
                                          ],
                                    ),
                                    Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[Flexible(child : FlatButton.icon(
                                                              icon: Icon(FontAwesomeIcons.signature, color: color,
                                                              ),
                                                              label: Flexible(
                                                                child: Text(widget.filtername,
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
                                          MaterialPageRoute(builder: (context) =>UpdateFilter(tocken: widget.tocken,filterdetail: widget.filterdetail,
                                          filtername:  widget.filtername,filtercode: widget.filtercode,price:  widget.price,
                                          userId:widget.userId))
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
