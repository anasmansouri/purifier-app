 import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
 import 'package:http/http.dart' as http;
import 'package:purifiercompanyapp/personalInfo/ClientInfo.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController controller = new TextEditingController();
  String research = "";
  Future<List<dynamic>> clients ;

  Future<List<dynamic>> lookForClient({String name}) async {
    print("d6alnaa");
    String urlJson = "http://192.168.1.9:8000/managment/autoCompletion/?name=$name";
    var res = await http.get(Uri.encodeFull(urlJson));
    var resBody = json.decode(res.body);
    return resBody;
  }
  @override
  Widget build(BuildContext context) {
    this.clients = lookForClient(name: research);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(height: 5,),
            Container(
              height: 50,
              child: TextFormField(

                onChanged: (text){
                  print(text.toString());
                  setState(() {
                    research = text.toString();
                  });
                },
                controller: this.controller,
                textAlignVertical:TextAlignVertical.bottom,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                 labelText: 'Enter the name of the client ',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24)
                  ),
                  // hintText: 'كيف حالك'
                ),
              ),
            ),SizedBox(height: 5,),
            Expanded(
              child: FutureBuilder(
                future: this.clients,
                builder: (context,snapshot){
                  if(snapshot.connectionState==ConnectionState.done){
                    return   ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext ctxt, int index) =>  ClientInfo(name: snapshot.data[index]["fields"]["name"],date: snapshot.data[index]["fields"]["date"],mail: snapshot.data[index]["pk"],water_purifier_number: snapshot.data[index]["fields"]["number_of_water_purifier"],),
                    );
                  }else{
                    return SpinKitCircle(
                      color: Colors.white,
                      size: 50.0,
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
