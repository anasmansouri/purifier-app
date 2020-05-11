import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:purifiercompanyapp/personalInfo/PersonalInformations.dart';

class ClientInfo extends StatefulWidget {
  String name ;
  String mail;
  int water_purifier_number ;
  String date ;
  ClientInfo({this.name,this.mail,this.water_purifier_number,this.date});

  @override
  _ClientInfoState createState() => _ClientInfoState();
}

class _ClientInfoState extends State<ClientInfo> {
  static Color c = Colors.white;
  TextStyle styleLabel = TextStyle(color: c,fontSize: 20,fontWeight: FontWeight.w400);
  TextStyle styleData = TextStyle(color: c,fontSize: 20);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PersonalInformations(email: widget.mail)),
      );
      },
      child: Container(
          height: 150,
          margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
          decoration: BoxDecoration(
              color: Colors.deepPurple,
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
                Row(
                  children: <Widget>[
                   Icon(FontAwesomeIcons.idCard,
                      color: Colors.white,),
                    SizedBox(width: 65,),
                    Text(widget.name,style: styleData,)
                  ],
                ),SizedBox(height: 8,),
                Row(children: <Widget>[
                  Icon(FontAwesomeIcons.handHoldingWater,color: Colors.white,)
                  ,SizedBox(width: 65,),
                  Text(widget.water_purifier_number.toString(),style: styleData,)
                ],),SizedBox(height: 8,),
                Row(
                  children: <Widget>[
                  Icon(Icons.timer,color: Colors.white,),SizedBox(width: 65,),
                    Text(widget.date,style: styleData,)
                  ],
                ),SizedBox(height: 8,),
                Row(
                  children: <Widget>[
                  Icon(Icons.mail,color: Colors.white,),SizedBox(width: 65,),
                    Text(widget.mail,style: styleData,)
                  ],
                )
              ],
            ),
          )

      ),
    );
  }
}
