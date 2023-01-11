import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_management_system/login.dart';
import 'package:user_management_system/tabitem.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String? UserID_Login;
  String? Role_Login;

  @override
  void initState() {
    super.initState();
    GetUserLogin().whenComplete(() async {
      if (UserID_Login != null) {
        Timer(Duration(milliseconds: 4400), () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TabItemScreen(currentIndex2: 0)));
        });
      } else {
        Timer(Duration(milliseconds: 4400), () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => loginPage()));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage('assets/images/icon_app/user.png'))),
          ),
          SizedBox(
            height: 50,
          ),
          SpinKitPouringHourGlass(
            color: Color.fromARGB(255, 0, 238, 255),
            size: 80,
          ),
        ],
      )),
    );
  }

  Future<void> GetUserLogin() async {
    final shared_pref = await SharedPreferences.getInstance();
    final getUser_pref = await shared_pref;
    setState(() {
      UserID_Login = getUser_pref.getString('UserID_Login');
      Role_Login = getUser_pref.getString('Role_Login');
    });
  }
}
