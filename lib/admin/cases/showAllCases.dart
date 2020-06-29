import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:purifiercompanyapp/admin/cases/CaseCard.dart';
import 'package:purifiercompanyapp/admin/cases/CreateCase.dart';
import 'package:purifiercompanyapp/admin/clients/prerigstration.dart';
import 'package:purifiercompanyapp/admin/filters/CreateFilter.dart';
import 'package:purifiercompanyapp/admin/filters/FilterCard.dart';
import 'package:purifiercompanyapp/admin/mainpack/CreateMainPack.dart';
import 'package:purifiercompanyapp/global_constants/Constants.dart';
import 'dart:io';
import 'package:toast/toast.dart';




class showAllCases extends StatefulWidget {
  String tocken;
  String userId;
  showAllCases({this.tocken,this.userId});
  @override
  _showAllCasesState createState() => _showAllCasesState();
}

class _showAllCasesState extends State<showAllCases> {
  final TextEditingController controller = new TextEditingController();
  String research = "";
  List <String> techniciens = new List <String>();

  List <String> machines = new List <String>();
  List <String> filters = new List <String>();

  bool good_internet= true;
  bool wrongInfo= false;
  String wrongInfoMsg =" ";
  Future<List<dynamic>> cases ;

  Future<List<dynamic>> lookForCases({String indice}) async {
    String urlJson = Constants.server_ip+"management/Cases/?search=$indice";
    var res = await http.get(Uri.encodeFull(urlJson),headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization':'token '+widget.tocken
    });
    var resBody = json.decode(res.body);
    // print(resBody.toString());
    return resBody;
  }

  // getting the tech info

  Future<http.Response> get_technicien_info({
    String tocken
  }) async {
    return http.get(
        Constants.server_ip+'management/Technicians/',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':'Token $tocken'
        }
    );
  }

  Future<http.Response> get_filter_id({
    String tocken
  }) async {
    return http.get(
        Constants.server_ip+'management/Filters/',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':'Token $tocken'
        }
    );
  }


  Future<http.Response> get_machines_id({
    String tocken
  }) async {
    return http.get(
        Constants.server_ip+'management/Machines/',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':'Token $tocken'
        }
    );
  }



  Future<void> get_machines_and_techniciens_info() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        good_internet=true;
        await get_technicien_info(tocken: widget.tocken).then((onValue) async {

          if (json.decode(onValue.body).isEmpty){
            wrongInfo=true;
            wrongInfoMsg = "there is no technicien in the data base";
            /* setState(() {

              }); */

          }else{
            wrongInfo=false;
            wrongInfoMsg="";
            techniciens.clear();
            for ( int i = 0; i<json.decode(onValue.body).length;i++){
              techniciens.add(json.decode(onValue.body)[i]["staffcode"]);
            }

            /* setState(() {

            }); */
            // Navigator.pop(context,true);
          }
        });


        await get_machines_id(tocken: widget.tocken).then((onValue) async {

          if (json.decode(onValue.body).isEmpty){
            wrongInfo=true;
            wrongInfoMsg = "there is no machine in the data base";
            /* setState(() {

              }); */

          }else{
            wrongInfo=false;
            wrongInfoMsg="";
            machines.clear();
            for ( int i = 0; i<json.decode(onValue.body).length;i++){
              machines.add(json.decode(onValue.body)[i]["machineid"]);
            }
            /* setState(() {

            }); */
            // Navigator.pop(context,true);
          }
        });


        await get_filter_id(tocken: widget.tocken).then((onValue) async {

          if (json.decode(onValue.body).isEmpty){
            wrongInfo=true;
            wrongInfoMsg = "there is no filter in the data base";
            /* setState(() {

              }); */

          }else{
            wrongInfo=false;
            wrongInfoMsg="";
            filters.clear();
            for ( int i = 0; i<json.decode(onValue.body).length;i++){
              filters.add(json.decode(onValue.body)[i]["filtercode"]);
            }
            /* setState(() {

            }); */
            // Navigator.pop(context,true);
          }
        });
      }
    } on SocketException catch (_) {
      print('not connected');
      /* setState(() {
          good_internet= false;
        }); */
    }

  }







  //
  @override
  Widget build(BuildContext   context) {
    this.cases = lookForCases(indice: research);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: "cases",
          backgroundColor: Colors.greenAccent,
          child: Icon(Icons.add,color: Colors.white,),
          onPressed: () async{
            await get_machines_and_techniciens_info();
            if (this.machines.isEmpty){
              Toast.show("there is no machine in the data base !", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
            }else if (this.techniciens.isEmpty){
              Toast.show("there is no technicien in the data base !", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
            }else{
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>CreateCase(tocken: widget.tocken,machines:  this.machines,techniciens: this.techniciens,filters: this.filters,))
              );
            }
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
                  labelText: 'Enter case info',
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
                      itemCount:snapshot.data?.length ?? 0,
                      itemBuilder: (BuildContext ctxt, int index) =>
                          CaseCard(tocken: widget.tocken,scheduledate:snapshot.data[index]["scheduledate"],
                              casetype:  snapshot.data[index]["casetype"].toString(),
                              action:    snapshot.data[index]["action"].toString(),
                             comment: snapshot.data[index]["comment"].toString(),
                             filters: snapshot.data[index]["filters"],
                              handledby: snapshot.data[index]["handledby"]["staffcode"].toString(),
                              iscompleted: snapshot.data[index]["iscompleted"],
                              machines: snapshot.data[index]["machines"],
                              suggest: snapshot.data[index]["suggest"],
                              time: snapshot.data[index]["time"],
                              case_id: snapshot.data[index]["case_id"].toString(),
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
