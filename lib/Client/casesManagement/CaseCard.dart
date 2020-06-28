import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:purifiercompanyapp/Client/casesManagement/caseDetails.dart';

class CaseCard extends StatefulWidget {

  String casetype ;
  String scheduledate ;
  var listMachines;


  Color color =Colors.blue;
  CaseCard({this.casetype,this.scheduledate,this.listMachines});

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
        MaterialPageRoute(builder: (context) => CaseDetails(casetype:widget.casetype,scheduledate: widget.scheduledate,listMachines:widget.listMachines,)  ));
      },
      child: Container(
          height: 90,
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
               SizedBox(height: 8,),
                Row(children: <Widget>[
                    Icon(FontAwesomeIcons.screwdriver,color: Colors.white,)
                  ,SizedBox(width: 65,),
                  Text(widget.casetype.toString(),softWrap: true,style: styleData,overflow: TextOverflow.ellipsis)
                ],),SizedBox(height: 8,),
                Row(
                  children: <Widget>[
                  Icon(FontAwesomeIcons.calendarAlt,color: Colors.white,),
                    SizedBox(width: 65,),
                    Text(widget.scheduledate,softWrap: true,style: styleData,overflow: TextOverflow.ellipsis)
                  ],
                )
              ],
            ),
          )
      ),
    );
  }
}
