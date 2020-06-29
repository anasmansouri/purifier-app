import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_icons/line_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:purifiercompanyapp/global_constants/Constants.dart';

class ClientInfoDetails extends StatefulWidget {

  String tocken;
  String userId;
  ClientInfoDetails({this.tocken,this.userId});
  @override
  _ClientInfoDetailsState createState() => _ClientInfoDetailsState();
}

class _ClientInfoDetailsState extends State<ClientInfoDetails> {
  String email =" ";
  String contactName= " ";
  String mobileNumber= " ";
  bool good_internet_connexion=false;
  bool no_data_problem=false;
  static Color color =Colors.blue;
  TextStyle style = new TextStyle(fontSize: 20,color: color);

  Future<dynamic> get_client_info(String token) async {
    return http.get(
        Constants.server_ip+'security/accounts/'+widget.userId,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':'token $token'
        }
    );
  }

  Future<dynamic> client_info({String token}) async {
    var res = await get_client_info(token);
    var resBody = json.decode(res.body);
    print(resBody);
    return resBody;
  }

  @override
  void initState() {
    try {
      final result =  InternetAddress.lookup('google.com');
      result.then((result){
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
         this.good_internet_connexion=false;
        }
      });
    } on SocketException catch (_) {
      this.good_internet_connexion=true;
    }

    client_info(token: widget.tocken).then((value){
      print(value);
      this.email=value["user"]["email"];
      this.mobileNumber=value["mobile"];
      this.contactName=value["user"]["username"];
      setState(() {
        this.no_data_problem=true;
        this.good_internet_connexion=true;
      });

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    print("height "+height.toString()+"\nwidth "+width.toString());

    if(this.no_data_problem && this.good_internet_connexion){
      return Scaffold(backgroundColor: Colors.white,body: SingleChildScrollView(
          child: SafeArea(child: showInfo(email: this.email,mobile: this.mobileNumber,username: this.contactName,height:height,width: width))));
    }else{
      return SpinKitCircle(
        color: Colors.blue,
        size: 50.0,
      );
    }
  }

  Container showInfo({var height,var width,String email,String username,String mobile}){
    return Container(color: Colors.white,

        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: height/16,),
            Icon(Icons.perm_identity, size: 130, color: color,),
            SizedBox(height: height/16),
            SizedBox(height: height/40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[FlatButton.icon(
                icon: Icon(FontAwesomeIcons.idCard, color: color,
                ),
                label: Flexible(
                  child: Text(username,
                    style: style,softWrap: true,overflow: TextOverflow.ellipsis),
                ),
              )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[FlatButton.icon(
                icon: Icon(Icons.mail, color: color,
                ),
                label: Flexible(
                  child: Text(email,
                    style: style,softWrap: true,overflow: TextOverflow.ellipsis),
                ),
              ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[FlatButton.icon(
                icon: Icon(
                  FontAwesomeIcons.phone, color: color,
                ),
                label: Flexible(
                  child: Text(mobile,
                    style: style,softWrap: true,overflow: TextOverflow.ellipsis),
                ),
              ),
              ],
            ),
          ],
        )
    );
  }
}
