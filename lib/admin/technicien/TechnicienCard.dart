import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:purifiercompanyapp/admin/clients/ClientDetails.dart';

import 'TechnicienDetails.dart';

class TechnicienCard extends StatefulWidget {
  String staffcode ;
  String staffshort ;
  String staffname;
  String tocken;
  String staffcontact;
  String email;
  String userId;
  Color color =Colors.blue;
  TechnicienCard({this.staffcode,this.staffshort,this.staffname,this.tocken,this.staffcontact,this.email,this.userId});

  @override
  _TechnicienCardState createState() => _TechnicienCardState();
}

class _TechnicienCardState extends State<TechnicienCard> {
  static Color c = Colors.white;
  TextStyle styleLabel = TextStyle(color: c,fontSize: 20,fontWeight: FontWeight.w400);
  TextStyle styleData = TextStyle(color: c,fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
       Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>TechnicienDetails(email: widget.email,tocken: widget.tocken,staffcode: widget.staffcode,staffcontact: widget.staffcontact,staffname: widget.staffname,staffshort: widget.staffshort,userId:widget.userId))
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
                  Icon(FontAwesomeIcons.userCog,color: Colors.white,)
                  ,SizedBox(width: 65,),
                  Text(widget.staffname .toString(),softWrap: true,style: styleData,overflow: TextOverflow.ellipsis)
                ],),SizedBox(height: 8,),
                Row(
                  children: <Widget>[
                  Icon(Icons.email,color: Colors.white,),SizedBox(width: 65,),
                    Expanded(child: Text(widget.email,style: styleData,softWrap: true,overflow: TextOverflow.ellipsis,))
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  children: <Widget>[
                    Icon(FontAwesomeIcons.idCard,color: Colors.white,),SizedBox(width: 65,),
                    Text(widget.staffcode,style: styleData,softWrap: true,overflow: TextOverflow.ellipsis)
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
}
