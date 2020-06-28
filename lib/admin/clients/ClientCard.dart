import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:purifiercompanyapp/admin/clients/ClientDetails.dart';

class ClientCard extends StatefulWidget {
  String username ;
  String mobile ;
  String joindate;
  String tocken;
  String email;
  String billingaddress1;
  String billingaddress2;
  bool is_confirmed;
  Color color =Colors.blue;
  ClientCard({this.mobile,this.username,this.joindate,this.tocken,this.email,this.billingaddress1,this.billingaddress2,this.is_confirmed});

  @override
  _ClientCardState createState() => _ClientCardState();
}

class _ClientCardState extends State<ClientCard> {
  static Color c = Colors.white;
  TextStyle styleLabel = TextStyle(color: c,fontSize: 20,fontWeight: FontWeight.w400);
  TextStyle styleData = TextStyle(color: c,fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>ClientDetails(username: widget.username,mobile: widget.mobile,email: widget.email,billingaddress1: widget.billingaddress1,billingaddress2: widget.billingaddress2,is_confirmed: widget.is_confirmed,))
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
                Row(children: <Widget>[
                  Icon(FontAwesomeIcons.user,color: Colors.white,)
                  ,SizedBox(width: 65,),
                  Text(widget.username .toString(),softWrap: true,style: styleData,overflow: TextOverflow.ellipsis)
                ],),SizedBox(height: 8,),
                Row(
                  children: <Widget>[
                  Icon(FontAwesomeIcons.mobileAlt,color: Colors.white,),SizedBox(width: 65,),
                    Text(widget.mobile,softWrap: true,style: styleData,overflow: TextOverflow.ellipsis)
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  children: <Widget>[
                    Icon(FontAwesomeIcons.calendarAlt,color: Colors.white,),SizedBox(width: 65,),
                    Text(widget.joindate,softWrap: true,style: styleData,overflow: TextOverflow.ellipsis)
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
}
