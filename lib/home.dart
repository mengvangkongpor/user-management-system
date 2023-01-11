import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_management_system/model/profiles/profile_constructor.dart';
import 'package:user_management_system/model/profiles/profile_provider.dart';
import 'package:user_management_system/model/users/user_constructor.dart';
import 'package:user_management_system/model/users/user_provider.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  List<User> countAllUsers = [];
  List<Profile> allFemaleUsers = [];
  List<Profile> allMaleUsers = [];

  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).showUser();
    Provider.of<ProfileProvider>(context, listen: false).showProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2(builder: (context, UserProvider userProvider,
          ProfileProvider profileProvider, child) {
        // all users
        countAllUsers = userProvider.usersList.map((e) => e).toList();

        // all female users
        allFemaleUsers = profileProvider.profileList
            .where((e) => e.gender == "ຍິງ")
            .toList();

        // all male users
        allMaleUsers = profileProvider.profileList
            .where((e) => e.gender == "ຊາຍ")
            .toList();
        return Padding(
          padding: EdgeInsets.all(10.0),
          child: GridView.count(
            crossAxisCount: 3,
            children: [
              Card(
                elevation: 8,
                shadowColor: Color.fromARGB(255, 0, 229, 255),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 102, 255, 255),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.person,
                              size: 70.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0)),
                            color: Color.fromARGB(255, 0, 229, 255),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "ຜູ້ໃຊ້ງານທັງໝົດ:",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                countAllUsers.length.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // =============== Female Card ===============
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)),
                            color: Color.fromARGB(255, 255, 198, 247),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.female,
                              size: 70.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0)),
                            color: Color.fromARGB(255, 255, 0, 238),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "ຜູ້ໃຊ້ງານຍິງ:",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                allFemaleUsers.length.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // =========== Male Card ===============
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)),
                            color: Color.fromARGB(255, 255, 220, 131),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.male,
                              size: 70.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0)),
                            color: Color.fromARGB(255, 255, 179, 0),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "ຜູ້ໃຊ້ງານຊາຍ:",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                allMaleUsers.length.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // =========== User Card ===============
              // Card(
              //   elevation: 8,
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10.0)),
              //   child: Container(
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //     child: Column(
              //       children: [
              //         Expanded(
              //           flex: 6,
              //           child: Container(
              //             width: double.infinity,
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.only(
              //                   topLeft: Radius.circular(10.0),
              //                   topRight: Radius.circular(10.0)),
              //               color: Colors.white,
              //             ),
              //             child: Center(
              //               child: Icon(
              //                 Icons.male,
              //                 size: 70.0,
              //                 color: Color.fromARGB(255, 255, 179, 0),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Expanded(
              //           flex: 4,
              //           child: Container(
              //             width: double.infinity,
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.only(
              //                   bottomLeft: Radius.circular(10.0),
              //                   bottomRight: Radius.circular(10.0)),
              //               color: Color.fromARGB(255, 255, 179, 0),
              //             ),
              //             child: Column(
              //               children: [
              //                 SizedBox(
              //                   height: 5.0,
              //                 ),
              //                 Text(
              //                   "ຜູ້ໃຊ້ງານຊາຍ:",
              //                   style: TextStyle(
              //                     color: Colors.white,
              //                     fontSize: 14.0,
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //                 ),
              //                 Text(
              //                   allMaleUsers.length.toString(),
              //                   style: TextStyle(
              //                     color: Colors.white,
              //                     fontSize: 16.0,
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //                 )
              //               ],
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      }),
    );
  }
}
