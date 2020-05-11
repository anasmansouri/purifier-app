import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_icons/line_icons.dart';
// avatar
import "../customiseWidgets/my_flutter_app_icons.dart" as water;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;


class PersonalInformations extends StatefulWidget {
  String date ;
  String email;
  String userName ;
  int waterPurifierNumber;

  PersonalInformations({this.email,this.date,this.userName,this.
  waterPurifierNumber});
  @override
  _State createState() => _State();
}

class _State extends State<PersonalInformations> {
  final TextEditingController controller = new TextEditingController();
  static Color color =Colors.blue;
  TextStyle style = new TextStyle(fontSize: 20,color: color);
  Future<dynamic> client ;


  Future<dynamic> lookForClient({String mail}) async {
    print("d6alnaa");
    String urlJson = "http://192.168.1.9:8000/managment/InfoOfOneClient/?mail=$mail";
    var res = await http.get(Uri.encodeFull(urlJson));
    var resBody = json.decode(res.body);
    print(resBody);
    return resBody;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
   this.client = lookForClient(mail: widget.email);
    return MaterialApp(
      home:  Scaffold(
          body: FutureBuilder(
            future: this.client,
            // ignore: missing_return
            builder: (context,snapshot) {
             if(snapshot.connectionState==ConnectionState.done){
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
                      label: Text(snapshot.data["name"],
                        style: style,),
                    )
                    ],

                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[FlatButton.icon(
                      icon: Icon(Icons.mail, color: color,
                      ),
                      label: Text(snapshot.data["mail"],
                        style: style,),
                    ),
                    ],
                ), Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[FlatButton.icon(
                      icon: Icon(Icons.timer, color: color,
                      ),
                      label: Text(snapshot.data["date"].toString(),
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
                      label: Text(snapshot.data["number_of_water_purifier"].toString(),
                        style: style,),
                    ),
                    ],
                ),
              ],
            )
        );
      }else{
               return SpinKitCircle(
                 color: Colors.white,
                 size: 50.0,
               );
             }
            }
          )
      ),
      title: 'Tab demo',
    );
  }

}


