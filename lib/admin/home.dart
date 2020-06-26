/**
 * Author: Anas Mansouri
 * profile: https://github.com/anasmansouri
 */

import 'package:flutter/material.dart';
import 'package:purifiercompanyapp/Client/ClientInfo/ClientInfoDetails.dart';
import 'package:purifiercompanyapp/Client/update/updateInfo.dart';
import 'package:purifiercompanyapp/Client/machinesManagement/machines.dart';
import 'dart:async';
import 'package:purifiercompanyapp/Client/casesManagement/cases.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:purifiercompanyapp/admin/clients/showAll.dart';
import 'package:purifiercompanyapp/admin/machines/showAllMachines.dart';
import 'package:purifiercompanyapp/admin/technicien/showAllTechniciens.dart';

import 'cases/showAllCases.dart';
import 'filters/showAllFilters.dart';
import 'mainpack/showAllMainPacks.dart';

import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';


class FancyBottomBarPageAdmin extends StatefulWidget {
  // static final String path = "lib/src/pages/misc/navybar.dart";
  String token;
  String userId;
  FancyBottomBarPageAdmin({this.token,this.userId});
  @override
  _FancyBottomBarPageAdminState createState() => _FancyBottomBarPageAdminState();
}

class _FancyBottomBarPageAdminState extends State<FancyBottomBarPageAdmin> {
  @override
  void dispose() {
    indexcontroller.close();
    super.dispose();
  }

  PageController pageController = PageController(initialPage: 0);
  StreamController<int> indexcontroller = StreamController<int>.broadcast();
  int index = 0;

  //

  bool wrongInfo =false;
  bool good_internet= true;
  String wrongInfoMsg="";

  Widget Alert(){
    if(!good_internet){
      return Text("no internet connexion ",style: TextStyle(
          color: Colors.red,
          fontSize: 15
      ),);
    }else if(wrongInfo){
      return Text(wrongInfoMsg,style: TextStyle(
          color: Colors.red,
          fontSize: 15
      ),);
    }else{
      return SizedBox(height: 0,width: 0,);
    }
  }



  Future<http.Response> submitInfo() async {
    return http.post(
      'http://anasmansouri.ddns.net:8000/security/logout/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':'token '+widget.token
      },
      body: jsonEncode(<String, String>{
      }),
    );
  }

  Future<void> submit() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        good_internet=true;

        submitInfo().then((onValue){
          if (json.decode(onValue.body)["response"] != null){
            wrongInfo=false;
            wrongInfoMsg="";
            Toast.show(json.decode(onValue.body)["response"], context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
            print(json.decode(onValue.body)["response"]);
            Navigator.pushReplacementNamed(
                context, '/Login', arguments: {
              "token": widget.token
            });
          }else{
            wrongInfo=true;
            wrongInfoMsg = json.decode(onValue.body)["error"].toString();
            if( json.decode(onValue.body)["error"].toString()=="null"){
              wrongInfoMsg ="there something wrong in your code";
            }
            print("we have an error"+json.decode(onValue.body)["error"].toString());
            setState(() {

            });
          }
        });
      }
    } on SocketException catch (_) {
      print('not connected');
      setState(() {
        good_internet= false;
      });
    }

  }



  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey.shade200,
      appBar: AppBar(
          title: Text("osmosis"),
          actions: <Widget>[
          Padding(
                  padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () async{
                        await submit();
                      },
                      child: Icon(
                        FontAwesomeIcons.signOutAlt,
                        size: 26.0,
                      ),
                    )
                ),
        ],
          ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          indexcontroller.add(index);
        },
        controller: pageController,
        children: <Widget>[
          Center(
            child:    showAllClients(tocken: widget.token,),
          ),
          Center(
            child: showAllMainPacks(tocken: widget.token,userId: widget.userId,)/*ClientInfoDetails(tocken:widget.token ,userId: widget.userId,)*/,
          ),
          Center(
            child: showAllMachines(tocken: widget.token,userId: widget.userId,) /*Cases(tocken: widget.token,)*/,
          ),
          Center(
            child: showAllTechnicien(tocken: widget.token,userId:widget.userId)/*SettingsOnePage(token:widget.token)*/,
          ),
          Center(
            child: showAllCases(userId: widget.userId,tocken: widget.token,)/*SettingsOnePage(token:widget.token)*/,
          ),
          Center(
            child: showAllFilters(userId: widget.userId,tocken: widget.token,)/*SettingsOnePage(token:widget.token)*/,
          ),
        ],
      ),
      bottomNavigationBar: StreamBuilder<Object>(
          initialData: 0,
          stream: indexcontroller.stream,
          builder: (context, snapshot) {
            int cIndex = snapshot.data;
            return FancyBottomNavigation(
              currentIndex: cIndex,
              items: <FancyBottomNavigationItem>[
                FancyBottomNavigationItem(
                    icon: Icon(Icons.home), title: Text('Home')),
                FancyBottomNavigationItem(
                    icon: Icon(Icons.inbox), title: Text("Main pack")),
                FancyBottomNavigationItem(
                    icon: Icon(FontAwesomeIcons.robot), title: Text("machines")),
                FancyBottomNavigationItem(
                    icon: Icon(Icons.person), title:  Text("techniciew")),
                FancyBottomNavigationItem(
                    icon: Icon(FontAwesomeIcons.screwdriver), title: Text("cases")),
                FancyBottomNavigationItem(
                    icon: Icon(FontAwesomeIcons.filter), title: Text("filter")),
              ],
              onItemSelected: (int value) {
                indexcontroller.add(value);
                pageController.jumpToPage(value);
              },
            );
          }),
    );
  }
}

