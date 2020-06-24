import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:purifiercompanyapp/admin/clients/ClientDetails.dart';
import 'package:purifiercompanyapp/admin/cases/CaseDetails.dart';
import 'package:purifiercompanyapp/admin/mainpack/MainPackDetails.dart';

class CaseCard extends StatefulWidget {
  String case_id;
  String casetype ;
  String scheduledate ;
  String time;
  String action;
  String suggest;
  String comment;
  bool iscompleted;
  String handledby;
  List filters;
  List machines;
  String tocken;

  String userId;
  Color color =Colors.blue;
  CaseCard({this.comment,this.scheduledate,this.casetype,this.tocken,
    this.userId,this.action,this.filters,
  this.handledby,this.iscompleted,this.machines,this.suggest,this.time,this.case_id});

  @override
  _CaseCardState createState() => _CaseCardState();
}

class _CaseCardState extends State<CaseCard> {
  static Color c = Colors.white;
  TextStyle styleLabel = TextStyle(color: c,fontSize: 20,fontWeight: FontWeight.w400);
  TextStyle styleData = TextStyle(color: c,fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>CaseDetails(tocken: widget.tocken,
          time:  widget.time,suggest:   widget.suggest,machines:  widget.machines,
          iscompleted:  widget.iscompleted,userId: widget.userId,
          handledby: widget.handledby,filters: widget.filters,
          comment: widget.comment,action: widget.action,casetype: widget.casetype,
          scheduledate: widget.scheduledate,case_id: widget.case_id,))
      );
      },
      child: Container(
          height: 115,
          margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
          decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0)
              )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 8, 0, 8),
            child: Column(
              children: <Widget>[
                Row(children: <Widget>[
                  Icon(FontAwesomeIcons.calendarAlt,color: Colors.white,)
                  ,SizedBox(width: 65,),
                  Text(widget.scheduledate .toString(),style: styleData,)
                ],),SizedBox(height: 8,),
                Row(
                  children: <Widget>[
                    Icon(FontAwesomeIcons.userCog,color: Colors.white,),SizedBox(width: 65,),
                    Text(widget.handledby.toString(),style: styleData,)
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  children: <Widget>[
                    Icon(FontAwesomeIcons.mapMarkerAlt,color: Colors.white,),SizedBox(width: 65,),
                    Text(widget.machines[0]["installaddress1"],style: styleData,)
                  ],
                ),
                SizedBox(height: 8,),

              ],
            ),
          )
      ),
    );
  }
}
