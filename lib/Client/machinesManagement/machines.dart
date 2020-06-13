 import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
 import 'package:http/http.dart' as http;

import 'MachineCard.dart';

class Machines extends StatefulWidget {
  String tocken;
  Machines({this.tocken});
  @override
  _MachinesState createState() => _MachinesState();
}

class _MachinesState extends State<Machines> {
  final TextEditingController controller = new TextEditingController();
  String research = "";
  Future<List<dynamic>> clients ;

  Future<List<dynamic>> lookForClient({String name}) async {
    String urlJson = "http://192.168.1.7:8000/management/Machines/?search=$name";
    var res = await http.get(Uri.encodeFull(urlJson),headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization':'token '+widget.tocken
    });
    var resBody = json.decode(res.body);
    print(resBody.toString());
    return resBody;
  }
  @override
  Widget build(BuildContext   context) {
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

                  setState(() {
                    research = text.toString();
                  });
                },
                controller: this.controller,
                textAlignVertical:TextAlignVertical.bottom,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                 labelText: 'Enter the machine id',
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
                      itemBuilder: (BuildContext ctxt, int index) =>  MachineCard(machineID: snapshot.data[index]["machineid"],nextservicedate: snapshot.data[index]["nextservicedate"],location:  snapshot.data[index]["installaddress1"],producttype: snapshot.data[index]["producttype"] ,mac: snapshot.data[index]["mac"],),
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
