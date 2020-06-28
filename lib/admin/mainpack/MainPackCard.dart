import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:purifiercompanyapp/admin/clients/ClientDetails.dart';
import 'package:purifiercompanyapp/admin/mainpack/MainPackDetails.dart';

class MainPackCard extends StatefulWidget {
  String packagecode ;
  bool isbytime ;
  bool isbyusage;
  String tocken;
  String price;
  String exfiltermonth;
  String exfiltervolume;
  String packagedetail;
  String userId;
  Color color =Colors.blue;
  MainPackCard({this.packagecode,this.isbytime,this.isbyusage,this.tocken,this.exfiltermonth,this.exfiltervolume,this.price,this.packagedetail,this.userId});

  @override
  _MainPackCardState createState() => _MainPackCardState();
}

class _MainPackCardState extends State<MainPackCard> {
  static Color c = Colors.white;
  TextStyle styleLabel = TextStyle(color: c,fontSize: 20,fontWeight: FontWeight.w400);
  TextStyle styleData = TextStyle(color: c,fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>MainPackDetails(tocken: widget.tocken,exfiltervolume: widget.exfiltervolume,packagecode: widget.packagecode,exfiltermonth: widget.exfiltermonth,isbytime: widget.isbytime,isbyusage: widget.isbyusage,packagedetail: widget.packagedetail,price: widget.price,userId: widget.userId,))
      );
      },
      child: Container(
          height: 145,
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
                  Text(widget.packagecode .toString(),softWrap: true,style: styleData,overflow: TextOverflow.ellipsis)
                ],),SizedBox(height: 8,),
                Row(
                  children: <Widget>[
                  Icon(FontAwesomeIcons.moneyBill,color: Colors.white,),SizedBox(width: 65,),
                    Text(widget.price.toString(),softWrap: true,style: styleData,overflow: TextOverflow.ellipsis)
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  children: <Widget>[
                    Icon(FontAwesomeIcons.hourglassHalf,color: Colors.white,),SizedBox(width: 65,),
                    Text(widget.exfiltermonth.toString(),softWrap: true,style: styleData,)
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  children: <Widget>[
                    Icon(FontAwesomeIcons.prescriptionBottle,color: Colors.white,),SizedBox(width: 65,),
                    Text(widget.exfiltervolume.toString(),softWrap: true,style: styleData,overflow: TextOverflow.ellipsis)
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
}
