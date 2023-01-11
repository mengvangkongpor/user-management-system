import 'dart:async';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_management_system/model/districts/district_constructor.dart';
import 'package:user_management_system/model/districts/district_provider.dart';
import 'package:user_management_system/model/profiles/profile_constructor.dart';
import 'package:user_management_system/model/profiles/profile_provider.dart';
import 'package:user_management_system/model/provinces/province_constructor.dart';
import 'package:user_management_system/model/provinces/province_provider.dart';
import 'package:user_management_system/model/users/user_constructor.dart';
import 'package:user_management_system/model/users/user_provider.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key, required this.user_id_pk});
  // ສ້າງ ຕົວປ່ຽນ view_user ເພື່ອຮັບຄ່າຈາກໜ້າ manageUser ຢູ່ປຸ່ມ popup ລາຍລະອຽດ
  //ໂດຍຮັບຄ່າໃນຮູບແບບ Map ຫຼື Object
  final String user_id_pk;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? UserID_Login;
  String? Role_Login;

  final _formKey = GlobalKey<FormBuilderState>();
  User userConstructor =
      User(user_id_pk: "", username: "", email: "", mobile: "", password: "");
  Profile profileConstructor = Profile(
      user_id_fk: "",
      profile_id_pk: "",
      firstname: "",
      lastname: "",
      gender: "",
      dob: "",
      village: "",
      district_id_fk: "",
      province_id_fk: "",
      imgprofile: "");

  List<User> view_user = [];
  List<Profile> view_profile = [];
  List<Province> view_province = [];
  List<District> view_district = [];
  String? _username;
  String? _firsname;
  String? _lastname;
  String? _gender;
  String? _dob;
  String? provinceDropdown;
  String? districtDropdown;
  List<District> autoDistrictDropdown = [];
  List<District> autoDistrictList = [];
  // String? _village;
  String? _email;
  String? _mobile;

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
    GetUserLogin();
    Provider.of<DistrictProvider>(context, listen: false).showDistrict();
    Provider.of<ProvinceProvider>(context, listen: false).showProvince();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer4(builder: (context,
        UserProvider userProvider,
        ProfileProvider profileProvider,
        ProvinceProvider provinceProvider,
        DistrictProvider districtProvider,
        child) {
      if (UserID_Login == null && Role_Login == null) {
        return Center(child: CircularProgressIndicator());
      } else {
        if (Role_Login == "User") {
          // ດຶງຂໍ້ມູນຄົນທີ່ມີລະຫັດໄອດີ (user_id_pk) ເທົ່າກັບ ຄົນທີ່ເຮົາຄລິກເບິ່ງລາຍລະອຽດ
          view_user = userProvider.usersList
              .where((e) => e.user_id_pk == widget.user_id_pk)
              .toList();

          // ດຶງຂໍ້ມູນໂປຣຟາຍ ທີ່ມີ foreign key ເຊື່ອມກັບ user_id_pk
          view_profile = profileProvider.profileList
              .where((e) => e.user_id_fk == widget.user_id_pk)
              .toList();

          view_district = districtProvider.districtList
              .where((e) => e.district_id_pk == view_profile[0].district_id_fk)
              .toList();

          view_province = provinceProvider.provinceList
              .where((e) => e.province_id_pk == view_profile[0].province_id_fk)
              .toList();
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "ລາຍລະອຽດໂປຣຟາຍ",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: ListView(
              children: [
                Column(children: [
                  // ===================== ImgProfile ======================
                  Container(
                    margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/images/profiles/img.png')),
                    ),
                  ),
                  Divider(),
                  // ====================  Username =======================
                  Container(
                    child: ListTile(
                      leading: Icon(Icons.account_circle),
                      title: Text(
                        "ຊື່ຜູ້ໃຊ້ງານ",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 14.0),
                      ),
                      subtitle: Text(
                        _username == null
                            ? view_user[0].username
                            : _username.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                    ),
                  ),
                  Divider(),

                  // ==================== Fname and Lname ===================
                  Container(
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text(
                        "ຊື່ ແລະ ນາມສະກຸນ",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 14.0),
                      ),
                      subtitle: Text(
                        _firsname == null && _lastname == null
                            ? view_profile.length == 0
                                ? "ຍັງບໍ່ມີໂປຣໄຟລ໌"
                                : "${view_profile[0].firstname} ${view_profile[0].lastname}"
                            : "$_firsname $_lastname",
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                    ),
                  ),
                  Divider(),
                  // ===================== Gender ==========================
                  Container(
                    child: ListTile(
                      leading: Icon(Icons.transgender),
                      title: Text(
                        "ເພດ",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 14.0),
                      ),
                      subtitle: Text(
                        _gender == null
                            ? view_profile.length == 0
                                ? "ຍັງບໍ່ມີໂປຣໄຟລ໌"
                                : view_profile[0].gender
                            : _gender.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                    ),
                  ),
                  Divider(),
                  // ================== Date of birth ======================
                  Container(
                    child: ListTile(
                      leading: Icon(Icons.cake_rounded),
                      title: Text(
                        "ວັນເດືອນປີເກີດ",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 14.0),
                      ),
                      subtitle: Text(
                        _dob == null
                            ? view_profile.length == 0
                                ? "ຍັງບໍ່ມີໂປຣໄຟລ໌"
                                : view_profile[0].dob
                            : _dob.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                    ),
                  ),
                  Divider(),
                  // =================== ==Address =========================
                  Container(
                    child: ListTile(
                      leading: Icon(Icons.location_city),
                      title: Text(
                        "ທີ່ຢູ່",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 14.0),
                      ),
                      subtitle: Text(
                        "ບ້ານ ${view_profile[0].village}, ເມືອງ ${view_district[0].district}, ແຂວງ ${view_province[0].province}",
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                    ),
                  ),
                  Divider(),
                  // ==================== Email ============================
                  Container(
                    child: ListTile(
                      leading: Icon(Icons.email),
                      title: Text(
                        "ອີເມວ",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 14.0),
                      ),
                      subtitle: Text(
                        _email == null ? view_user[0].email : _email.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                    ),
                  ),
                  Divider(),
                  // =================== Mobile Phone =======================
                  Container(
                    child: ListTile(
                      leading: Icon(Icons.phone),
                      title: Text(
                        "ເບີໂທ",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 14.0),
                      ),
                      subtitle: Text(
                        _mobile == null
                            ? view_user[0].mobile
                            : _mobile.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                    ),
                  ),
                  Divider(),
                ])
              ],
            ),
          );
        }
        // Admin Manager
        else {
          // ດຶງຂໍ້ມູນຄົນທີ່ມີລະຫັດໄອດີ (user_id_pk) ເທົ່າກັບ ຄົນທີ່ເຮົາຄລິກເບິ່ງລາຍລະອຽດ
          view_user = userProvider.usersList
              .where((e) => e.user_id_pk == widget.user_id_pk)
              .toList();

          // ດຶງຂໍ້ມູນໂປຣຟາຍ ທີ່ມີ foreign key ເຊື່ອມກັບ user_id_pk
          view_profile = profileProvider.profileList
              .where((e) => e.user_id_fk == widget.user_id_pk)
              .toList();

          view_district = districtProvider.districtList
              .where((e) => e.district_id_pk == view_profile[0].district_id_fk)
              .toList();

          view_province = provinceProvider.provinceList
              .where((e) => e.province_id_pk == view_profile[0].province_id_fk)
              .toList();

          return Scaffold(
            appBar: AppBar(
              title: Text(
                "ລາຍລະອຽດໂປຣຟາຍ",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: ListView(
              children: [
                Column(children: [
                  // ===================== ImgProfile ======================
                  Container(
                    margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/images/profiles/img.png')),
                    ),
                  ),
                  Divider(),
                  // ====================  Username =======================
                  Container(
                    child: ListTile(
                      leading: Icon(Icons.account_circle),
                      title: Text(
                        "ຊື່ຜູ້ໃຊ້ງານ",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 14.0),
                      ),
                      subtitle: Text(
                        _username == null
                            ? view_user[0].username
                            : _username.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      trailing: TextButton(
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Icon(
                            Icons.edit,
                            size: 16.0,
                            color: Colors.black,
                          ),
                          Text(
                            "ແກ້ໄຂ",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                            ),
                          ),
                        ]),
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            //true is default value ໜ້າຈຳຈະຖືກເລື່ອນອັດຕະໂນມັດ ເມື່ອເປີດຄີບອດ
                            //false ຈະຊ້ອນທັບໜ້າຈໍ
                            keyboardAware: true,
                            dismissOnBackKeyPress: true,
                            dialogType: DialogType.noHeader,
                            animType: AnimType.bottomSlide,
                            showCloseIcon: true,
                            dismissOnTouchOutside: false,
                            transitionAnimationDuration:
                                Duration(milliseconds: 700),
                            body: GestureDetector(
                              onTap: () => FocusScope.of(context).unfocus(),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  child: FormBuilder(
                                    key: _formKey,
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          'ອັບເດດຊື່ຜູ້ໃຊ້ງານ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                        Divider(),
                                        const SizedBox(
                                          height: 30.0,
                                        ),
                                        Material(
                                          elevation: 0,
                                          child: FormBuilderTextField(
                                            name: 'Username',
                                            autofocus: true,
                                            minLines: 1,
                                            style: TextStyle(fontSize: 18.0),
                                            initialValue: _username == null
                                                ? view_user[0].username
                                                : _username.toString(),
                                            decoration: const InputDecoration(
                                              errorStyle:
                                                  TextStyle(fontSize: 14.0),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: 5.0,
                                              ),
                                            ),
                                            validator: (value) {
                                              // ໃຊ້ trim() function ເພື່ອຕັດຄ່າຫວ່າງຊ້າຍ, ຂວາ ອອກໄປ
                                              String newValue = value!.trim();
                                              String newValue2 =
                                                  value.replaceAll(" ", "");
                                              if (newValue.isEmpty) {
                                                return "ປ້ອນຊື່ຜູ້ໃຊ້ງານກ່ອນ *";
                                              } else {
                                                if (newValue.length > 30) {
                                                  return "ຊື່ຜູ້ໃຊ້ຕ້ອງຍາວບໍ່ເກີນ 30 ຕົວອັກສອນ";
                                                } else if (newValue2.length <
                                                    4) {
                                                  return "ຊື່ຜູ້ໃຊ້ຕ້ອງຍາວກວ່າ 4 ຕົວອັກສອນຂຶ້ນໄປ";
                                                } else if (RegExp(
                                                            r'^[^0-9!@#\$%^&*()_+=/|<>?]\w*\s*\w*\s*\w*$')
                                                        .hasMatch(newValue) ==
                                                    false) {
                                                  return "ຊື່ຕ້ອງຂຶ້ນຕົ້ນຕົວອັກສອນ";
                                                }
                                              }
                                              return null;
                                            },
                                            onSaved: (val) => userConstructor
                                                .username = val.toString(),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        AnimatedButton(
                                          isFixedHeight: false,
                                          height: 40.0,
                                          text: 'ອັບເດດ',
                                          buttonTextStyle: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                          pressEvent: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _formKey.currentState?.save();
                                              var username =
                                                  userConstructor.username;
                                              User users_username = User(
                                                  user_id_pk:
                                                      "${widget.user_id_pk}",
                                                  username: username,
                                                  email: "",
                                                  mobile: "",
                                                  password: "");
                                              UserProvider getProvider =
                                                  Provider.of<UserProvider>(
                                                      context,
                                                      listen: false);
                                              getProvider
                                                  .solveUser(users_username);
                                              setState(() {
                                                _username = username;
                                              });
                                              Navigator.of(context).pop();
                                            }
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )..show();
                        },
                      ),
                    ),
                  ),
                  Divider(),

                  // ==================== Fname and Lname ===================
                  Container(
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text(
                        "ຊື່ ແລະ ນາມສະກຸນ",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 14.0),
                      ),
                      subtitle: Text(
                        _firsname == null && _lastname == null
                            ? view_profile.length == 0
                                ? "ຍັງບໍ່ມີໂປຣໄຟລ໌"
                                : "${view_profile[0].firstname} ${view_profile[0].lastname}"
                            : "$_firsname $_lastname",
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      trailing: TextButton(
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Icon(
                            Icons.edit,
                            size: 16.0,
                            color: Colors.black,
                          ),
                          Text(
                            "ແກ້ໄຂ",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                            ),
                          ),
                        ]),
                        onPressed: () {
                          if (view_profile.length == 0) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              transitionAnimationDuration:
                                  Duration(milliseconds: 300),
                              autoHide: Duration(milliseconds: 1300),
                              title: "ຍັງບໍ່ມີໂປຣໄຟລ໌",
                              padding: EdgeInsets.symmetric(vertical: 20.0),
                            )..show();
                          } else {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.noHeader,
                              animType: AnimType.bottomSlide,
                              showCloseIcon: true,
                              dismissOnTouchOutside: false,
                              transitionAnimationDuration:
                                  Duration(milliseconds: 700),
                              body: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  child: FormBuilder(
                                    key: _formKey,
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          'ອັບເດດຊື່ ແລະ ນາມສະກຸນ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                        Divider(),
                                        const SizedBox(
                                          height: 30.0,
                                        ),
                                        Material(
                                          elevation: 0,
                                          child: FormBuilderTextField(
                                            name: 'Fisrtname',
                                            autofocus: true,
                                            minLines: 1,
                                            initialValue: _firsname == null
                                                ? view_profile[0].firstname
                                                : _firsname,
                                            style: TextStyle(fontSize: 18.0),
                                            decoration: const InputDecoration(
                                              errorStyle:
                                                  TextStyle(fontSize: 14.0),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: 5.0,
                                              ),
                                            ),
                                            validator: (fname) {
                                              // ໃຊ້ replaceAll() function ເພື່ອຕັດຄ່າຫວ່າງອອກໄປ
                                              String newfname =
                                                  fname!.replaceAll(" ", "");
                                              if (newfname.isEmpty) {
                                                return "ປ້ອນຊື່ກ່ອນ *";
                                              } else {
                                                if (newfname == "") {
                                                } else if (newfname.length <
                                                    2) {
                                                  return "ຕ້ອງມີ 2 ຕົວອັກສອນຂຶ້ນໄປ *";
                                                  // } else if (RegExp(r'^[ກ-ຮ\!\@\#\$\%\^\&\*\(\)\/\\\_\-\=\+\<\>\?]*$')
                                                  //         .hasMatch(newfname) ==
                                                  //     false) {
                                                  //   return "";
                                                } else if (newfname.length >
                                                    30) {
                                                  return "ຊື່ຍາວບໍ່ເກີນ 30 ຕົວອັກສອນ *";
                                                }
                                              }
                                              return null;
                                            },
                                            onSaved: (val) => profileConstructor
                                                .firstname = val!,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Material(
                                          elevation: 0,
                                          child: FormBuilderTextField(
                                            name: 'Lastname',
                                            autofocus: true,
                                            minLines: 1,
                                            initialValue: _lastname == null
                                                ? view_profile[0].lastname
                                                : _lastname,
                                            style: TextStyle(fontSize: 18.0),
                                            decoration: const InputDecoration(
                                              errorStyle:
                                                  TextStyle(fontSize: 14.0),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: 5.0,
                                              ),
                                            ),
                                            validator: (lanme) {
                                              // ໃຊ້ replaceAll() function ເພື່ອຕັດຄ່າຫວ່າງອອກໄປ
                                              String newlanme =
                                                  lanme!.replaceAll(" ", "");
                                              if (newlanme.isEmpty) {
                                                return "ປ້ອນນາມສະກຸນກ່ອນ *";
                                              } else {
                                                if (newlanme == "") {
                                                } else if (newlanme.length <
                                                    2) {
                                                  return "ຕ້ອງມີ 2 ຕົວອັກສອນຂຶ້ນໄປ *";
                                                  // } else if (RegExp(
                                                  //             r'^[a-zA-Z0-9\!\@\#\$\%\^\&\*\(\)\/\\\_\-\=\+\<\>\?]*')
                                                  //         .hasMatch(newValue) ==
                                                  //     false) {
                                                  //   return "";
                                                } else if (newlanme.length >
                                                    30) {
                                                  return "ຍາວບໍ່ເກີນ 30 ຕົວອັກສອນ";
                                                }
                                              }
                                              return null;
                                            },
                                            onSaved: (val) => profileConstructor
                                                .lastname = val!,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        AnimatedButton(
                                          isFixedHeight: false,
                                          height: 40.0,
                                          text: 'ອັບເດດ',
                                          buttonTextStyle: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                          pressEvent: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _formKey.currentState?.save();
                                              Profile profiles_name = Profile(
                                                  user_id_fk: '',
                                                  profile_id_pk:
                                                      "${view_profile[0].profile_id_pk}",
                                                  firstname: profileConstructor
                                                      .firstname,
                                                  lastname: profileConstructor
                                                      .lastname,
                                                  gender: "",
                                                  dob: "",
                                                  village: "",
                                                  district_id_fk: "",
                                                  province_id_fk: "",
                                                  imgprofile: "");
                                              ProfileProvider getProvider =
                                                  Provider.of<ProfileProvider>(
                                                      context,
                                                      listen: false);
                                              getProvider
                                                  .solveProfile(profiles_name);
                                              setState(() {
                                                _firsname = profileConstructor
                                                    .firstname;
                                                _lastname =
                                                    profileConstructor.lastname;
                                              });
                                              Navigator.pop(context);
                                            }
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )..show();
                          }
                        },
                      ),
                    ),
                  ),
                  Divider(),
                  // ===================== Gender ==========================
                  Container(
                    child: ListTile(
                      leading: Icon(Icons.transgender),
                      title: Text(
                        "ເພດ",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 14.0),
                      ),
                      subtitle: Text(
                        _gender == null
                            ? view_profile.length == 0
                                ? "ຍັງບໍ່ມີໂປຣໄຟລ໌"
                                : view_profile[0].gender
                            : _gender.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      trailing: TextButton(
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Icon(
                            Icons.edit,
                            size: 16.0,
                            color: Colors.black,
                          ),
                          Text(
                            "ແກ້ໄຂ",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                            ),
                          ),
                        ]),
                        onPressed: () {
                          if (view_profile.length == 0) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              transitionAnimationDuration:
                                  Duration(milliseconds: 300),
                              autoHide: Duration(milliseconds: 1300),
                              title: "ຍັງບໍ່ມີໂປຣໄຟລ໌",
                              padding: EdgeInsets.symmetric(vertical: 20.0),
                            )..show();
                          } else {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.noHeader,
                              animType: AnimType.bottomSlide,
                              showCloseIcon: true,
                              dismissOnTouchOutside: false,
                              transitionAnimationDuration:
                                  Duration(milliseconds: 700),
                              body: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  child: FormBuilder(
                                    key: _formKey,
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          'ອັບເດດເພດ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                        Divider(),
                                        const SizedBox(
                                          height: 30.0,
                                        ),
                                        FormBuilderRadioGroup(
                                          wrapAlignment:
                                              WrapAlignment.start, // default
                                          wrapSpacing:
                                              15.0, // spacing choose gender
                                          orientation: OptionsOrientation
                                              .wrap, // ຈັດຮູບແບບລວງນອນ, ລວງຕັ້ງ wrap is default value
                                          activeColor:
                                              Theme.of(context).primaryColor,

                                          name: "gender",
                                          initialValue: _gender == null
                                              ? view_profile[0].gender
                                              : _gender.toString(),
                                          options: ['ຊາຍ', 'ຍິງ', 'ບໍ່ລະບຸ']
                                              .map(
                                                  (e) => FormBuilderFieldOption(
                                                        value: e,
                                                        child: Text(e),
                                                      ))
                                              .toList(growable: false),
                                          validator:
                                              FormBuilderValidators.required(
                                                  errorText: "ເລືອກເພດກ່ອນ *"),
                                          // onChanged: (val) {},
                                          onSaved: (val) {
                                            profileConstructor.gender = val!;
                                          },
                                          controlAffinity:
                                              ControlAffinity.leading,
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        AnimatedButton(
                                          isFixedHeight: false,
                                          height: 40.0,
                                          text: 'ອັບເດດ',
                                          buttonTextStyle: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                          pressEvent: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _formKey.currentState?.save();
                                              Profile profiles_gender = Profile(
                                                  user_id_fk: "",
                                                  profile_id_pk: view_profile[0]
                                                      .profile_id_pk,
                                                  firstname: "",
                                                  lastname: "",
                                                  gender:
                                                      profileConstructor.gender,
                                                  dob: "",
                                                  village: "",
                                                  district_id_fk: "",
                                                  province_id_fk: "",
                                                  imgprofile: "");
                                              ProfileProvider getProvider =
                                                  Provider.of<ProfileProvider>(
                                                      context,
                                                      listen: false);
                                              getProvider.solveProfile(
                                                  profiles_gender);
                                              setState(() {
                                                _gender =
                                                    profileConstructor.gender;
                                              });
                                              Navigator.pop(context);
                                            }
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )..show();
                          }
                        },
                      ),
                    ),
                  ),
                  Divider(),
                  // ================== Date of birth ======================
                  Container(
                    child: ListTile(
                      leading: Icon(Icons.cake_rounded),
                      title: Text(
                        "ວັນເດືອນປີເກີດ",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 14.0),
                      ),
                      subtitle: Text(
                        _dob == null
                            ? view_profile.length == 0
                                ? "ຍັງບໍ່ມີໂປຣໄຟລ໌"
                                : view_profile[0].dob
                            : _dob.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      trailing: TextButton(
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Icon(
                            Icons.edit,
                            size: 16.0,
                            color: Colors.black,
                          ),
                          Text(
                            "ແກ້ໄຂ",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                            ),
                          ),
                        ]),
                        onPressed: () {
                          if (view_profile.length == 0) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              transitionAnimationDuration:
                                  Duration(milliseconds: 300),
                              autoHide: Duration(milliseconds: 1300),
                              title: "ຍັງບໍ່ມີໂປຣໄຟລ໌",
                              padding: EdgeInsets.symmetric(vertical: 20.0),
                            )..show();
                          } else {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.noHeader,
                              animType: AnimType.bottomSlide,
                              showCloseIcon: true,
                              dismissOnTouchOutside: false,
                              transitionAnimationDuration:
                                  Duration(milliseconds: 700),
                              body: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  child: FormBuilder(
                                    key: _formKey,
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          'ອັບເດດວັນເດືອນປີເກີດ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                        Divider(),
                                        const SizedBox(
                                          height: 30.0,
                                        ),
                                        DateTimePicker(
                                          type: DateTimePickerType.date,
                                          decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.cake)),
                                          dateMask: 'dd/MM/yyyy',
                                          initialValue: _dob == null
                                              ? view_profile[0].dob
                                              : _dob,
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2030),
                                          // onChanged: (val) {},
                                          // validator: FormBuilderValidators.required(
                                          //     errorText: "ເລືອກວັນເດືອນປີກ່ອນ *"),
                                          onSaved: (val) {
                                            profileConstructor.dob =
                                                val.toString();
                                          },
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        AnimatedButton(
                                          isFixedHeight: false,
                                          height: 40.0,
                                          text: 'ອັບເດດ',
                                          buttonTextStyle: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                          pressEvent: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _formKey.currentState?.save();
                                              Profile profiles_gender = Profile(
                                                  user_id_fk: "",
                                                  profile_id_pk: view_profile[0]
                                                      .profile_id_pk,
                                                  firstname: "",
                                                  lastname: "",
                                                  gender: "",
                                                  dob: profileConstructor.dob,
                                                  village: "",
                                                  district_id_fk: "",
                                                  province_id_fk: "",
                                                  imgprofile: "");
                                              ProfileProvider getProvider =
                                                  Provider.of<ProfileProvider>(
                                                      context,
                                                      listen: false);
                                              getProvider.solveProfile(
                                                  profiles_gender);
                                              setState(() {
                                                _dob = profileConstructor.dob;
                                              });
                                              Navigator.pop(context);
                                            }
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )..show();
                          }
                        },
                      ),
                    ),
                  ),
                  Divider(),
                  // =================== ==Address =========================
                  Container(
                    child: ListTile(
                      leading: Icon(Icons.location_city),
                      title: Text(
                        "ທີ່ຢູ່",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 14.0),
                      ),
                      subtitle: Text(
                        "ບ້ານ ${view_profile[0].village}, ເມືອງ ${view_district[0].district}, ແຂວງ ${view_province[0].province}",
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      trailing: TextButton(
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Icon(
                            Icons.edit,
                            size: 16.0,
                            color: Colors.black,
                          ),
                          Text(
                            "ແກ້ໄຂ",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                            ),
                          ),
                        ]),
                        onPressed: () {
                          AwesomeDialog(
                              context: context,
                              dialogType: DialogType.noHeader,
                              animType: AnimType.bottomSlide,
                              dismissOnTouchOutside: false,
                              dismissOnBackKeyPress: false,
                              transitionAnimationDuration:
                                  Duration(milliseconds: 700),
                              body: Consumer2(
                                builder: (context,
                                    ProvinceProvider provinceProvider,
                                    DistrictProvider districtProvider,
                                    child) {
                                  return Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Container(
                                      child: FormBuilder(
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                            Text(
                                              'ອັບເດດບ້ານ, ເມືອງ ແລະ ແຂວງ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                            Divider(),
                                            const SizedBox(
                                              height: 30.0,
                                            ),

                                            DropdownButtonFormField(
                                              value: provinceDropdown,
                                              decoration: InputDecoration(
                                                labelText: 'ເລືອກແຂວງ',
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 0.0,
                                                        horizontal: 10.0),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                                errorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                focusedErrorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                              items: provinceProvider
                                                  .provinceList
                                                  .map((value) {
                                                return DropdownMenuItem<String>(
                                                    value: value.province_id_pk,
                                                    child:
                                                        Text(value.province));
                                              }).toList(),
                                              onChanged: (val) {
                                                setState(() {
                                                  provinceDropdown = val;
                                                  // ເມື່ອເລືອກເມືອງແລ້ວ ແຕ່ຢາກປ່ຽນແຂວງ ເມື່ອກັບມາເລືອກແຂວງ ເມືອງເກົ່າຈະເປັນຄ່າ null
                                                  districtDropdown = null;
                                                  autoDistrictDropdown =
                                                      districtProvider
                                                          .districtList
                                                          .where((e) =>
                                                              e.province_id_fk ==
                                                              provinceDropdown
                                                                  .toString())
                                                          .toList();
                                                  Provider.of<ProvinceProvider>(
                                                          context,
                                                          listen: false)
                                                      .showProvince();
                                                  Provider.of<DistrictProvider>(
                                                          context,
                                                          listen: false)
                                                      .showDistrict();
                                                });
                                              },
                                              validator: FormBuilderValidators
                                                  .required(
                                                      errorText:
                                                          "ເລືອກແຂວງກ່ອນ *"),
                                              onSaved: (val) {
                                                profileConstructor
                                                    .province_id_fk = val!;
                                              },
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.03,
                                            ),

                                            // ========= Select or Dropdown District  =========
                                            DropdownButtonFormField(
                                              value: districtDropdown,
                                              decoration: InputDecoration(
                                                labelText: 'ເລືອກເມືອງ',
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 0.0,
                                                        horizontal: 10.0),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                                errorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                focusedErrorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                              items: autoDistrictDropdown.map<
                                                      DropdownMenuItem<String>>(
                                                  (e) {
                                                return DropdownMenuItem(
                                                    value: e.district_id_pk,
                                                    child: Text(e.district));
                                              }).toList(),
                                              validator: FormBuilderValidators
                                                  .required(
                                                      errorText:
                                                          "ເລືອກເມືອງກ່ອນ *"),
                                              onChanged: (val) {
                                                setState(() {
                                                  districtDropdown =
                                                      val.toString();
                                                });
                                              },
                                              onSaved: (val) {
                                                profileConstructor
                                                        .district_id_fk =
                                                    val.toString();
                                              },
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.03,
                                            ),
                                            FormBuilderTextField(
                                              name: "Village",
                                              initialValue:
                                                  view_profile[0].village,
                                              decoration: InputDecoration(
                                                hintText: "ປ້ອນບ້ານ",
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 0.0,
                                                        horizontal: 10.0),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                                errorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                focusedErrorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                              validator: (value) {
                                                // ໃຊ້ trim() function ເພື່ອຕັດຄ່າຫວ່າງຊ້າຍ, ຂວາ ອອກໄປ
                                                String newValue = value!.trim();
                                                if (newValue.isEmpty) {
                                                  return "ປ້ອນຊື່ບ້ານກ່ອນ *";
                                                }
                                                return null;
                                              },
                                              onSaved: (newValue) =>
                                                  profileConstructor.village =
                                                      newValue.toString(),
                                            ),

                                            const SizedBox(
                                              height: 30,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                AnimatedButton(
                                                    text: "ຍົກເລີກ",
                                                    isFixedHeight: false,
                                                    height: 40.0,
                                                    width: 120,
                                                    color: Colors.red,
                                                    pressEvent: () {
                                                      setState(() {
                                                        provinceDropdown = null;
                                                        districtDropdown = null;
                                                      });
                                                      Navigator.pop(context);
                                                    }),
                                                AnimatedButton(
                                                  isFixedHeight: false,
                                                  height: 40.0,
                                                  width: 120,
                                                  text: 'ອັບເດດ',
                                                  buttonTextStyle: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  pressEvent: () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      _formKey.currentState
                                                          ?.save();
                                                      Profile profiles_address = Profile(
                                                          user_id_fk: "",
                                                          profile_id_pk:
                                                              view_profile[0]
                                                                  .profile_id_pk,
                                                          firstname: "",
                                                          lastname: "",
                                                          gender: "",
                                                          dob: "",
                                                          village:
                                                              profileConstructor
                                                                  .village,
                                                          district_id_fk:
                                                              profileConstructor
                                                                  .district_id_fk,
                                                          province_id_fk:
                                                              profileConstructor
                                                                  .province_id_fk,
                                                          imgprofile: "");
                                                      ProfileProvider
                                                          getProvider =
                                                          Provider.of<
                                                                  ProfileProvider>(
                                                              context,
                                                              listen: false);
                                                      getProvider.solveProfile(
                                                          profiles_address);
                                                      setState(() {
                                                        Provider.of<ProfileProvider>(
                                                                context,
                                                                listen: false)
                                                            .showProfile();
                                                      });
                                                      Timer(
                                                          Duration(
                                                              milliseconds:
                                                                  300), () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      });
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ))
                            ..show();
                        },
                      ),
                    ),
                  ),
                  Divider(),
                  // ==================== Email ============================
                  Container(
                    child: ListTile(
                      leading: Icon(Icons.email),
                      title: Text(
                        "ອີເມວ",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 14.0),
                      ),
                      subtitle: Text(
                        _email == null ? view_user[0].email : _email.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      trailing: TextButton(
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Icon(
                            Icons.edit,
                            size: 16.0,
                            color: Colors.black,
                          ),
                          Text(
                            "ແກ້ໄຂ",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                            ),
                          ),
                        ]),
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.noHeader,
                            animType: AnimType.bottomSlide,
                            showCloseIcon: true,
                            dismissOnTouchOutside: false,
                            transitionAnimationDuration:
                                Duration(milliseconds: 700),
                            body: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                child: FormBuilder(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        'ອັບເດດອີເມວ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      Divider(),
                                      const SizedBox(
                                        height: 30.0,
                                      ),
                                      Material(
                                        elevation: 0,
                                        child: FormBuilderTextField(
                                          name: 'Email',
                                          autofocus: true,
                                          minLines: 1,
                                          style: TextStyle(fontSize: 18.0),
                                          initialValue: _email == null
                                              ? view_user[0].email
                                              : _email.toString(),
                                          decoration: const InputDecoration(
                                            errorStyle:
                                                TextStyle(fontSize: 14.0),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              horizontal: 5.0,
                                            ),
                                          ),
                                          validator: (value) {
                                            String newValue =
                                                value!.replaceAll(" ", "");
                                            if (newValue.isEmpty) {
                                              return "ກະລຸນາປ້ອນອີເມວກ່ອນ";
                                            } else {
                                              if (RegExp(r'^[a-z]{2,30}[a-z0-9]{0,30}@[a-z]{2,10}\.com$')
                                                      .hasMatch(newValue) ==
                                                  false) {
                                                return "ອີເມວບໍ່ຖືກຕ້ອງ";
                                              }
                                            }
                                            return null;
                                          },
                                          onSaved: (val) => userConstructor
                                              .email = val.toString(),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      AnimatedButton(
                                        isFixedHeight: false,
                                        height: 40.0,
                                        text: 'ອັບເດດ',
                                        buttonTextStyle: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                        pressEvent: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState?.save();
                                            var email = userConstructor.email;
                                            User users_email = User(
                                                user_id_pk:
                                                    "${widget.user_id_pk}",
                                                username: "",
                                                email: email,
                                                mobile: "",
                                                password: "");
                                            UserProvider getProvider =
                                                Provider.of<UserProvider>(
                                                    context,
                                                    listen: false);
                                            getProvider.solveUser(users_email);
                                            setState(() {
                                              _email = email;
                                            });
                                            Navigator.of(context).pop();
                                          }
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )..show();
                        },
                      ),
                    ),
                  ),
                  Divider(),
                  // =================== Mobile Phone =======================
                  Container(
                    child: ListTile(
                      leading: Icon(Icons.phone),
                      title: Text(
                        "ເບີໂທ",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 14.0),
                      ),
                      subtitle: Text(
                        _mobile == null
                            ? view_user[0].mobile
                            : _mobile.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      trailing: TextButton(
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Icon(
                            Icons.edit,
                            size: 16.0,
                            color: Colors.black,
                          ),
                          Text(
                            "ແກ້ໄຂ",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                            ),
                          ),
                        ]),
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.noHeader,
                            animType: AnimType.bottomSlide,
                            showCloseIcon: true,
                            dismissOnTouchOutside: false,
                            transitionAnimationDuration:
                                Duration(milliseconds: 700),
                            body: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                child: FormBuilder(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        'ອັບເດດເບີໂທ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      Divider(),
                                      const SizedBox(
                                        height: 30.0,
                                      ),
                                      Material(
                                        elevation: 0,
                                        child: FormBuilderTextField(
                                          name: 'Mobile',
                                          autofocus: true,
                                          minLines: 1,
                                          style: TextStyle(fontSize: 18.0),
                                          initialValue: _mobile == null
                                              ? view_user[0].mobile
                                              : _mobile.toString(),
                                          decoration: const InputDecoration(
                                            errorStyle:
                                                TextStyle(fontSize: 14.0),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              horizontal: 5.0,
                                            ),
                                          ),
                                          validator: (value) {
                                            /* ໃຊ້ repaceAll() function ເພື່ອຕັດຄ່າຫວ່າງອອກໄປ 
                                            ກ່ອນທີ່ຈະເອົາເບີໂທທຳງານຂັ້ນຕອນຕໍ່ໄປ */
                                            String newValue =
                                                value!.replaceAll(" ", "");
                                            if (newValue.isEmpty) {
                                              return "ກະລຸນາປ້ອນເບີໂທກ່ອນ";
                                            } else if (newValue.isNotEmpty) {
                                              if (RegExp(r'^0?(20)[2579]\d{7}$')
                                                      .hasMatch(newValue) ==
                                                  false) {
                                                return "ເບີໂທບໍ່ຖືກຕ້ອງ";
                                              } else {
                                                return null;
                                              }
                                            }
                                            return null;
                                          },
                                          onSaved: (val) => userConstructor
                                              .mobile = val.toString(),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      AnimatedButton(
                                        isFixedHeight: false,
                                        height: 40.0,
                                        text: 'ອັບເດດ',
                                        buttonTextStyle: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                        pressEvent: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState?.save();
                                            var mobile = userConstructor.mobile;
                                            User users_mobile = User(
                                                user_id_pk:
                                                    "${widget.user_id_pk}",
                                                username: "",
                                                email: "",
                                                mobile: mobile,
                                                password: "");
                                            UserProvider getProvider =
                                                Provider.of<UserProvider>(
                                                    context,
                                                    listen: false);
                                            getProvider.solveUser(users_mobile);
                                            setState(() {
                                              _mobile = mobile;
                                            });
                                            Navigator.of(context).pop();
                                          }
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )..show();
                        },
                      ),
                    ),
                  ),
                  Divider(),
                ])
              ],
            ),
          );
        }
      }
    });
  }
}
