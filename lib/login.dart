import 'dart:async';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_management_system/bottom_tabitem.dart';
import 'package:user_management_system/model/roles/role_constructor.dart';
import 'package:user_management_system/model/roles/role_provider.dart';
import 'package:user_management_system/model/users/user_constructor.dart';
import 'package:user_management_system/model/users/user_provider.dart';
import 'package:user_management_system/model/users_has_roles/user_role_provider.dart';
import 'package:user_management_system/model/users_has_roles/users_roles_contructor.dart';
import 'package:user_management_system/register.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final formKey = GlobalKey<FormState>();
  final formKeyBuilder = GlobalKey<FormBuilderState>();
  User user =
      User(user_id_pk: "", username: "", email: "", mobile: "", password: "");
  Role role = Role(role_id_pk: "", role: "");

  OutlineInputBorder border = OutlineInputBorder(
      borderSide: BorderSide(width: 1.5, color: Colors.grey),
      borderRadius: BorderRadius.circular(10.0));
  OutlineInputBorder focusBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 1.5, color: Colors.blue),
      borderRadius: BorderRadius.circular(10.0));
  OutlineInputBorder errorBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 1.5, color: Colors.red),
      borderRadius: BorderRadius.circular(10.0));
  bool _obscureText = true;
  bool rememberMe = false;
  // String usernameValidate = "";
  String? emailValidate;
  String? mobileValidate;
  String? passwordValidate;

  Color? prefixIconColor = Colors.grey;

  // TextField : Username, Email and Phone
  // ບ໋ອກປ້ອນຊື່ຜູ້ນຳໃຊ້ , ອີເມວ ແລະ ເບີໂທ
  Widget textUserName() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontSize: 16.0),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        prefixIconColor: prefixIconColor,
        enabledBorder: border,
        focusedBorder: focusBorder,
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder,
        errorStyle: TextStyle(fontSize: 14.0),
        // ກຳນົດໄລຍະຫ່າງຂອງ text ໃຫ້ຫ່າງຈາກຂອບ ຄືກັນກັບຕົວ padding ໃນ css
        contentPadding: EdgeInsets.symmetric(
          // ໄລຍະຫ່າງໃນລວງນອນ
          horizontal: 10.0,
        ),
      ),
      validator: (value) {
        String val = value!.replaceAll(" ", "");

        if (value.isEmpty || val == "") {
          return "ປ້ອນຂໍ້ມູນກ່ອນ *";
        }

        return null;
      },
      onSaved: (val) {
        user.username = val!;
        user.email = val;
        user.mobile = val;
      },
    );
  }

  // TextField : Password
  // ບ໋ອກປ້ອນລະຫັດຜ່ານ
  Widget textPassword() {
    return TextFormField(
      style: TextStyle(
        fontSize: 16.0,
      ),
      obscureText: _obscureText,
      // ກຳນົດຂີດຈຳກັດການປ້ອນລະຫັດ
      // maxLength: 20,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock),
        prefixIconColor: Colors.grey,
        enabledBorder: border,
        focusedBorder: focusBorder,
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder,
        errorStyle: TextStyle(fontSize: 14.0),
        //contentPadding: ແມ່ນການ ກຳນົດໄລຍະຫ່າງຂອງ text ໃຫ້ຫ່າງຈາກຂອບ ຄືກັນກັບຕົວ padding ໃນ css
        contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
        // ໄລຍະຫ່າງໃນລວງນອນ
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        ),
        // errorText: "ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ",
      ),
      validator: (val) {
        String value = val!.replaceAll(" ", "");
        if (value.isEmpty || value == "") {
          return "ປ້ອນລະຫັດຜ່ານກ່ອນ *";
        }
        return null;
      },
      onSaved: (val) {
        user.password = val!;
      },
    );
  }

  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).showUser();
    Provider.of<UserRoleProvider>(context, listen: false).showUserRole();
    Provider.of<RoleProvider>(context, listen: false).showRole();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        exit(0);
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Consumer3(builder: (context,
              UserProvider userProvider,
              UserRoleProvider userRoleProvider,
              RoleProvider roleProvider,
              child) {
            return Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                    0.5,
                    1.0,
                  ],
                      colors: [
                    Color.fromARGB(255, 136, 246, 254),
                    Color.fromARGB(255, 133, 255, 137),
                  ])),
              child: Center(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "ຊື່ຜູ້ໃຊ້ງານ ຫຼື ອີເມວ ຫຼື ເບີໂທ:",
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    textUserName(),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      "ລະຫັດຜ່ານ:",
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    textPassword(),
                                    SizedBox(
                                      height: 15.0,
                                    ),

                                    //====== Forgot Password and (Remember Me) =========
                                    Container(
                                      child: Row(
                                        children: [
                                          // Flexible(
                                          //   child: Container(
                                          //     child: Row(
                                          //       children: [
                                          //         Checkbox(
                                          //           value: rememberMe,
                                          //           onChanged: (value) {
                                          //             setState(() {
                                          //               rememberMe = value!;
                                          //             });
                                          //           },
                                          //         ),
                                          //         Text(
                                          //           "ຈື່ຂ້ອຍໄວ້",
                                          //           style:
                                          //               TextStyle(fontSize: 16.0),
                                          //         )
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ),
                                          Expanded(
                                            child: Container(
                                              child: GestureDetector(
                                                child: Text(
                                                  "ລືມລະຫັດຜ່ານ",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.black,
                                                      decoration: TextDecoration
                                                          .underline),
                                                  textAlign: TextAlign.end,
                                                ),
                                                onTap: () {
                                                  AwesomeDialog(
                                                    context: context,
                                                  )..show();
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //======End Forgot Password and (Remember Me) =========

                                    SizedBox(
                                      height: 15.0,
                                    ),

                                    // ============ Login Button ===============
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          1.0,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              backgroundColor: Colors.blue),
                                          child: Padding(
                                            padding: const EdgeInsets.all(9.0),
                                            child: Text(
                                              "ເຂົ້າສູ່ລະບົບ",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          onPressed: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              formKey.currentState?.save();

                                              List<User> userData = userProvider
                                                  .usersList
                                                  .where((e) =>
                                                      e.username ==
                                                          user.username ||
                                                      e.email == user.email ||
                                                      e.mobile == user.mobile)
                                                  .toList();
                                              AwesomeDialog(
                                                  context: context,
                                                  dialogType:
                                                      DialogType.noHeader,
                                                  dismissOnTouchOutside: false,
                                                  autoHide: Duration(
                                                      milliseconds: 3500),
                                                  dismissOnBackKeyPress: false,
                                                  body: Center(
                                                    child: Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 20.0,
                                                        ),
                                                        SpinKitCircle(
                                                          size: 120,
                                                          color: Colors.blue,
                                                        ),
                                                        const SizedBox(
                                                          height: 20.0,
                                                        ),
                                                        Text(
                                                          "ກຳລັງກວດສອບ..........",
                                                          style: TextStyle(
                                                              fontSize: 16.0),
                                                        ),
                                                        const SizedBox(
                                                          height: 20.0,
                                                        ),
                                                      ],
                                                    ),
                                                  ))
                                                ..show().then((value) {
                                                  if (userData.length == 0) {
                                                    AwesomeDialog(
                                                      context: context,
                                                      dialogType:
                                                          DialogType.error,
                                                      autoHide:
                                                          Duration(seconds: 2),
                                                      headerAnimationLoop:
                                                          false,
                                                      body: Center(
                                                          child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 40.0,
                                                          ),
                                                          Text(
                                                            "ບັນຊີບໍ່ຖືກຕ້ອງ",
                                                            style: TextStyle(
                                                                fontSize: 18.0),
                                                          ),
                                                          SizedBox(
                                                            height: 40.0,
                                                          ),
                                                        ],
                                                      )),
                                                    )..show().then((value) {
                                                        Navigator.of(context)
                                                            .pushAndRemoveUntil(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            loginPage()),
                                                                (route) => route
                                                                    .isCurrent);
                                                      });
                                                  } else if (userData.length ==
                                                      1) {
                                                    if (userData[0].password !=
                                                        user.password) {
                                                      AwesomeDialog(
                                                        context: context,
                                                        dialogType:
                                                            DialogType.error,
                                                        autoHide: Duration(
                                                            seconds: 2),
                                                        headerAnimationLoop:
                                                            false,
                                                        body: Center(
                                                            child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 20.0,
                                                            ),
                                                            Text(
                                                              "ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16.0),
                                                            ),
                                                            SizedBox(
                                                              height: 20.0,
                                                            ),
                                                          ],
                                                        )),
                                                      )..show();
                                                    } else {
                                                      List<UserRole> userRole =
                                                          userRoleProvider
                                                              .user_roleList
                                                              .where((e) =>
                                                                  e.user_id_fk ==
                                                                  userData[0]
                                                                      .user_id_pk)
                                                              .toList();

                                                      // ===== Start 1 Role =====
                                                      if (userRole.length ==
                                                          1) {
                                                        List<Role> roleData = roleProvider
                                                            .roleList
                                                            .where((element) =>
                                                                element
                                                                    .role_id_pk ==
                                                                userRole[0]
                                                                    .role_id_fk)
                                                            .toList();
                                                        SetUserLogin(
                                                            userData[0]
                                                                .user_id_pk,
                                                            roleData[0].role);

                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    TabItemScreen(
                                                                        currentIndex2:
                                                                            0)));
                                                      }
                                                      //======== End 1 Role =======//

                                                      //========= Start 2 Role ==========
                                                      else if (userRole
                                                              .length ==
                                                          2) {
                                                        List<Role> roleData1 =
                                                            roleProvider
                                                                .roleList
                                                                .where((e) =>
                                                                    e.role_id_pk ==
                                                                    userRole[0]
                                                                        .role_id_fk)
                                                                .toList();
                                                        List<Role> roleData2 =
                                                            roleProvider
                                                                .roleList
                                                                .where((e) =>
                                                                    e.role_id_pk ==
                                                                    userRole[1]
                                                                        .role_id_fk)
                                                                .toList();
                                                        List twoRole = [
                                                          roleData1[0].role,
                                                          roleData2[0].role
                                                        ];
                                                        AwesomeDialog(
                                                          context: context,
                                                          dialogType: DialogType
                                                              .noHeader,
                                                          animType:
                                                              AnimType.scale,
                                                          dismissOnTouchOutside:
                                                              false,
                                                          dismissOnBackKeyPress:
                                                              false,
                                                          body: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20.0),
                                                            child: Container(
                                                              child:
                                                                  FormBuilder(
                                                                key:
                                                                    formKeyBuilder,
                                                                child: Column(
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      'ເຂົ້າລະບົບດ້ວຍ :',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .headline6,
                                                                    ),
                                                                    Divider(),
                                                                    const SizedBox(
                                                                      height:
                                                                          30.0,
                                                                    ),
                                                                    FormBuilderRadioGroup(
                                                                      wrapAlignment:
                                                                          WrapAlignment
                                                                              .start, // default
                                                                      wrapSpacing:
                                                                          15.0, // spacing choose gender
                                                                      orientation:
                                                                          OptionsOrientation
                                                                              .vertical, // ຈັດຮູບແບບລວງນອນ, ລວງຕັ້ງ wrap is default value
                                                                      activeColor:
                                                                          Theme.of(context)
                                                                              .primaryColor,

                                                                      name:
                                                                          "Role",
                                                                      decoration:
                                                                          InputDecoration(
                                                                              errorStyle: TextStyle(fontSize: 14.0)),
                                                                      options: twoRole
                                                                          .map((e) => FormBuilderFieldOption(
                                                                                value: e,
                                                                                child: Text(
                                                                                  e,
                                                                                  style: TextStyle(fontSize: 16.0),
                                                                                ),
                                                                              ))
                                                                          .toList(),
                                                                      validator:
                                                                          FormBuilderValidators.required(
                                                                              errorText: "ເລືອກສະຖານະກ່ອນ *"),
                                                                      onSaved:
                                                                          (val) {
                                                                        role.role =
                                                                            val!;
                                                                      },
                                                                      controlAffinity:
                                                                          ControlAffinity
                                                                              .leading,
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          30,
                                                                    ),
                                                                    AnimatedButton(
                                                                      isFixedHeight:
                                                                          false,
                                                                      height:
                                                                          40.0,
                                                                      text:
                                                                          'ເຂົ້າສູ່ລະບົບ',
                                                                      buttonTextStyle: TextStyle(
                                                                          fontSize:
                                                                              16.0,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                      pressEvent:
                                                                          () {
                                                                        if (formKeyBuilder
                                                                            .currentState!
                                                                            .validate()) {
                                                                          formKeyBuilder
                                                                              .currentState
                                                                              ?.save();

                                                                          // store user : shared preferences
                                                                          SetUserLogin(
                                                                              userData[0].user_id_pk,
                                                                              role.role);

                                                                          AwesomeDialog(
                                                                              context: context,
                                                                              dialogType: DialogType.noHeader,
                                                                              dismissOnTouchOutside: false,
                                                                              autoHide: Duration(milliseconds: 3500),
                                                                              body: Center(
                                                                                child: Column(
                                                                                  children: [
                                                                                    const SizedBox(
                                                                                      height: 20.0,
                                                                                    ),
                                                                                    SpinKitSpinningLines(
                                                                                      size: 120,
                                                                                      color: Colors.blue,
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 20.0,
                                                                                    ),
                                                                                    Text(
                                                                                      "ກຳລັງເຂົ້າສູ່ລະບົບ..........",
                                                                                      style: TextStyle(fontSize: 16.0),
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 20.0,
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ))
                                                                            ..show().then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => TabItemScreen(currentIndex2: 0))));
                                                                        }
                                                                      },
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )..show();
                                                      }
                                                      //========= End 2 Role ==========

                                                      //Start Role: User, Manager, Admin
                                                      else if (userRole
                                                              .length ==
                                                          3) {
                                                        List<Role> roleData1 =
                                                            roleProvider
                                                                .roleList
                                                                .where((e) =>
                                                                    e.role_id_pk ==
                                                                    userRole[0]
                                                                        .role_id_fk)
                                                                .toList();
                                                        List<Role> roleData2 =
                                                            roleProvider
                                                                .roleList
                                                                .where((e) =>
                                                                    e.role_id_pk ==
                                                                    userRole[1]
                                                                        .role_id_fk)
                                                                .toList();
                                                        List<Role> roleData3 =
                                                            roleProvider
                                                                .roleList
                                                                .where((e) =>
                                                                    e.role_id_pk ==
                                                                    userRole[2]
                                                                        .role_id_fk)
                                                                .toList();
                                                        List threeRole = [
                                                          roleData1[0].role,
                                                          roleData2[0].role,
                                                          roleData3[0].role
                                                        ];
                                                        AwesomeDialog(
                                                          context: context,
                                                          dialogType: DialogType
                                                              .noHeader,
                                                          animType:
                                                              AnimType.scale,
                                                          showCloseIcon: true,
                                                          dismissOnTouchOutside:
                                                              false,
                                                          dismissOnBackKeyPress:
                                                              true,
                                                          body: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20.0),
                                                            child: Container(
                                                              child:
                                                                  FormBuilder(
                                                                key:
                                                                    formKeyBuilder,
                                                                child: Column(
                                                                  children: [
                                                                    Text(
                                                                      'ເຂົ້າລະບົບດ້ວຍ :',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .headline6,
                                                                    ),
                                                                    Divider(),
                                                                    const SizedBox(
                                                                      height:
                                                                          30.0,
                                                                    ),
                                                                    FormBuilderRadioGroup(
                                                                      wrapAlignment:
                                                                          WrapAlignment
                                                                              .start, // default
                                                                      wrapSpacing:
                                                                          15.0, // spacing choose gender
                                                                      orientation:
                                                                          OptionsOrientation
                                                                              .vertical, // ຈັດຮູບແບບລວງນອນ, ລວງຕັ້ງ wrap is default value
                                                                      activeColor:
                                                                          Theme.of(context)
                                                                              .primaryColor,

                                                                      name:
                                                                          "Role",
                                                                      decoration:
                                                                          InputDecoration(
                                                                              errorStyle: TextStyle(fontSize: 14.0)),
                                                                      options: threeRole
                                                                          .map((e) => FormBuilderFieldOption(
                                                                                value: e,
                                                                                child: Text(
                                                                                  e,
                                                                                  style: TextStyle(fontSize: 16.0),
                                                                                ),
                                                                              ))
                                                                          .toList(),
                                                                      validator:
                                                                          FormBuilderValidators.required(
                                                                              errorText: "ເລືອກສະຖານະກ່ອນ *"),
                                                                      onSaved:
                                                                          (val) {
                                                                        role.role =
                                                                            val!;
                                                                      },
                                                                      controlAffinity:
                                                                          ControlAffinity
                                                                              .leading,
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          30,
                                                                    ),
                                                                    AnimatedButton(
                                                                      isFixedHeight:
                                                                          false,
                                                                      height:
                                                                          40.0,
                                                                      text:
                                                                          'ເຂົ້າສູ່ລະບົບ',
                                                                      buttonTextStyle: TextStyle(
                                                                          fontSize:
                                                                              16.0,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                      pressEvent:
                                                                          () {
                                                                        if (formKeyBuilder
                                                                            .currentState!
                                                                            .validate()) {
                                                                          formKeyBuilder
                                                                              .currentState
                                                                              ?.save();

                                                                          SetUserLogin(
                                                                              userData[0].user_id_pk,
                                                                              role.role);

                                                                          AwesomeDialog(
                                                                              context: context,
                                                                              dialogType: DialogType.noHeader,
                                                                              dismissOnTouchOutside: false,
                                                                              autoHide: Duration(milliseconds: 3500),
                                                                              body: Center(
                                                                                child: Column(
                                                                                  children: [
                                                                                    const SizedBox(
                                                                                      height: 20.0,
                                                                                    ),
                                                                                    SpinKitSpinningLines(
                                                                                      size: 120,
                                                                                      color: Colors.blue,
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 20.0,
                                                                                    ),
                                                                                    Text(
                                                                                      "ກຳລັງເຂົ້າສູ່ລະບົບ..........",
                                                                                      style: TextStyle(fontSize: 16.0),
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 20.0,
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ))
                                                                            ..show().then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => TabItemScreen(currentIndex2: 0))));
                                                                        }
                                                                      },
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )..show();
                                                      }
                                                      //End Role: User, Manager, Admin
                                                    }
                                                  }
                                                });
                                            }
                                          }),
                                    ),
                                    // ============ End Login Button ===========

                                    SizedBox(
                                      height: 20.0,
                                    ),

                                    //========= Create User and Profile =========
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          1.0,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "ຍັງບໍ່ມີບັນຊີ?",
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            GestureDetector(
                                              child: Text(
                                                "ລົງທະບຽນ",
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.blue,
                                                    decoration: TextDecoration
                                                        .underline),
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            RegisterPage()));
                                              },
                                            ),
                                          ]),
                                    ),
                                    //========= End Create User and Profile=======

                                    SizedBox(
                                      height: 20.0,
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Future<void> SetUserLogin(String userid_login, String role_login) async {
    final shared_pref = SharedPreferences.getInstance();
    final prefs = await shared_pref;
    prefs.setString("UserID_Login", userid_login);
    prefs.setString("Role_Login", role_login);
  }
}
