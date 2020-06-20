import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:purifiercompanyapp/admin/clients/prerigstration.dart';
import 'package:purifiercompanyapp/admin/filters/CreateFilter.dart';
import 'package:purifiercompanyapp/admin/filters/FilterCard.dart';
import 'package:purifiercompanyapp/admin/mainpack/CreateMainPack.dart';



class showAllFilters extends StatefulWidget {
  String tocken;
  String userId;
  showAllFilters({this.tocken,this.userId});
  @override
  _showAllFiltersState createState() => _showAllFiltersState();
}

class _showAllFiltersState extends State<showAllFilters> {
  final TextEditingController controller = new TextEditingController();
  String research = "";
  Future<List<dynamic>> filters ;

  Future<List<dynamic>> lookForFilters({String indice}) async {
    String urlJson = "http://anasmansouri.ddns.net:8000/management/Filters/?search=$indice";
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
    this.filters = lookForFilters(indice: research);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
          child: Icon(Icons.add,color: Colors.white,),
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>CreateFilter(tocken: widget.tocken,))
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
                  labelText: 'Enter filter info',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24)
                  ),

                ),
              ),
            ),SizedBox(height: 5,),
            Expanded(
              child: FutureBuilder(
                future: this.filters,
                builder: (context,snapshot){
                  if(snapshot.connectionState==ConnectionState.done){
                    // print(snapshot.data.toString());
                    return   ListView.builder(
                      shrinkWrap: true,
                      itemCount:snapshot.data.length,
                      itemBuilder: (BuildContext ctxt, int index) =>
                          FilterCard(tocken: widget.tocken,filtercode:  snapshot.data[index]["filtercode"],
                              filterdetail:  snapshot.data[index]["filterdetail"].toString(),
                              filtername:    snapshot.data[index]["filtername"].toString(),
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
