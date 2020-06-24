import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:purifiercompanyapp/admin/clients/prerigstration.dart';
import 'package:purifiercompanyapp/admin/filters/CreateFilter.dart';
import 'package:purifiercompanyapp/admin/filters/FilterCard.dart';
import 'package:purifiercompanyapp/admin/machines/CreateMachine.dart';
import 'package:purifiercompanyapp/admin/mainpack/CreateMainPack.dart';
import 'package:toast/toast.dart';
import 'dart:io';

import 'MachineCard.dart';



class showAllMachines extends StatefulWidget {
  String tocken;
  String userId;
  showAllMachines({this.tocken,this.userId});
  @override
  _showAllMachinesState createState() => _showAllMachinesState();
}

class _showAllMachinesState extends State<showAllMachines> {
  final TextEditingController controller = new TextEditingController();
  String research = "";
  Future<List<dynamic>> filters ;
  bool good_internet= true;
  bool wrongInfo= false;
  String wrongInfoMsg =" ";
  List user_names=new List();
  List <String> main_packs = new List <String>();

  Future<List<dynamic>> lookForMachines({String indice}) async {
    String urlJson = "http://anasmansouri.ddns.net:8000/management/machine_search/?search=$indice";
    var res = await http.get(Uri.encodeFull(urlJson),headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization':'token '+widget.tocken
    });
    var resBody = json.decode(res.body);
    // print(resBody.toString());
    return resBody;
  }



  Future<http.Response> get_client_name_id_call({
    String tocken
  }) async {
    return http.get(
        'http://anasmansouri.ddns.net:8000/management/client_name_and_id/',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':'Token $tocken'
        }
    );
  }


  Future<http.Response> get_main_packs_id_call({
    String tocken
  }) async {
    return http.get(
        'http://anasmansouri.ddns.net:8000/management/MainPacks/',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':'Token $tocken'
        }
    );
  }



  Future<void> get_client_name_id() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        good_internet=true;
        await get_client_name_id_call(tocken: widget.tocken).then((onValue) async {

          if (json.decode(onValue.body).isEmpty){
            wrongInfo=true;
            wrongInfoMsg = "there is no user in the data base";
            /* setState(() {

              }); */

          }else{
            wrongInfo=false;
            wrongInfoMsg="";
            user_names.clear();
            for ( int i = 0; i<json.decode(onValue.body).length;i++){
              user_names.add(json.decode(onValue.body)[i]);
            }

           /* setState(() {

            }); */
            // Navigator.pop(context,true);
          }
        });


        await get_main_packs_id_call(tocken: widget.tocken).then((onValue) async {

          if (json.decode(onValue.body).isEmpty){
            wrongInfo=true;
            wrongInfoMsg = "there is no main pack in the data base";
            /* setState(() {

              }); */

          }else{
            wrongInfo=false;
            wrongInfoMsg="";
            main_packs.clear();
            for ( int i = 0; i<json.decode(onValue.body).length;i++){
              main_packs.add(json.decode(onValue.body)[i]["packagecode"]);
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

  @override
  Widget build(BuildContext   context) {
    this.filters = lookForMachines(indice: research);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
          child: Icon(Icons.add,color: Colors.white,),
          onPressed: () async{
          await get_client_name_id();
          if (this.main_packs.isEmpty){
            Toast.show("there is no main pack in the data base !", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
          }else if (this.user_names.isEmpty){
            Toast.show("there is no client in the data base !", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
          }else{
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>CreateMachine(tocken: widget.tocken,user_names: this.user_names,main_packs: this.main_packs,))
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
                  labelText: 'Enter the machine info',
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
                          MachineCard(tocken: widget.tocken,username:   snapshot.data[index]["user"],
                              mac: snapshot.data[index]["mac"].toString(),
                              nextservicedate:     snapshot.data[index]["nextservicedate"].toString(),
                              price: snapshot.data[index]["price"].toString(),
                              userId: widget.userId,
                              producttype:  snapshot.data[index]["producttype"].toString(),
                              installaddress1:  snapshot.data[index]["installaddress1"].toString(),
                            installdate: snapshot.data[index]["installdate"].toString(),
                            machineid: snapshot.data[index]["machineid"].toString(),
                            main_pack: snapshot.data[index]["main_pack"].toString(),
                              installaddress2:  snapshot.data[index]["installaddress2"].toString()
                          ),
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
