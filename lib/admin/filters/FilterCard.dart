import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:purifiercompanyapp/admin/clients/ClientDetails.dart';
import 'package:purifiercompanyapp/admin/filters/FilterDetails.dart';
import 'package:purifiercompanyapp/admin/mainpack/MainPackDetails.dart';

class FilterCard extends StatefulWidget {

  String filtercode ;
  String filtername ;
  String filterdetail;
  String tocken;
  String price;
  String userId;
  Color color =Colors.blue;
  FilterCard({this.filtercode,this.filterdetail,this.filtername,this.tocken,this.price,this.userId});

  @override
  _FilterCardState createState() => _FilterCardState();
}

class _FilterCardState extends State<FilterCard> {
  static Color c = Colors.white;
  TextStyle styleLabel = TextStyle(color: c,fontSize: 20,fontWeight: FontWeight.w400);
  TextStyle styleData = TextStyle(color: c,fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
     Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>FilterDetails(tocken: widget.tocken,filtername: widget.filtername,filterdetail:  widget.filterdetail,filtercode:  widget.filtercode,price: widget.price,userId: widget.userId,))
      );
      },
      child: Container(
          height: 118,
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
                  Text(widget.filtercode .toString(),softWrap: true,style: styleData,overflow: TextOverflow.ellipsis)
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
                    Icon(FontAwesomeIcons.signature,color: Colors.white,),SizedBox(width: 65,),
                    Text(widget.filtername.toString(),softWrap: true,style: styleData,overflow: TextOverflow.ellipsis)
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
