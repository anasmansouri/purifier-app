import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:purifiercompanyapp/admin/clients/prerigstration.dart';
import 'package:purifiercompanyapp/admin/mainpack/CreateMainPack.dart';
import 'MainPackCard.dart';


class showAllMainPacks extends StatefulWidget {
  String tocken;
  String userId;
  showAllMainPacks({this.tocken,this.userId});
  @override
  _showAllMainPacksState createState() => _showAllMainPacksState();
}

class _showAllMainPacksState extends State<showAllMainPacks> {
  final TextEditingController controller = new TextEditingController();
  String research = "";
  Future<List<dynamic>> clients ;

  Future<List<dynamic>> lookForMainPacks({String indice}) async {
    String urlJson = "http://192.168.1.3:8000/management/MainPacks/?search=$indice";
    var res = await http.get(Uri.encodeFull(urlJson),headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization':'token '+widget.tocken
    });
    var resBody = json.decode(res.body);
    // print(resBody.toString());
    return resBody;
  }
  @override
  Widget build(BuildContext   context) {
    this.clients = lookForMainPacks(indice: research);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
          child: Icon(Icons.add,color: Colors.white,),
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>CreateMainPack(tocken: widget.tocken,))
            );
          },
        ),
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
                  labelText: 'Enter the Main pack info',
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
                    // print(snapshot.data.toString());
                    return   ListView.builder(
                      shrinkWrap: true,
                      itemCount:snapshot.data.length,
                      itemBuilder: (BuildContext ctxt, int index) =>
                          MainPackCard(tocken: widget.tocken,packagecode: snapshot.data[index]["packagecode"]
                              ,exfiltermonth: snapshot.data[index]["exfiltermonth"].toString(),
                              exfiltervolume:   snapshot.data[index]["exfiltervolume"].toString()
                          ,isbytime:  snapshot.data[index]["isbytime"],
                          isbyusage: snapshot.data[index]["isbyusage"],
                          packagedetail: snapshot.data[index]["packagedetail"],
                          price: snapshot.data[index]["price"].toString(),
                            userId: widget.userId,),
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
