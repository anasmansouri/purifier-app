import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_icons/line_icons.dart';
// avatar
import "../customiseWidgets/my_flutter_app_icons.dart" as water;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class Profile_Client extends StatefulWidget {

  String tocken;
  String userId;
  Profile_Client({this.tocken,this.userId});
  @override
  _Profile_ClientState createState() => _Profile_ClientState();
}

class _Profile_ClientState extends State<Profile_Client> {
  String email;
  String contactName;
  String mobileNumber;
  bool good_internet_connexion=false;
  bool no_data_problem=false;
  static Color color =Colors.blue;
  TextStyle style = new TextStyle(fontSize: 20,color: color);

  Future<dynamic> get_client_info(String token) async {
    return http.get(
        'http://192.168.1.10:8000/security/accounts/'+widget.userId,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':'token $token'
        }
    );
  }

  Future<dynamic> client_info({String token}) async {
    var res = await get_client_info(token);
    var resBody = json.decode(res.body);
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
      this.email=value["user"]["email"];
      this.mobileNumber=value["user"]["email"];
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

    if(this.no_data_problem && this.good_internet_connexion){
      return showInfo(this.email,this.contactName, this.mobileNumber);
    }else{
      return SpinKitCircle(
        color: Colors.blue,
        size: 50.0,
      );
    }
  }

  Container showInfo(String email,String username,String mobile){
    return Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50,),
            Icon(Icons.perm_identity, size: 130, color: color,),
            SizedBox(height: 50),

            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[FlatButton.icon(
                icon: Icon(FontAwesomeIcons.idCard, color: color,
                ),
                label: Text(username,
                  style: style,),
              )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[FlatButton.icon(
                icon: Icon(Icons.mail, color: color,
                ),
                label: Text(email,
                  style: style,),
              ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[FlatButton.icon(
                icon: Icon(
                  FontAwesomeIcons.handHoldingWater, color: color,
                ),
                label: Text(mobile,
                  style: style,),
              ),
              ],
            ),
          ],
        )
    );
  }
}
