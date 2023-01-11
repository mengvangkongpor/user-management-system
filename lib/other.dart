import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_management_system/model/districts/district.dart';
import 'package:user_management_system/model/districts/information.dart';
import 'package:user_management_system/model/provinces/information.dart';
import 'package:user_management_system/model/provinces/province.dart';
import 'package:user_management_system/model/roles/information.dart';
import 'package:user_management_system/model/roles/role.dart';

class other extends StatefulWidget {
  const other({super.key});

  @override
  State<other> createState() => _otherState();
}

class _otherState extends State<other> {
  String? UserID_Login;
  String? Role_Login;

  Future<void> GetUserLogin() async {
    final shared_pref = await SharedPreferences.getInstance();
    final prefs = await shared_pref;
    setState(() {
      UserID_Login = prefs.getString("UserID_Login").toString();
      Role_Login = prefs.getString("Role_Login").toString();
    });
  }

  @override
  void initState() {
    super.initState();
    GetUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    if (UserID_Login == null && Role_Login == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width * 1.0,
          padding: EdgeInsets.all(30),
          color: Color.fromARGB(255, 220, 217, 217),
          child: Role_Login == "Admin"
              ? GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  children: [
                    // Province
                    Card(
                      elevation: 50,
                      shadowColor: Colors.black,
                      color: Color.fromARGB(255, 255, 255, 255),
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Text(
                                'ແຂວງ',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 1.0,
                                height: 40.0,
                                child: AnimatedButton(
                                  icon: Icons.touch_app,
                                  text: 'ເບິ່ງ',
                                  pressEvent: () {
                                    if (Role_Login == "Admin") {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProvincePage()));
                                    } else {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  InformationProvince()));
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // District
                    Card(
                      elevation: 50,
                      shadowColor: Colors.black,
                      color: Colors.white,
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Text(
                                'ເມືອງ',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 1.0,
                                height: 40.0,
                                child: AnimatedButton(
                                  icon: Icons.touch_app,
                                  text: 'ເບິ່ງ',
                                  pressEvent: () {
                                    if (Role_Login == "Admin") {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DistrictPage()));
                                    } else {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  InformationDistrict()));
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Role
                    Card(
                      elevation: 50,
                      shadowColor: Colors.black,
                      color: Colors.white,
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Text(
                                'ສະຖານະ',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 1.0,
                                height: 40.0,
                                child: AnimatedButton(
                                  icon: Icons.touch_app,
                                  text: 'ເບິ່ງ',
                                  pressEvent: () {
                                    if (Role_Login == "Admin") {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RolePage()));
                                    } else {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  InformationRole()));
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  children: [
                    Card(
                      elevation: 50,
                      shadowColor: Colors.black,
                      color: Color.fromARGB(255, 255, 255, 255),
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Text(
                                'ແຂວງ',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 1.0,
                                height: 40.0,
                                child: AnimatedButton(
                                  icon: Icons.touch_app,
                                  text: 'ເບິ່ງ',
                                  pressEvent: () {
                                    if (Role_Login == "Admin") {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProvincePage()));
                                    } else {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  InformationProvince()));
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 50,
                      shadowColor: Colors.black,
                      color: Colors.white,
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Text(
                                'ເມືອງ',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 1.0,
                                height: 40.0,
                                child: AnimatedButton(
                                  icon: Icons.touch_app,
                                  text: 'ເບິ່ງ',
                                  pressEvent: () {
                                    if (Role_Login == "Admin") {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DistrictPage()));
                                    } else {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  InformationDistrict()));
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      );
    }
  }
}
