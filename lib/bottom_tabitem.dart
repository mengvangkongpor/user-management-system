import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_management_system/drawer/drawer.dart';
import 'package:user_management_system/home.dart';
import 'package:user_management_system/model/roles/role_constructor.dart';
import 'package:user_management_system/model/users/manage_user.dart';
import 'package:user_management_system/model/users/add_user.dart';
import 'package:user_management_system/notification.dart';
import 'package:user_management_system/other.dart';
import 'package:user_management_system/model/users_has_roles/users_roles_contructor.dart';

class TabItemScreen extends StatefulWidget {
  const TabItemScreen({super.key, required this.currentIndex2});
  final int currentIndex2;

  @override
  State<TabItemScreen> createState() => _TabItemScreenState();
}

class _TabItemScreenState extends State<TabItemScreen> {
  String? UserID_Login;
  String? Role_Login;
  List<UserRole> user_roleData = [];
  List<Role> roleData = [];

  // This is int value for go each TabBar Bottom
  int currentIndex = 0;

  void OnTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  //===================== Screen App for Admin ====================
  List<Widget> screen_admin = [
    homeScreen(),
    notificationFromUser(),
    addUser(),
    manageUser(),
    other(),
  ];

  List<TabItem<dynamic>> AdminTab = [
    TabItem(icon: Icons.home, title: 'ໜ້າແລກ'),
    TabItem(icon: Icons.notifications_active, title: 'ແຈ້ງເຕືອນ'),
    TabItem(icon: Icons.person_add, title: 'ເພີ່ມຜູ້ໃຊ້ງານ'),
    TabItem(icon: Icons.groups, title: 'ຜູ້ໃຊ້ງານ'),
    TabItem(icon: Icons.more_vert, title: 'ເພີ່ມເຕີມ')
  ];
  // ============= End Screen App for Admin ===================

  // ================= Screen App for User and Manger ====================
  List<Widget> screen_user_manager = [
    homeScreen(),
    notificationFromUser(),
    manageUser(),
    other(),
  ];
  List<TabItem<dynamic>> UserManagerTab = [
    TabItem(icon: Icons.home, title: 'ໜ້າແລກ'),
    TabItem(icon: Icons.notifications_active, title: 'ແຈ້ງເຕືອນ'),
    TabItem(icon: Icons.groups, title: 'ຜູ້ໃຊ້ງານ'),
    TabItem(icon: Icons.more_vert, title: 'ເພີ່ມເຕີມ')
  ];
  // ================= End Screen App for User and Manager ==================

  Future<void> GetUserLogin() async {
    final shared_pref = await SharedPreferences.getInstance();
    final prefs = await shared_pref;
    setState(() {
      UserID_Login = prefs.getString("UserID_Login").toString();
      Role_Login = prefs.getString("Role_Login").toString();
    });
  }

  // Android back button
  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: Center(child: Text("ຕ້ອງການປິດແອັບບໍ ?")),
            actions: [
              TextButton(
                child: Text(
                  "ຍົກເລີກ",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () => Navigator.pop(context, false),
              ),
              TextButton(
                  child: Text(
                    "ຕົກລົງ",
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    SystemNavigator.pop();
                  })
            ],
          ));

  @override
  void initState() {
    super.initState();
    GetUserLogin();
    currentIndex = widget.currentIndex2;
  }

  @override
  Widget build(BuildContext context) {
    if (UserID_Login == null && Role_Login == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
      return WillPopScope(
        onWillPop: () async {
          final shouldPop = await showWarning(context);
          return shouldPop ?? false;
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 3.0,
            title: Text(
              "ລະບົບຈັດການຜູ້ໃຊ້ງານ",
              // UserID_Login.toString(),
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          drawer: drawerBar(),
          body: Role_Login == "Admin"
              ? screen_admin[currentIndex]
              : screen_user_manager[currentIndex],
          bottomNavigationBar: ConvexAppBar(
              backgroundColor: Colors.blue,
              // height: 50, ກຳນົດລວງສູງ 50 ຄືຄ່າ default
              // ຮູບແບບການເລືອກມີຫລາຍແບບ react, reactCircle...
              style: TabStyle.reactCircle,
              initialActiveIndex: currentIndex,
              // color: HexColor(''),
              // activeColor: , ການສະແດງ ສີ ທີ່ຖືກເລືອກ
              // curveSize: 100.0, // ປ່ຽນເນີນພູ
              color: Colors.white,
              items: Role_Login == "Admin" ? AdminTab : UserManagerTab,
              onTap: OnTap),
        ),
      );
    }
  }
}
