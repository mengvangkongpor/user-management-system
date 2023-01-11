import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_management_system/model/districts/district_provider.dart';
import 'package:user_management_system/model/profiles/profile_provider.dart';
import 'package:user_management_system/model/provinces/province_provider.dart';
import 'package:user_management_system/model/roles/role_provider.dart';
import 'package:user_management_system/model/users/user_provider.dart';
import 'package:user_management_system/model/users_has_roles/user_role_provider.dart';
import 'package:user_management_system/wait_loading.dart';

void main() {
  runApp(const MyApp());
}

// // Hex Color as Primary Color in ThemeData
// MaterialColor themeColor = MaterialColor(
//   0xFF3B82F6,
//   <int, Color>{
//     50: Color(0xFF3B82F6),
//     100: Color(0xFF3B82F6),
//     200: Color(0xFF3B82F6),
//     300: Color(0xFF3B82F6),
//     400: Color(0xFF3B82F6),
//     500: Color(0xFF3B82F6),
//     600: Color(0xFF3B82F6),
//     700: Color(0xFF3B82F6),
//     800: Color(0xFF3B82F6),
//     900: Color(0xFF3B82F6),
//   },
// );

// RGB Color as Primary Color in ThemeData
MaterialColor mycolor = MaterialColor(
  Color.fromARGB(255, 85, 255, 255).value,
  <int, Color>{
    50: Color.fromARGB(255, 64, 97, 100),
    100: Color.fromARGB(255, 0, 238, 255),
    200: Color.fromARGB(255, 0, 238, 255),
    300: Color.fromARGB(255, 0, 238, 255),
    400: Color.fromARGB(255, 0, 238, 255),
    500: Color.fromARGB(255, 0, 238, 255),
    600: Color.fromARGB(255, 0, 238, 255),
    700: Color.fromARGB(255, 0, 238, 255),
    800: Color.fromARGB(255, 0, 238, 255),
    900: Color.fromARGB(255, 0, 238, 255),
  },
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // widget ນີ້ແມ່ນ ຮາກ ຫລື ໂຄງສ້າງ ຂອງ ແອັບພລີເຄເຊີນ

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => ProvinceProvider()),
        ChangeNotifierProvider(create: (context) => DistrictProvider()),
        ChangeNotifierProvider(create: (context) => UserRoleProvider()),
        ChangeNotifierProvider(create: (context) => RoleProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider())
      ],
      child: MaterialApp(
        // ເອົາຄຳເວົ້າ DEBUG ຢູ່ແຈມຸມຂວາຂອງໜ້າຈໍອອກ
        debugShowCheckedModeBanner: false,
        title: 'User Management System',
        home: Loading(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
