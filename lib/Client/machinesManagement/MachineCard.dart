import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:purifiercompanyapp/Client/machinesManagement/machineDetails.dart';
import 'package:purifiercompanyapp/personalInfo/PersonalInformations.dart';

class ClientInfo extends StatefulWidget {
  String machineID ;
  String producttype ;
  String nextservicedate ;
  String location;
  String main_pack_package_code;
  String mac;

  Color color =Colors.blue;
  ClientInfo({this.machineID,this.location,this.producttype,this.nextservicedate,this.main_pack_package_code,this.mac});

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
        MaterialPageRoute(builder: (context) => MachineDetails(machineId: widget.machineID,location: widget.location,producttype: widget.producttype,nextservicedate: widget.nextservicedate,main_pack_package_code: widget.main_pack_package_code,mac: widget.mac,)),
      );
      },
      child: Container(
          height: 110,
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
                Row(
                  children: <Widget>[
                   Icon(FontAwesomeIcons.idCard,
                      color: Colors.white,),
                    SizedBox(width: 65,),
                    Text(widget.machineID,style: styleData,)
                  ],
                ),SizedBox(height: 8,),
                Row(children: <Widget>[
                  Icon(FontAwesomeIcons.robot,color: Colors.white,)
                  ,SizedBox(width: 65,),
                  Text(widget.producttype.toString(),style: styleData,)
                ],),SizedBox(height: 8,),
                Row(
                  children: <Widget>[
                  Icon(FontAwesomeIcons.tools,color: Colors.white,),SizedBox(width: 65,),
                    Text(widget.nextservicedate,style: styleData,)
                  ],
                )
              ],
            ),
          )
      ),
    );
  }
}
