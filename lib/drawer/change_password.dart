import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_management_system/model/roles/role_constructor.dart';
import 'package:user_management_system/model/roles/role_provider.dart';
import 'package:user_management_system/model/users/user_constructor.dart';
import 'package:user_management_system/model/users/user_provider.dart';
import 'package:user_management_system/model/users_has_roles/user_role_provider.dart';
import 'package:user_management_system/model/users_has_roles/users_roles_contructor.dart';

class PasswordScreen extends StatefulWidget {
  PasswordScreen({required this.user_id_pk, super.key});
  final String user_id_pk;

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  List<User> userData = [];

  final formKey = GlobalKey<FormState>();
  final oldpasswordController = TextEditingController();
  final newpasswordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  User user =
      User(user_id_pk: "", username: "", email: "", mobile: "", password: "");
  final errorStyle = TextStyle(fontSize: 14.0);

  bool old_obscureText = true;
  bool new_obscureText = true;
  bool autoFocus = false;

  final borderInput = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: BorderSide(color: Colors.blue, width: 1.5),
  );
  final errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: BorderSide(color: Colors.red, width: 1.5),
  );
  final contentPadding = EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0);

  String? UserID_Login;
  List<UserRole> USER_ROLE_DATA = [];
  List<Role> ROLE_DATA = [];

  Future<void> GetUserLogin() async {
    final shared_pref = await SharedPreferences.getInstance();
    final prefs = await shared_pref;
    setState(() {
      UserID_Login = prefs.getString("UserID_Login").toString();
    });
  }

  @override
  void initState() {
    super.initState();
    GetUserLogin();
    Provider.of<UserProvider>(context, listen: false).showUser();
    Provider.of<UserRoleProvider>(context, listen: false).showUserRole();
    Provider.of<RoleProvider>(context, listen: false).showRole();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "ປ່ຽນລະຫັດຜ່ານ",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          elevation: 4,
        ),
        body: Consumer(builder: (context, UserProvider userProvider, child) {
          userData = userProvider.usersList
              .where((e) => e.user_id_pk == widget.user_id_pk)
              .toList();
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Container(
                padding: EdgeInsets.only(left: 30.0, top: 50.0, right: 30.0),
                width: MediaQuery.of(context).size.width * 1.0,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      //================== Old Password ====================
                      TextFormField(
                        controller: oldpasswordController,
                        obscureText: old_obscureText,
                        decoration: InputDecoration(
                          labelText: "ລະຫັດຜ່ານເກົ່າ",
                          errorStyle: errorStyle,
                          enabledBorder: borderInput,
                          focusedBorder: borderInput,
                          errorBorder: errorBorder,
                          focusedErrorBorder: errorBorder,
                          contentPadding: contentPadding,
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  old_obscureText = !old_obscureText;
                                });
                              },
                              child: Icon(
                                old_obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.blue,
                              )),
                        ),
                        validator: (value) {
                          String newValue = value!;
                          if (newValue.isEmpty) {
                            return "ປ້ອນລະຫັດຜ່ານເກົ່າກ່ອນ *";
                          } else {
                            if (newValue.length < 6) {
                              return "ລະຫັດຜ່ານຕ້ອງມີຢ່າງໜ້ອຍ 6 ຕົວຂຶ້ນໄປ *";
                            }
                          }
                          return null;
                        },
                        onSaved: (val) {
                          user.password = val!;
                        },
                      ),
                      //================== End Old Password ==================

                      SizedBox(height: 30.0),

                      //================== New Password ====================
                      TextFormField(
                        controller: newpasswordController,
                        obscureText: new_obscureText,
                        decoration: InputDecoration(
                          labelText: "ລະຫັດຜ່ານໃໝ່",
                          errorStyle: errorStyle,
                          enabledBorder: borderInput,
                          focusedBorder: borderInput,
                          errorBorder: errorBorder,
                          focusedErrorBorder: errorBorder,
                          contentPadding: contentPadding,
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  new_obscureText = !new_obscureText;
                                });
                              },
                              child: Icon(
                                new_obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.blue,
                              )),
                        ),
                        validator: (value) {
                          String newValue = value!;
                          if (newValue.isEmpty) {
                            return "ປ້ອນລະຫັດຜ່ານໃໝ່ກ່ອນ *";
                          } else {
                            if (RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&_])[A-Za-z\d@$!%*#?&_]{6,}$')
                                    .hasMatch(newValue) ==
                                false) {
                              return "ລະຫັດຜ່ານຕ້ອງປະກອບດ້ວຍ ຕົວອັກສອນ, ຕົວເລກ, ຕົວອັກສອນພິເສດ: ! % * # ? & _  ແລະ ຕ້ອງບໍ່ມີຄ່າຫວ່າງ *";
                            } else if (newValue.length < 6) {
                              return "ລະຫັດຜ່ານຕ້ອງມີຢ່າງໜ້ອຍ 6 ຕົວຂຶ້ນໄປ *";
                            }
                          }
                          return null;
                        },
                        onSaved: (val) {
                          user.password = val!;
                        },
                      ),
                      //================== End New Password ==================

                      SizedBox(height: 30.0),

                      //================== Confirm New Password ==================
                      TextFormField(
                        controller: confirmpasswordController,
                        obscureText: true,
                        autofocus: autoFocus,
                        decoration: InputDecoration(
                          labelText: "ຢືນຢັນລະຫັດຜ່ານໃໝ່",
                          errorStyle: errorStyle,
                          enabledBorder: borderInput,
                          focusedBorder: borderInput,
                          errorBorder: errorBorder,
                          focusedErrorBorder: errorBorder,
                          contentPadding: contentPadding,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "ປ້ອນລະຫັດຢືນຢັນກ່ອນ *";
                          } else {
                            if (value.length < 6) {
                              return "ລະຫັດຜ່ານຕ້ອງມີຢ່າງໜ້ອຍ 6 ຕົວຂຶ້ນໄປ *";
                            } else if (value != newpasswordController.text) {
                              return "ລະຫັດຜ່ານບໍ່ຕົງກັນ *";
                            }
                          }
                          return null;
                        },
                        onSaved: (val) {
                          user.password = val!;
                        },
                      ),
                      //================= End Confirm New Password ==============

                      SizedBox(height: 50.0),

                      //================== Submit Button =====================
                      AnimatedButton(
                          buttonTextStyle: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                          text: "ບັນທຶກ",
                          borderRadius: BorderRadius.circular(5.0),
                          isFixedHeight: false,
                          height: 48.0,
                          pressEvent: () {
                            if (formKey.currentState!.validate()) {
                              if (oldpasswordController.text.toString() !=
                                  userData[0].password) {
                                AwesomeDialog(
                                  context: context,
                                  transitionAnimationDuration:
                                      Duration(milliseconds: 500),
                                  dismissOnTouchOutside: false,
                                  showCloseIcon: true,
                                  dialogType: DialogType.error,
                                  headerAnimationLoop: false,
                                  padding: EdgeInsets.only(top: 40.0),
                                  title: "ລະຫັດຜ່ານເກົ່າບໍ່ຖືກຕ້ອງ",
                                  btnCancelText: "ຕົກລົງ",
                                  btnCancelColor: Colors.blue,
                                  btnCancelOnPress: () {},
                                )..show();
                              } else {
                                User user = User(
                                    user_id_pk: widget.user_id_pk,
                                    username: "",
                                    email: "",
                                    mobile: "",
                                    password: newpasswordController.text);
                                UserProvider provider =
                                    Provider.of<UserProvider>(context,
                                        listen: false);
                                provider.solveUser(user);
                                // oldpasswordController.clear();
                                // newpasswordController.clear();
                                // confirmpasswordController.clear();
                                AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.success,
                                    autoHide: Duration(milliseconds: 2000),
                                    padding: EdgeInsets.only(
                                        top: 40.0, bottom: 30.0),
                                    title: "ແກ້ໄຂລະຫັດຜ່ານສຳເລັດ")
                                  ..show();
                                Timer(Duration(milliseconds: 2000), () {
                                  Navigator.of(context).pop();
                                });
                              }
                            }
                          }),
                      //================== End Submit Button ====================
                    ],
                  ),
                )),
          );
        }),
      ),
    );
  }
}
