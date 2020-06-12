import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:purifiercompanyapp/admin/clients/prerigstration.dart';
import 'ClientCard.dart';


class showAllClients extends StatefulWidget {
  String tocken;
  showAllClients({this.tocken});
  @override
  _showAllClientsState createState() => _showAllClientsState();
}

class _showAllClientsState extends State<showAllClients> {
  final TextEditingController controller = new TextEditingController();
  String research = "";
  Future<List<dynamic>> clients ;

  Future<List<dynamic>> lookForClient({String indice}) async {
    String urlJson = "http://192.168.1.3:8000/security/accounts/?search=$indice";
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
    this.clients = lookForClient(indice: research);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
          child: Icon(Icons.add,color: Colors.white,),
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>Prerigstration())
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
                  labelText: 'Enter the client info',
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
                          ClientCard(tocken: widget.tocken,mobile:  snapshot.data[index]["mobile"]
                              ,joindate:  snapshot.data[index]["joindate"],
                              username:  snapshot.data[index]["user"]["username"]
                          ,email:  snapshot.data[index]["user"]["email"],
                          billingaddress1: snapshot.data[index]["billingaddress1"],
                          billingaddress2: snapshot.data[index]["billingaddress2"],
                          is_confirmed: snapshot.data[index]["isconfirm"],),
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
