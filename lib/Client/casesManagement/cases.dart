 import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:purifiercompanyapp/Client/casesManagement/CaseCard.dart';

class Cases extends StatefulWidget {
  String tocken;
  Cases({this.tocken});
  @override
  _CasesState createState() => _CasesState();
}

class _CasesState extends State<Cases> {
  final TextEditingController controller = new TextEditingController();
  String research = "";
  Future<List<dynamic>> cases ;

  Future<List<dynamic>> lookForCases({String name}) async {
    String urlJson = "http://anasmansouri.ddns.net:8000/management/Cases/?search=$name";
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
    this.cases = lookForCases(name: research);
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
                 labelText: 'Enter the date or the type of the case',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24)
                  ),
                ),
              ),
            ),SizedBox(height: 5,),
            Expanded(
              child: FutureBuilder(
                future: this.cases,
                builder: (context,snapshot){
                  if(snapshot.connectionState==ConnectionState.done){
                    return   ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext ctxt, int index) =>  CaseCard(scheduledate: snapshot.data[index]["scheduledate"],casetype: snapshot.data[index]["casetype"],listMachines: snapshot.data[index]["machines"], ),
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
