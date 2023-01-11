import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_management_system/model/districts/district_provider.dart';
import 'package:user_management_system/model/profiles/view_profile.dart';
import 'package:user_management_system/model/profiles/profile_provider.dart';
import 'package:user_management_system/model/provinces/province_provider.dart';
import 'package:user_management_system/model/roles/role_constructor.dart';
import 'package:user_management_system/model/roles/role_provider.dart';
import 'package:user_management_system/model/users/user_constructor.dart';
import 'package:user_management_system/model/users_has_roles/user_role_provider.dart';
import 'package:user_management_system/model/users_has_roles/users_roles_contructor.dart';
import 'user_provider.dart';

class manageUser extends StatefulWidget {
  const manageUser({super.key});

  @override
  State<manageUser> createState() => _manageUserState();
}

class _manageUserState extends State<manageUser> {
  String? UserID_Login;
  String? Role_Login;

  final _formKey = GlobalKey<FormBuilderState>();
  List<UserRole> user_role_data = [];
  List<Role> role_data1 = [];
  List<Role> role_data2 = [];
  List<Role> role_data3 = [];
  bool roleUser = false;
  bool roleManager = false;
  bool roleAdmin = false;

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
    Provider.of<UserProvider>(context, listen: false).showUser();
    Provider.of<UserRoleProvider>(context, listen: false).showUserRole();
    Provider.of<RoleProvider>(context, listen: false).showRole();
    Provider.of<ProfileProvider>(context, listen: false).showProfile();
    Provider.of<DistrictProvider>(context, listen: false).showDistrict();
    Provider.of<ProvinceProvider>(context, listen: false).showProvince();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer6(
        builder: (context,
            UserProvider userProvider,
            UserRoleProvider user_roleProvider,
            RoleProvider roleProvider,
            ProfileProvider profileProvider,
            DistrictProvider districtProvider,
            ProvinceProvider provinceProvider,
            child) {
          if (UserID_Login != null && Role_Login != null) {
            return ListView.builder(
                itemCount: userProvider.usersList.length,
                itemBuilder: (context, index) {
                  User user_data = userProvider.usersList[index];

                  user_role_data = user_roleProvider.user_roleList
                      .where((e) => e.user_id_fk == user_data.user_id_pk)
                      .toList();
                  if (user_role_data.length == 1) {
                    role_data1 = roleProvider.roleList
                        .where(
                            (e) => e.role_id_pk == user_role_data[0].role_id_fk)
                        .toList();

                    return Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        elevation: 2,
                        child: ListTile(
                          leading: ClipOval(
                            child: Image.asset(
                              "assets/images/profiles/img.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(user_data.username),
                          subtitle: Text(role_data1[0].role),
                          trailing: PopupMenuButton(
                              onSelected: (item) {
                                if (item == "role") {
                                  // ==================== Role Dialog ==============
                                  if (Role_Login == "User" ||
                                      Role_Login == "Manager") {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      // headerAnimationLoop: true,
                                      animType: AnimType.topSlide,
                                      dismissOnTouchOutside: false,

                                      closeIcon: Icon(Icons.close),
                                      // ໄລຍະເວລາການເລື່ອນ
                                      transitionAnimationDuration:
                                          Duration(milliseconds: 500),
                                      autoHide: Duration(seconds: 3),
                                      title: 'ຜິດພາດ',
                                      desc: 'ທ່ານບໍ່ສາມາດກຳນົດສະຖານະໄດ້',
                                      descTextStyle: TextStyle(fontSize: 16.0),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20.0),

                                      btnCancelText: 'ຕົກລົງ',
                                      btnCancelOnPress: () {},
                                    )..show();
                                  } else {
                                    List<Role> roleCheckBox = roleProvider
                                        .roleList
                                        .map((e) => e)
                                        .toList();

                                    //---------- List User ----------
                                    List<UserRole> User = user_roleProvider
                                        .user_roleList
                                        .where((e) =>
                                            e.role_id_fk ==
                                                roleCheckBox[0].role_id_pk &&
                                            e.user_id_fk ==
                                                user_data.user_id_pk)
                                        .toList();

                                    //--------- List Manager---------------
                                    List<UserRole> Manager = user_roleProvider
                                        .user_roleList
                                        .where((e) =>
                                            e.role_id_fk ==
                                                roleCheckBox[1].role_id_pk &&
                                            e.user_id_fk ==
                                                user_data.user_id_pk)
                                        .toList();

                                    //------------- List Admin --------------
                                    List<UserRole> Admin = user_roleProvider
                                        .user_roleList
                                        .where((e) =>
                                            e.role_id_fk ==
                                                roleCheckBox[2].role_id_pk &&
                                            e.user_id_fk ==
                                                user_data.user_id_pk)
                                        .toList();

                                    // save and remove role
                                    UserRoleProvider user_role_provider =
                                        Provider.of<UserRoleProvider>(context,
                                            listen: false);

                                    AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.noHeader,
                                        animType: AnimType.bottomSlide,
                                        dismissOnTouchOutside: false,
                                        transitionAnimationDuration:
                                            Duration(milliseconds: 500),
                                        dismissOnBackKeyPress: false,
                                        padding: EdgeInsets.all(20.0),
                                        body: Container(
                                          child: FormBuilder(
                                            key: _formKey,
                                            child: Column(
                                              children: [
                                                Text(
                                                  "ກຳນົດສະຖານະ",
                                                  style:
                                                      TextStyle(fontSize: 18.0),
                                                ),
                                                Divider(),
                                                // =========== User =============
                                                FormBuilderCheckbox(
                                                  name: "User",
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                  title: Text(
                                                    roleCheckBox[0].role,
                                                    style: TextStyle(
                                                        fontSize: 16.0),
                                                  ),
                                                  initialValue: User.length == 0
                                                      ? false
                                                      : roleCheckBox[0]
                                                                  .role_id_pk ==
                                                              User[0].role_id_fk
                                                          ? true
                                                          : false,
                                                  // contentPadding: EdgeInsets.zero,
                                                  onChanged: (value) {
                                                    //======= Save User =======
                                                    if (value == true) {
                                                      UserRole users_roles =
                                                          UserRole(
                                                              user_id_fk:
                                                                  user_data
                                                                      .user_id_pk,
                                                              role_id_fk:
                                                                  roleCheckBox[
                                                                          0]
                                                                      .role_id_pk);
                                                      user_role_provider
                                                          .addUserRole(
                                                              users_roles);
                                                    }
                                                    // ======== Remove User
                                                    else {
                                                      UserRole users_roles =
                                                          UserRole(
                                                              user_id_fk:
                                                                  user_data
                                                                      .user_id_pk,
                                                              role_id_fk:
                                                                  roleCheckBox[
                                                                          0]
                                                                      .role_id_pk);
                                                      user_role_provider
                                                          .removeUserRole(
                                                              users_roles);
                                                    }
                                                  },
                                                  onSaved: (value) =>
                                                      roleUser = value!,
                                                ),
                                                // ========= End User ===========

                                                // ========== Manager ===========
                                                FormBuilderCheckbox(
                                                  name: "Manager",
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                  title: Text(
                                                    roleCheckBox[1].role,
                                                    style: TextStyle(
                                                        fontSize: 16.0),
                                                  ),
                                                  initialValue: Manager
                                                              .length ==
                                                          0
                                                      ? false
                                                      : roleCheckBox[1]
                                                                  .role_id_pk ==
                                                              Manager[0]
                                                                  .role_id_fk
                                                          ? true
                                                          : false,
                                                  // contentPadding: EdgeInsets.zero,
                                                  onChanged: (value) {
                                                    // ===== Save Manager =====
                                                    if (value == true) {
                                                      UserRole users_roles =
                                                          UserRole(
                                                              user_id_fk:
                                                                  user_data
                                                                      .user_id_pk,
                                                              role_id_fk:
                                                                  roleCheckBox[
                                                                          1]
                                                                      .role_id_pk);
                                                      user_role_provider
                                                          .addUserRole(
                                                              users_roles);
                                                    }
                                                    // ======= Remove Manager =======
                                                    else {
                                                      UserRole users_roles =
                                                          UserRole(
                                                              user_id_fk:
                                                                  user_data
                                                                      .user_id_pk,
                                                              role_id_fk:
                                                                  roleCheckBox[
                                                                          1]
                                                                      .role_id_pk);
                                                      user_role_provider
                                                          .removeUserRole(
                                                              users_roles);
                                                    }
                                                  },
                                                  onSaved: (value) =>
                                                      roleManager = value!,
                                                ),
                                                // ========== End Manager =========

                                                // ========== Admin =============
                                                FormBuilderCheckbox(
                                                  name: "Admin",
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                  title: Text(
                                                    roleCheckBox[2].role,
                                                    style: TextStyle(
                                                        fontSize: 16.0),
                                                  ),
                                                  initialValue: Admin.length ==
                                                          0
                                                      ? false
                                                      : roleCheckBox[2]
                                                                  .role_id_pk ==
                                                              Admin[0]
                                                                  .role_id_fk
                                                          ? true
                                                          : false,
                                                  // contentPadding: EdgeInsets.zero,
                                                  onChanged: (value) {
                                                    // ======== Save Admin ==========
                                                    if (value == true) {
                                                      UserRole users_roles =
                                                          UserRole(
                                                              user_id_fk:
                                                                  user_data
                                                                      .user_id_pk,
                                                              role_id_fk:
                                                                  roleCheckBox[
                                                                          2]
                                                                      .role_id_pk);
                                                      user_role_provider
                                                          .addUserRole(
                                                              users_roles);
                                                    }
                                                    // ======== Remove Admin =========
                                                    else {
                                                      UserRole users_roles =
                                                          UserRole(
                                                              user_id_fk:
                                                                  user_data
                                                                      .user_id_pk,
                                                              role_id_fk:
                                                                  roleCheckBox[
                                                                          2]
                                                                      .role_id_pk);
                                                      user_role_provider
                                                          .removeUserRole(
                                                              users_roles);
                                                    }
                                                  },
                                                  onSaved: (value) =>
                                                      roleAdmin = value!,
                                                ),
                                                // ========== End Admin ===========

                                                SizedBox(height: 30.0),

                                                // ======= Submit Button =========
                                                AnimatedButton(
                                                    text: 'ບັນທຶກ',
                                                    isFixedHeight: false,
                                                    height: 40.0,
                                                    pressEvent: () {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        _formKey.currentState!
                                                            .save();
                                                        if (roleUser == false &&
                                                            roleManager ==
                                                                false &&
                                                            roleAdmin ==
                                                                false) {
                                                          AwesomeDialog(
                                                            context: context,
                                                            dialogType:
                                                                DialogType
                                                                    .warning,
                                                            title:
                                                                'ເລືອກສະຖານະໃດໜຶ່ງກ່ອນ !',
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            autoHide: Duration(
                                                                seconds: 3),
                                                            btnCancelText:
                                                                'ຕົກລົງ',
                                                            btnCancelOnPress:
                                                                () {},
                                                          )..show();
                                                        } else {
                                                          setState(() {
                                                            Provider.of<UserRoleProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .showUserRole();
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      }
                                                    }),
                                                // ======== End Submit Button ======

                                                SizedBox(height: 20.0),
                                              ],
                                            ),
                                          ),
                                        ))
                                      ..show();
                                  }
                                  // } else if (item == "update") {

                                } else if (item == "delete") {
                                  if (Role_Login == "User" ||
                                      Role_Login == "Manager") {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      // headerAnimationLoop: true,
                                      animType: AnimType.topSlide,
                                      dismissOnTouchOutside: false,

                                      closeIcon: Icon(Icons.close),
                                      // ໄລຍະເວລາການເລື່ອນ
                                      transitionAnimationDuration:
                                          Duration(milliseconds: 500),
                                      autoHide: Duration(seconds: 3),
                                      title: 'ຜິດພາດ',
                                      desc: 'ທ່ານບໍ່ສາມາດລົບອອກໄດ້',
                                      descTextStyle: TextStyle(fontSize: 16.0),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20.0),

                                      btnCancelText: 'ຕົກລົງ',
                                      btnCancelOnPress: () {},
                                    )..show();
                                  } else {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.question,
                                      // headerAnimationLoop: true,
                                      animType: AnimType.topSlide,
                                      dismissOnTouchOutside: false,

                                      showCloseIcon: true,
                                      closeIcon: Icon(Icons.close),
                                      // ໄລຍະເວລາການເລື່ອນ
                                      transitionAnimationDuration:
                                          Duration(milliseconds: 500),
                                      // autoHide: Duration(seconds: 1),
                                      title: 'ຕ້ອງການລົບອອກແທ້ບໍ?',
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20.0),
                                      btnOkText: 'ຕົກລົງ',
                                      btnCancelText: 'ຍົກເລີກ',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        UserProvider userProvider =
                                            Provider.of<UserProvider>(context,
                                                listen: false);
                                        userProvider
                                            .removeUser(user_data.user_id_pk);

                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.success,
                                          title: 'ລົບສຳເລັດ',
                                          autoHide:
                                              Duration(milliseconds: 1600),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 30.0),
                                        )..show().then((value) {
                                            setState(() {
                                              Provider.of<UserProvider>(context,
                                                      listen: false)
                                                  .showUser();
                                            });
                                          });
                                      },
                                    )..show();
                                  }
                                } else if (item == "view") {
                                  // ສົ່ງຂໍ້ມູນໄປສະແດງຢູ່ ຟາຍ viewprofile.dart
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ProfilePage(
                                            user_id_pk: user_data.user_id_pk,
                                          )));
                                }
                              },
                              itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: "role",
                                      child: Text("ກຳນົດສະຖານະ"),
                                    ),
                                    // PopupMenuItem(
                                    //   value: "update",
                                    //   child: Text("ແກ້ໄຂ"),
                                    // ),
                                    PopupMenuItem(
                                      value: "delete",
                                      child: Text("ລົບ"),
                                    ),
                                    PopupMenuItem(
                                      value: "view",
                                      child: Text("ລາຍລະອຽດ"),
                                    ),
                                  ]),
                        ));
                  } else if (user_role_data.length == 2) {
                    role_data1 = roleProvider.roleList
                        .where(
                            (e) => e.role_id_pk == user_role_data[0].role_id_fk)
                        .toList();
                    role_data2 = roleProvider.roleList
                        .where(
                            (e) => e.role_id_pk == user_role_data[1].role_id_fk)
                        .toList();
                    return Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        elevation: 2,
                        child: ListTile(
                          leading: ClipOval(
                            child: Image.asset(
                              "assets/images/profiles/img.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(user_data.username),
                          subtitle: Text(
                              "${role_data1[0].role}, ${role_data2[0].role}"),
                          trailing: PopupMenuButton(
                              onSelected: (item) {
                                if (item == "role") {
                                  // ==================== Role Dialog ==============
                                  if (Role_Login == "User" ||
                                      Role_Login == "Manager") {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      // headerAnimationLoop: true,
                                      animType: AnimType.topSlide,
                                      dismissOnTouchOutside: false,

                                      closeIcon: Icon(Icons.close),
                                      // ໄລຍະເວລາການເລື່ອນ
                                      transitionAnimationDuration:
                                          Duration(milliseconds: 500),
                                      autoHide: Duration(seconds: 3),
                                      title: 'ຜິດພາດ',
                                      desc: 'ທ່ານບໍ່ສາມາດກຳນົດສະຖານະໄດ້',
                                      descTextStyle: TextStyle(fontSize: 16.0),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20.0),

                                      btnCancelText: 'ຕົກລົງ',
                                      btnCancelOnPress: () {},
                                    )..show();
                                  } else {
                                    List<Role> roleCheckBox = roleProvider
                                        .roleList
                                        .map((e) => e)
                                        .toList();

                                    //---------- List User ----------
                                    List<UserRole> User = user_roleProvider
                                        .user_roleList
                                        .where((e) =>
                                            e.role_id_fk ==
                                                roleCheckBox[0].role_id_pk &&
                                            e.user_id_fk ==
                                                user_data.user_id_pk)
                                        .toList();

                                    //--------- List Manager---------------
                                    List<UserRole> Manager = user_roleProvider
                                        .user_roleList
                                        .where((e) =>
                                            e.role_id_fk ==
                                                roleCheckBox[1].role_id_pk &&
                                            e.user_id_fk ==
                                                user_data.user_id_pk)
                                        .toList();

                                    //------------- List Admin --------------
                                    List<UserRole> Admin = user_roleProvider
                                        .user_roleList
                                        .where((e) =>
                                            e.role_id_fk ==
                                                roleCheckBox[2].role_id_pk &&
                                            e.user_id_fk ==
                                                user_data.user_id_pk)
                                        .toList();

                                    // save and remove role
                                    UserRoleProvider user_role_provider =
                                        Provider.of<UserRoleProvider>(context,
                                            listen: false);

                                    AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.noHeader,
                                        animType: AnimType.bottomSlide,
                                        dismissOnTouchOutside: false,
                                        transitionAnimationDuration:
                                            Duration(milliseconds: 500),
                                        dismissOnBackKeyPress: false,
                                        padding: EdgeInsets.all(20.0),
                                        body: Container(
                                          child: FormBuilder(
                                            key: _formKey,
                                            child: Column(
                                              children: [
                                                Text(
                                                  "ກຳນົດສະຖານະ",
                                                  style:
                                                      TextStyle(fontSize: 18.0),
                                                ),
                                                Divider(),
                                                // =========== User =============
                                                FormBuilderCheckbox(
                                                  name: "User",
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                  title: Text(
                                                    roleCheckBox[0].role,
                                                    style: TextStyle(
                                                        fontSize: 16.0),
                                                  ),
                                                  initialValue: User.length == 0
                                                      ? false
                                                      : roleCheckBox[0]
                                                                  .role_id_pk ==
                                                              User[0].role_id_fk
                                                          ? true
                                                          : false,
                                                  // contentPadding: EdgeInsets.zero,
                                                  onChanged: (value) {
                                                    //======= Save User =======
                                                    if (value == true) {
                                                      UserRole users_roles =
                                                          UserRole(
                                                              user_id_fk:
                                                                  user_data
                                                                      .user_id_pk,
                                                              role_id_fk:
                                                                  roleCheckBox[
                                                                          0]
                                                                      .role_id_pk);
                                                      user_role_provider
                                                          .addUserRole(
                                                              users_roles);
                                                    }
                                                    // ======== Remove User
                                                    else {
                                                      UserRole users_roles =
                                                          UserRole(
                                                              user_id_fk:
                                                                  user_data
                                                                      .user_id_pk,
                                                              role_id_fk:
                                                                  roleCheckBox[
                                                                          0]
                                                                      .role_id_pk);
                                                      user_role_provider
                                                          .removeUserRole(
                                                              users_roles);
                                                    }
                                                  },
                                                  onSaved: (value) =>
                                                      roleUser = value!,
                                                ),
                                                // ========= End User ===========

                                                // ========== Manager ===========
                                                FormBuilderCheckbox(
                                                  name: "Manager",
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                  title: Text(
                                                    roleCheckBox[1].role,
                                                    style: TextStyle(
                                                        fontSize: 16.0),
                                                  ),
                                                  initialValue: Manager
                                                              .length ==
                                                          0
                                                      ? false
                                                      : roleCheckBox[1]
                                                                  .role_id_pk ==
                                                              Manager[0]
                                                                  .role_id_fk
                                                          ? true
                                                          : false,
                                                  // contentPadding: EdgeInsets.zero,
                                                  onChanged: (value) {
                                                    // ===== Save Manager =====
                                                    if (value == true) {
                                                      UserRole users_roles =
                                                          UserRole(
                                                              user_id_fk:
                                                                  user_data
                                                                      .user_id_pk,
                                                              role_id_fk:
                                                                  roleCheckBox[
                                                                          1]
                                                                      .role_id_pk);
                                                      user_role_provider
                                                          .addUserRole(
                                                              users_roles);
                                                    }
                                                    // ======= Remove Manager =======
                                                    else {
                                                      UserRole users_roles =
                                                          UserRole(
                                                              user_id_fk:
                                                                  user_data
                                                                      .user_id_pk,
                                                              role_id_fk:
                                                                  roleCheckBox[
                                                                          1]
                                                                      .role_id_pk);
                                                      user_role_provider
                                                          .removeUserRole(
                                                              users_roles);
                                                    }
                                                  },
                                                  onSaved: (value) =>
                                                      roleManager = value!,
                                                ),
                                                // ========== End Manager =========

                                                // ========== Admin =============
                                                FormBuilderCheckbox(
                                                  name: "Admin",
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                  title: Text(
                                                    roleCheckBox[2].role,
                                                    style: TextStyle(
                                                        fontSize: 16.0),
                                                  ),
                                                  initialValue: Admin.length ==
                                                          0
                                                      ? false
                                                      : roleCheckBox[2]
                                                                  .role_id_pk ==
                                                              Admin[0]
                                                                  .role_id_fk
                                                          ? true
                                                          : false,
                                                  // contentPadding: EdgeInsets.zero,
                                                  onChanged: (value) {
                                                    // ======== Save Admin ==========
                                                    if (value == true) {
                                                      UserRole users_roles =
                                                          UserRole(
                                                              user_id_fk:
                                                                  user_data
                                                                      .user_id_pk,
                                                              role_id_fk:
                                                                  roleCheckBox[
                                                                          2]
                                                                      .role_id_pk);
                                                      user_role_provider
                                                          .addUserRole(
                                                              users_roles);
                                                    }
                                                    // ======== Remove Admin =========
                                                    else {
                                                      UserRole users_roles =
                                                          UserRole(
                                                              user_id_fk:
                                                                  user_data
                                                                      .user_id_pk,
                                                              role_id_fk:
                                                                  roleCheckBox[
                                                                          2]
                                                                      .role_id_pk);
                                                      user_role_provider
                                                          .removeUserRole(
                                                              users_roles);
                                                    }
                                                  },
                                                  onSaved: (value) =>
                                                      roleAdmin = value!,
                                                ),
                                                // ========== End Admin ===========

                                                SizedBox(height: 30.0),

                                                // ======= Submit Button =========
                                                AnimatedButton(
                                                    text: 'ບັນທຶກ',
                                                    isFixedHeight: false,
                                                    height: 40.0,
                                                    pressEvent: () {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        _formKey.currentState!
                                                            .save();
                                                        if (roleUser == false &&
                                                            roleManager ==
                                                                false &&
                                                            roleAdmin ==
                                                                false) {
                                                          AwesomeDialog(
                                                            context: context,
                                                            dialogType:
                                                                DialogType
                                                                    .warning,
                                                            title:
                                                                'ເລືອກສະຖານະໃດໜຶ່ງກ່ອນ !',
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            autoHide: Duration(
                                                                seconds: 3),
                                                            btnCancelText:
                                                                'ຕົກລົງ',
                                                            btnCancelOnPress:
                                                                () {},
                                                          )..show();
                                                        } else {
                                                          setState(() {
                                                            Provider.of<UserRoleProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .showUserRole();
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      }
                                                    }),
                                                // ======== End Submit Button ======

                                                SizedBox(height: 20.0),
                                              ],
                                            ),
                                          ),
                                        ))
                                      ..show();
                                  }
                                  // } else if (item == "update") {

                                } else if (item == "delete") {
                                  if (Role_Login == "User" ||
                                      Role_Login == "Manager") {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      // headerAnimationLoop: true,
                                      animType: AnimType.topSlide,
                                      dismissOnTouchOutside: false,

                                      closeIcon: Icon(Icons.close),
                                      // ໄລຍະເວລາການເລື່ອນ
                                      transitionAnimationDuration:
                                          Duration(milliseconds: 500),
                                      autoHide: Duration(seconds: 3),
                                      title: 'ຜິດພາດ',
                                      desc: 'ທ່ານບໍ່ສາມາດລົບອອກໄດ້',
                                      descTextStyle: TextStyle(fontSize: 16.0),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20.0),

                                      btnCancelText: 'ຕົກລົງ',
                                      btnCancelOnPress: () {},
                                    )..show();
                                  } else {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.question,
                                      // headerAnimationLoop: true,
                                      animType: AnimType.topSlide,
                                      dismissOnTouchOutside: false,

                                      showCloseIcon: true,
                                      closeIcon: Icon(Icons.close),
                                      // ໄລຍະເວລາການເລື່ອນ
                                      transitionAnimationDuration:
                                          Duration(milliseconds: 500),
                                      // autoHide: Duration(seconds: 1),
                                      title: 'ຕ້ອງການລົບອອກແທ້ບໍ?',
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20.0),
                                      btnOkText: 'ຕົກລົງ',
                                      btnCancelText: 'ຍົກເລີກ',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        UserProvider userProvider =
                                            Provider.of<UserProvider>(context,
                                                listen: false);
                                        userProvider
                                            .removeUser(user_data.user_id_pk);

                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.success,
                                          title: 'ລົບສຳເລັດ',
                                          autoHide:
                                              Duration(milliseconds: 1600),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 30.0),
                                        )..show().then((value) {
                                            setState(() {
                                              Provider.of<UserProvider>(context,
                                                      listen: false)
                                                  .showUser();
                                            });
                                          });
                                      },
                                    )..show();
                                  }
                                } else if (item == "view") {
                                  // ສົ່ງຂໍ້ມູນໄປສະແດງຢູ່ ຟາຍ viewprofile.dart

                                  // List profiles = profileProvider.
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ProfilePage(
                                            user_id_pk: user_data.user_id_pk,
                                          )));
                                }
                              },
                              itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: "role",
                                      child: Text("ກຳນົດສະຖານະ"),
                                    ),
                                    // PopupMenuItem(
                                    //   value: "update",
                                    //   child: Text("ແກ້ໄຂ"),
                                    // ),
                                    PopupMenuItem(
                                      value: "delete",
                                      child: Text("ລົບ"),
                                    ),
                                    PopupMenuItem(
                                      value: "view",
                                      child: Text("ລາຍລະອຽດ"),
                                    ),
                                  ]),
                        ));
                  } else if (user_role_data.length == 3) {
                    role_data1 = roleProvider.roleList
                        .where(
                            (e) => e.role_id_pk == user_role_data[0].role_id_fk)
                        .toList();
                    role_data2 = roleProvider.roleList
                        .where(
                            (e) => e.role_id_pk == user_role_data[1].role_id_fk)
                        .toList();
                    role_data3 = roleProvider.roleList
                        .where(
                            (e) => e.role_id_pk == user_role_data[2].role_id_fk)
                        .toList();
                    return Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        elevation: 2,
                        child: ListTile(
                          leading: ClipOval(
                            child: Image.asset(
                              "assets/images/profiles/img.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(user_data.username),
                          subtitle: Text(
                              "${role_data1[0].role}, ${role_data2[0].role}, ${role_data3[0].role}"),
                          trailing: PopupMenuButton(
                              onSelected: (item) {
                                if (item == "role") {
                                  // ==================== Role Dialog ==============
                                  if (Role_Login == "User" ||
                                      Role_Login == "Manager") {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      // headerAnimationLoop: true,
                                      animType: AnimType.topSlide,
                                      dismissOnTouchOutside: false,

                                      closeIcon: Icon(Icons.close),
                                      // ໄລຍະເວລາການເລື່ອນ
                                      transitionAnimationDuration:
                                          Duration(milliseconds: 500),
                                      autoHide: Duration(seconds: 3),
                                      title: 'ຜິດພາດ',
                                      desc: 'ທ່ານບໍ່ສາມາດກຳນົດສະຖານະໄດ້',
                                      descTextStyle: TextStyle(fontSize: 16.0),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20.0),

                                      btnCancelText: 'ຕົກລົງ',
                                      btnCancelOnPress: () {},
                                    )..show();
                                  } else {
                                    List<Role> roleCheckBox = roleProvider
                                        .roleList
                                        .map((e) => e)
                                        .toList();

                                    //---------- List User ----------
                                    List<UserRole> User = user_roleProvider
                                        .user_roleList
                                        .where((e) =>
                                            e.role_id_fk ==
                                                roleCheckBox[0].role_id_pk &&
                                            e.user_id_fk ==
                                                user_data.user_id_pk)
                                        .toList();

                                    //--------- List Manager---------------
                                    List<UserRole> Manager = user_roleProvider
                                        .user_roleList
                                        .where((e) =>
                                            e.role_id_fk ==
                                                roleCheckBox[1].role_id_pk &&
                                            e.user_id_fk ==
                                                user_data.user_id_pk)
                                        .toList();

                                    //------------- List Admin --------------
                                    List<UserRole> Admin = user_roleProvider
                                        .user_roleList
                                        .where((e) =>
                                            e.role_id_fk ==
                                                roleCheckBox[2].role_id_pk &&
                                            e.user_id_fk ==
                                                user_data.user_id_pk)
                                        .toList();

                                    // save and remove role
                                    UserRoleProvider user_role_provider =
                                        Provider.of<UserRoleProvider>(context,
                                            listen: false);

                                    AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.noHeader,
                                        animType: AnimType.bottomSlide,
                                        dismissOnTouchOutside: false,
                                        transitionAnimationDuration:
                                            Duration(milliseconds: 500),
                                        dismissOnBackKeyPress: false,
                                        padding: EdgeInsets.all(20.0),
                                        body: Container(
                                          child: FormBuilder(
                                            key: _formKey,
                                            child: Column(
                                              children: [
                                                Text(
                                                  "ກຳນົດສະຖານະ",
                                                  style:
                                                      TextStyle(fontSize: 18.0),
                                                ),
                                                Divider(),
                                                // =========== User =============
                                                FormBuilderCheckbox(
                                                  name: "User",
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                  title: Text(
                                                    roleCheckBox[0].role,
                                                    style: TextStyle(
                                                        fontSize: 16.0),
                                                  ),
                                                  initialValue: User.length == 0
                                                      ? false
                                                      : roleCheckBox[0]
                                                                  .role_id_pk ==
                                                              User[0].role_id_fk
                                                          ? true
                                                          : false,
                                                  // contentPadding: EdgeInsets.zero,
                                                  onChanged: (value) {
                                                    //======= Save User =======
                                                    if (value == true) {
                                                      UserRole users_roles =
                                                          UserRole(
                                                              user_id_fk:
                                                                  user_data
                                                                      .user_id_pk,
                                                              role_id_fk:
                                                                  roleCheckBox[
                                                                          0]
                                                                      .role_id_pk);
                                                      user_role_provider
                                                          .addUserRole(
                                                              users_roles);
                                                    }
                                                    // ======== Remove User
                                                    else {
                                                      UserRole users_roles =
                                                          UserRole(
                                                              user_id_fk:
                                                                  user_data
                                                                      .user_id_pk,
                                                              role_id_fk:
                                                                  roleCheckBox[
                                                                          0]
                                                                      .role_id_pk);
                                                      user_role_provider
                                                          .removeUserRole(
                                                              users_roles);
                                                    }
                                                  },
                                                  onSaved: (value) =>
                                                      roleUser = value!,
                                                ),
                                                // ========= End User ===========

                                                // ========== Manager ===========
                                                FormBuilderCheckbox(
                                                  name: "Manager",
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                  title: Text(
                                                    roleCheckBox[1].role,
                                                    style: TextStyle(
                                                        fontSize: 16.0),
                                                  ),
                                                  initialValue: Manager
                                                              .length ==
                                                          0
                                                      ? false
                                                      : roleCheckBox[1]
                                                                  .role_id_pk ==
                                                              Manager[0]
                                                                  .role_id_fk
                                                          ? true
                                                          : false,
                                                  // contentPadding: EdgeInsets.zero,
                                                  onChanged: (value) {
                                                    // ===== Save Manager =====
                                                    if (value == true) {
                                                      UserRole users_roles =
                                                          UserRole(
                                                              user_id_fk:
                                                                  user_data
                                                                      .user_id_pk,
                                                              role_id_fk:
                                                                  roleCheckBox[
                                                                          1]
                                                                      .role_id_pk);
                                                      user_role_provider
                                                          .addUserRole(
                                                              users_roles);
                                                    }
                                                    // ======= Remove Manager =======
                                                    else {
                                                      UserRole users_roles =
                                                          UserRole(
                                                              user_id_fk:
                                                                  user_data
                                                                      .user_id_pk,
                                                              role_id_fk:
                                                                  roleCheckBox[
                                                                          1]
                                                                      .role_id_pk);
                                                      user_role_provider
                                                          .removeUserRole(
                                                              users_roles);
                                                    }
                                                  },
                                                  onSaved: (value) =>
                                                      roleManager = value!,
                                                ),
                                                // ========== End Manager =========

                                                // ========== Admin =============
                                                FormBuilderCheckbox(
                                                  name: "Admin",
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                  title: Text(
                                                    roleCheckBox[2].role,
                                                    style: TextStyle(
                                                        fontSize: 16.0),
                                                  ),
                                                  initialValue: Admin.length ==
                                                          0
                                                      ? false
                                                      : roleCheckBox[2]
                                                                  .role_id_pk ==
                                                              Admin[0]
                                                                  .role_id_fk
                                                          ? true
                                                          : false,
                                                  // contentPadding: EdgeInsets.zero,
                                                  onChanged: (value) {
                                                    // ======== Save Admin ==========
                                                    if (value == true) {
                                                      UserRole users_roles =
                                                          UserRole(
                                                              user_id_fk:
                                                                  user_data
                                                                      .user_id_pk,
                                                              role_id_fk:
                                                                  roleCheckBox[
                                                                          2]
                                                                      .role_id_pk);
                                                      user_role_provider
                                                          .addUserRole(
                                                              users_roles);
                                                    }
                                                    // ======== Remove Admin =========
                                                    else {
                                                      UserRole users_roles =
                                                          UserRole(
                                                              user_id_fk:
                                                                  user_data
                                                                      .user_id_pk,
                                                              role_id_fk:
                                                                  roleCheckBox[
                                                                          2]
                                                                      .role_id_pk);
                                                      user_role_provider
                                                          .removeUserRole(
                                                              users_roles);
                                                    }
                                                  },
                                                  onSaved: (value) =>
                                                      roleAdmin = value!,
                                                ),
                                                // ========== End Admin ===========

                                                SizedBox(height: 30.0),

                                                // ======= Submit Button =========
                                                AnimatedButton(
                                                    text: 'ບັນທຶກ',
                                                    isFixedHeight: false,
                                                    height: 40.0,
                                                    pressEvent: () {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        _formKey.currentState!
                                                            .save();
                                                        if (roleUser == false &&
                                                            roleManager ==
                                                                false &&
                                                            roleAdmin ==
                                                                false) {
                                                          AwesomeDialog(
                                                            context: context,
                                                            dialogType:
                                                                DialogType
                                                                    .warning,
                                                            title:
                                                                'ເລືອກສະຖານະໃດໜຶ່ງກ່ອນ !',
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            autoHide: Duration(
                                                                seconds: 3),
                                                            btnCancelText:
                                                                'ຕົກລົງ',
                                                            btnCancelOnPress:
                                                                () {},
                                                          )..show();
                                                        } else {
                                                          setState(() {
                                                            Provider.of<UserRoleProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .showUserRole();
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      }
                                                    }),
                                                // ======== End Submit Button ======

                                                SizedBox(height: 20.0),
                                              ],
                                            ),
                                          ),
                                        ))
                                      ..show();
                                  }
                                  // } else if (item == "update") {

                                } else if (item == "delete") {
                                  if (Role_Login == "User" ||
                                      Role_Login == "Manager") {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      // headerAnimationLoop: true,
                                      animType: AnimType.topSlide,
                                      dismissOnTouchOutside: false,

                                      closeIcon: Icon(Icons.close),
                                      // ໄລຍະເວລາການເລື່ອນ
                                      transitionAnimationDuration:
                                          Duration(milliseconds: 500),
                                      autoHide: Duration(seconds: 3),
                                      title: 'ຜິດພາດ',
                                      desc: 'ທ່ານບໍ່ສາມາດລົບອອກໄດ້',
                                      descTextStyle: TextStyle(fontSize: 16.0),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20.0),

                                      btnCancelText: 'ຕົກລົງ',
                                      btnCancelOnPress: () {},
                                    )..show();
                                  } else {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.question,
                                      // headerAnimationLoop: true,
                                      animType: AnimType.topSlide,
                                      dismissOnTouchOutside: false,

                                      showCloseIcon: true,
                                      closeIcon: Icon(Icons.close),
                                      // ໄລຍະເວລາການເລື່ອນ
                                      transitionAnimationDuration:
                                          Duration(milliseconds: 500),
                                      // autoHide: Duration(seconds: 1),
                                      title: 'ຕ້ອງການລົບອອກແທ້ບໍ?',
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20.0),
                                      btnOkText: 'ຕົກລົງ',
                                      btnCancelText: 'ຍົກເລີກ',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        UserProvider userProvider =
                                            Provider.of<UserProvider>(context,
                                                listen: false);
                                        userProvider
                                            .removeUser(user_data.user_id_pk);

                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.success,
                                          title: 'ລົບສຳເລັດ',
                                          autoHide:
                                              Duration(milliseconds: 1600),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 30.0),
                                        )..show().then((value) {
                                            setState(() {
                                              Provider.of<UserProvider>(context,
                                                      listen: false)
                                                  .showUser();
                                            });
                                          });
                                      },
                                    )..show();
                                  }
                                } else if (item == "view") {
                                  // ສົ່ງຂໍ້ມູນໄປສະແດງຢູ່ ຟາຍ viewprofile.dart

                                  // List profiles = profileProvider.
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ProfilePage(
                                            user_id_pk: user_data.user_id_pk,
                                          )));
                                }
                              },
                              itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: "role",
                                      child: Text("ກຳນົດສະຖານະ"),
                                    ),
                                    // PopupMenuItem(
                                    //   value: "update",
                                    //   child: Text("ແກ້ໄຂ"),
                                    // ),
                                    PopupMenuItem(
                                      value: "delete",
                                      child: Text("ລົບ"),
                                    ),
                                    PopupMenuItem(
                                      value: "view",
                                      child: Text("ລາຍລະອຽດ"),
                                    ),
                                  ]),
                        ));
                  } else {
                    return Text("");
                  }
                });
          } else {
            return Text("");
          }
        },
      ),
    );
  }
}
