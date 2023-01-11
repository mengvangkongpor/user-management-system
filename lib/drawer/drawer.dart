import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_management_system/drawer/change_password.dart';
import 'package:user_management_system/drawer/user_profile.dart';
import 'package:user_management_system/login.dart';
import 'package:user_management_system/model/districts/district_provider.dart';
import 'package:user_management_system/model/provinces/province_provider.dart';
import 'package:user_management_system/model/users/user_constructor.dart';
import 'package:user_management_system/model/users/user_provider.dart';

class drawerBar extends StatefulWidget {
  const drawerBar({super.key});

  @override
  State<drawerBar> createState() => _drawerBarState();
}

class _drawerBarState extends State<drawerBar> {
  String? UserID_Login;
  String? Role_Login;
  List<User> userData = [];

  @override
  void initState() {
    super.initState();
    GetUserLogin();
    Provider.of<UserProvider>(context, listen: false).showUser();
    Provider.of<DistrictProvider>(context, listen: false).showDistrict();
    Provider.of<ProvinceProvider>(context, listen: false).showProvince();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3(builder: (context,
        UserProvider userProvider,
        DistrictProvider districtProvider,
        ProvinceProvider provinceProvider,
        child) {
      if (UserID_Login == null && Role_Login == null) {
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      } else {
        userData = userProvider.usersList
            .where((e) => e.user_id_pk == UserID_Login.toString())
            .toList();

        return Drawer(
          backgroundColor: HexColor('#F5F5F5'),
          child: ListView(
            children: [
              //==================== Drawer Header ===================
              DrawerHeader(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/bgprofile3.png'),
                  fit: BoxFit.cover,
                )),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            // ສ້າງຮູບວົງມົນ shape circle
                            shape: BoxShape.circle,
                            //ໃສ່ຮູບຕາມ property ທີ່ກຳນົດ
                            image: DecorationImage(
                              image:
                                  AssetImage("assets/images/profiles/img.png"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Column(
                      children: [
                        Container(
                          child: Text(
                            userData[0].username,
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // ==================== End Drawer Header ===================

              //====================== Drawer Body =========================
              Column(
                children: [
                  //================== User Information ===================
                  Container(
                    height: 50.0,
                    child: ListTile(
                      leading: Icon(Icons.account_circle),
                      title: Text(
                        "ຂໍ້ມູນຕົວເອງ",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        Timer(Duration(milliseconds: 200), () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserProfileScreen()));
                        });
                      },
                    ),
                  ),

                  // =================== Change Password ====================
                  Container(
                    child: ListTile(
                        leading: Icon(Icons.key),
                        title: Text(
                          "ປ່ຽນລະຫັດຜ່ານ",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () => Timer(Duration(milliseconds: 200), () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PasswordScreen(
                                        user_id_pk: UserID_Login.toString(),
                                      )));
                            })),
                  ),

                  //========== Sign out or Logout ===============
                  Container(
                    child: ListTile(
                      leading: Icon(Icons.logout),
                      title: Text(
                        "ອອກຈາກລະບົບ",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        Timer(Duration(milliseconds: 300), () {
                          AwesomeDialog(
                              context: context,
                              dialogType: DialogType.question,
                              dismissOnTouchOutside: false,
                              transitionAnimationDuration:
                                  Duration(milliseconds: 200),
                              title: "ຕ້ອງການອອກຈາກລະບົບແທ້ບໍ?",
                              titleTextStyle: TextStyle(fontSize: 18.0),
                              padding: EdgeInsets.only(top: 30.0, bottom: 20.0),
                              btnCancelText: "ຍົກເລີກ",
                              btnCancelOnPress: () {},
                              btnOkText: "ຕົກລົງ",
                              btnOkOnPress: () {
                                // Remove user login data in shared preferences
                                RemoveUserLogin();

                                // go to login
                                Timer(Duration(milliseconds: 200), () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => loginPage()),
                                      (route) => route.isCurrent);
                                });
                              })
                            ..show();
                        });
                      },
                    ),
                  )
                ],
              ),
              // ==================== End Drawer Body ======================
            ],
          ),
        );
      }
    });
  }

  Future<void> RemoveUserLogin() async {
    final shared_pref = SharedPreferences.getInstance();
    final prefs = await shared_pref;
    prefs.remove("UserID_Login");
    prefs.remove("Role_Login");
  }

  Future<void> GetUserLogin() async {
    final shared_pref = await SharedPreferences.getInstance();
    final prefs = await shared_pref;
    setState(() {
      UserID_Login = prefs.getString("UserID_Login");
      Role_Login = prefs.getString("Role_Login");
    });
  }
}
