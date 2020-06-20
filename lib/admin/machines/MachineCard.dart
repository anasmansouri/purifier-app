import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:purifiercompanyapp/admin/clients/ClientDetails.dart';
import 'package:purifiercompanyapp/admin/filters/FilterDetails.dart';
import 'package:purifiercompanyapp/admin/machines/MachineDetails.dart';
import 'package:purifiercompanyapp/admin/mainpack/MainPackDetails.dart';

class MachineCard extends StatefulWidget {

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
  Color color =Colors.blue;
  MachineCard({this.machineid,this.username,this.installaddress1,this.tocken,this.price,this.userId,this.mac,this.nextservicedate,this.producttype,this.installdate,this.main_pack,this.photoncode,this.installaddress2});

  @override
  _MachineCardState createState() => _MachineCardState();
}

class _MachineCardState extends State<MachineCard> {
  static Color c = Colors.white;
  TextStyle styleLabel = TextStyle(color: c,fontSize: 20,fontWeight: FontWeight.w400);
  TextStyle styleData = TextStyle(color: c,fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
     Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>MachineDetails(tocken: widget.tocken,main_pack:  widget.main_pack,machineid:   widget.machineid,mac:  widget.mac,price: widget.price,userId: widget.userId,installdate: widget.installdate,producttype: widget.producttype,installaddress1: widget.installaddress1,installaddress2: widget.installaddress2,photoncode: widget.photoncode,nextservicedate: widget.nextservicedate,username: widget.username,))
      );
      },
      child: Container(
          height: 180 ,
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
                  Icon(FontAwesomeIcons.idCard,color: Colors.white,)
                  ,SizedBox(width: 65,),
                  Text(widget.machineid .toString(),style: styleData,)
                ],),SizedBox(height: 8,),
                Row(
                  children: <Widget>[
                  Icon(FontAwesomeIcons.moneyBill,color: Colors.white,),SizedBox(width: 65,),
                    Text(widget.price.toString(),style: styleData,)
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  children: <Widget>[
                    Icon(FontAwesomeIcons.signature,color: Colors.white,),SizedBox(width: 65,),
                    Text(widget.mac.toString(),style: styleData,)
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  children: <Widget>[
                    Icon(FontAwesomeIcons.calendarAlt,color: Colors.white,),SizedBox(width: 65,),
                    Text(widget.nextservicedate.toString(),style: styleData,)
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  children: <Widget>[
                    Icon(FontAwesomeIcons.user,color: Colors.white,),SizedBox(width: 65,),
                    Text(widget.username.toString(),style: styleData,)
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
