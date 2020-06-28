// import 'package:cached_network_image/cached_network_image.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
// import 'package:flutter_ui_challenges/core/presentation/res/assets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:purifiercompanyapp/Client/update/changePassword.dart';
import 'package:http/http.dart' as http;
import 'package:purifiercompanyapp/global_constants/Constants.dart';
import 'package:toast/toast.dart';


import 'dart:async';
import 'dart:convert';
import 'dart:io';

class SettingsOnePage extends StatefulWidget {
  static final String path = "lib/src/pages/settings/settings1.dart";

  String token;
  String userId;
  SettingsOnePage({this.token,this.userId});
  @override
  _SettingsOnePageState createState() => _SettingsOnePageState();
}

class _SettingsOnePageState extends State<SettingsOnePage> {

  bool wrongInfo =false;
  bool good_internet= true;
  String wrongInfoMsg="";

  Widget Alert(){
    if(!good_internet){
      return Text("no internet connexion ",style: TextStyle(
          color: Colors.red,
          fontSize: 15
      ),overflow: TextOverflow.ellipsis);
    }else if(wrongInfo){
      return Text(wrongInfoMsg,style: TextStyle(
          color: Colors.red,
          fontSize: 15
      ),overflow: TextOverflow.ellipsis);
    }else{
      return SizedBox(height: 0,width: 0,);
    }
  }

  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {

    return Theme(
      isMaterialAppTheme: true,
      data: ThemeData(
        brightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor:Colors.grey.shade200,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 10.0),
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.lock_outline,
                            color: Colors.blue,
                          ),
                          title: Text("Change Password",overflow: TextOverflow.ellipsis),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Route route = MaterialPageRoute(builder: (context) => ChangePassword(tocken: widget.token,userId:  widget.userId,));
                            Navigator.push(context, route);
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(
                            Icons.mail,
                            color: Colors.blue,
                          ),
                          title: Text("Change email",overflow: TextOverflow.ellipsis),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            //open change language
                            Navigator.pushNamed(
                                context, '/changeEmail', arguments: {
                              "token": widget.token,
                              "userId":widget.userId
                            });
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(
                            FontAwesomeIcons.idCard,
                            color: Colors.blue,
                          ),
                          title: Text("Change contact name",overflow: TextOverflow.ellipsis),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            //open change location
                            Navigator.pushNamed(
                                context, '/updateContactName', arguments: {
                              "token": widget.token,
                              "userId":widget.userId
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            Positioned(
              bottom: -20,
              left: -20,
              child: Container(
                width: 80,
                height: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: 00,
              left: 00,
              child: IconButton(
                icon: Icon(
                  FontAwesomeIcons.powerOff,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await submit();
// After [onPressed], it will trigger animation running backwards, from end to beginning
                  return () {
// Optional returns is returning a function that can be called
// after the animation is stopped at the beginning.
// A best practice would be to do time-consuming task in [onPressed],
// and do page navigation in the returned function.
// So that user won't missed out the reverse animation.
                  };
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }

  Future<http.Response> submitInfo() async {
    return http.post(
      Constants.server_ip+'security/logout/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':'token '+widget.token
      },
      body: jsonEncode(<String, String>{
      }),
    );
  }
  Future<void> submit() async {

      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print('connected');
          good_internet=true;

          submitInfo().then((onValue){
            if (json.decode(onValue.body)["response"] != null){
              wrongInfo=false;
              wrongInfoMsg="";
              Toast.show(json.decode(onValue.body)["response"], context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
              print(json.decode(onValue.body)["response"]);
              Navigator.pushReplacementNamed(
                  context, '/Login', arguments: {
                "token": widget.token
              });
            }else{
              wrongInfo=true;
              wrongInfoMsg = json.decode(onValue.body)["error"].toString();
              if( json.decode(onValue.body)["error"].toString()=="null"){
                wrongInfoMsg ="there something wrong in your code";
              }
              print("we have an error"+json.decode(onValue.body)["error"].toString());
              setState(() {

              });
            }
          });
        }
      } on SocketException catch (_) {
        print('not connected');
        setState(() {
          good_internet= false;
        });
      }

  }
}