class FancyBottomNavigation extends StatefulWidget {
  final int currentIndex;
  final double iconSize;
  final Color activeColor;
  final Color inactiveColor;
  final Color backgroundColor;
  final List<FancyBottomNavigationItem> items;
  final ValueChanged<int> onItemSelected;

  FancyBottomNavigation(
      {Key key,
        this.currentIndex = 0,
        this.iconSize = 24,
        this.activeColor,
        this.inactiveColor,
        this.backgroundColor,
        @required this.items,
        @required this.onItemSelected}) {
    assert(items != null);
    assert(onItemSelected != null);
  }

  @override
  _FancyBottomNavigationState createState() {
    return _FancyBottomNavigationState(
        items: items,
        backgroundColor: backgroundColor,
        currentIndex: currentIndex,
        iconSize: iconSize,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        onItemSelected: onItemSelected);
  }
}

class _FancyBottomNavigationState extends State<FancyBottomNavigation> {
  final int currentIndex;
  final double iconSize;
  Color activeColor;
  Color inactiveColor;
  Color backgroundColor;
  List<FancyBottomNavigationItem> items;
  int _selectedIndex;
  ValueChanged<int> onItemSelected;

  _FancyBottomNavigationState(
      {@required this.items,
        this.currentIndex,
        this.activeColor,
        this.inactiveColor = Colors.black,
        this.backgroundColor,
        this.iconSize,
        @required this.onItemSelected}) {
    _selectedIndex = currentIndex;
  }

  Widget _buildItem(FancyBottomNavigationItem item, bool isSelected) {
    return AnimatedContainer(
      width: isSelected ? 124 : 50,
      height: double.maxFinite,
      duration: Duration(milliseconds: 250),
      padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
        color: activeColor,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(0),
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconTheme(
                  data: IconThemeData(
                      size: iconSize,
                      color: isSelected ? backgroundColor : inactiveColor),
                  child: item.icon,
                ),
              ),
              isSelected
                  ? DefaultTextStyle.merge(
                style: TextStyle(color: backgroundColor),
                child: item.title,
              )
                  : SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    activeColor =
    (activeColor == null) ? Theme.of(context).accentColor : activeColor;

    backgroundColor = (backgroundColor == null)
        ? Theme.of(context).bottomAppBarColor
        : backgroundColor;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 56,
      padding: EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 6),
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.map((item) {
          var index = items.indexOf(item);
          return GestureDetector(
            onTap: () {
              onItemSelected(index);

              setState(() {
                _selectedIndex = index;
              });
            },
            child: _buildItem(item, _selectedIndex == index),
          );
        }).toList(),
      ),
    );
  }
}

class FancyBottomNavigationItem {
  final Icon icon;
  final Text title;

  FancyBottomNavigationItem({
    @required this.icon,
    @required this.title,
  }) {
    assert(icon != null);
    assert(title != null);
  }
}