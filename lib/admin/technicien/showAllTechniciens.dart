import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:purifiercompanyapp/admin/clients/prerigstration.dart';
import 'package:purifiercompanyapp/global_constants/Constants.dart';
import 'CreateTechnicien.dart';
import 'TechnicienCard.dart';


class showAllTechnicien extends StatefulWidget {
  String tocken;
  String userId;
  showAllTechnicien({this.tocken,this.userId});
  @override
  _showAllTechnicienState createState() => _showAllTechnicienState();
}

class _showAllTechnicienState extends State<showAllTechnicien> {
  final TextEditingController controller = new TextEditingController();
  String research = "";
  Future<List<dynamic>> tech ;

  Future<List<dynamic>> lookForTechnicien({String indice}) async {
    String urlJson = Constants.server_ip+"management/Technicians/?search=$indice";
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
    this.tech = lookForTechnicien(indice: research);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: "technicien",
        backgroundColor: Colors.greenAccent,
          child: Icon(Icons.add,color: Colors.white,),
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>CreateTechnicien(tocken: widget.tocken))
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
                  labelText: 'Enter the technicien info',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24)
                  ),
                  // hintText: 'كيف حالك'
                ),
              ),
            ),SizedBox(height: 5,),
            Expanded(
              child: FutureBuilder(
                future: this.tech,
                builder: (context,snapshot){
                  if(snapshot.connectionState==ConnectionState.done){
                    // print(snapshot.data.toString());
                    return   ListView.builder(
                      shrinkWrap: true,
                      itemCount:snapshot.data?.length ?? 0,
                      itemBuilder: (BuildContext ctxt, int index) =>
                          TechnicienCard(tocken: widget.tocken,staffcode:  snapshot.data[index]["staffcode"]
                              ,email:   snapshot.data[index]["email"],
                            staffshort:  snapshot.data[index]["staffshort"]
                          ,staffcontact:  snapshot.data[index]["staffcontact"],
                          staffname: snapshot.data[index]["staffname"],
                          userId: widget.userId,),
                    );
                  }else{
                    return SpinKitCircle(
                      color: Colors.blue,
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
