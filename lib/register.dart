import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_management_system/model/profiles/create_profile_by_user.dart';
import 'package:user_management_system/model/roles/role_constructor.dart';
import 'package:user_management_system/model/roles/role_provider.dart';
import 'package:user_management_system/model/users/user_constructor.dart';
import 'package:user_management_system/model/users/user_provider.dart';
import 'package:user_management_system/model/users_has_roles/user_role_provider.dart';
import 'package:user_management_system/model/users_has_roles/users_roles_contructor.dart';
import 'package:uuid/uuid.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var uuid = Uuid().v4();

  final formKey = GlobalKey<FormState>();
  OutlineInputBorder enabledBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 1.2),
      borderRadius: BorderRadius.circular(10.0));
  OutlineInputBorder focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 1.2),
      borderRadius: BorderRadius.circular(10.0));
  OutlineInputBorder errorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1.2),
      borderRadius: BorderRadius.circular(10.0));
  EdgeInsets contentPadding =
      EdgeInsets.only(top: 0.0, bottom: 0.0, right: 10.0);
  TextStyle errorStyle = TextStyle(fontSize: 14.0);

  User userConstructor =
      User(user_id_pk: "", username: "", email: "", mobile: "", password: "");
  final passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).showUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "ຟອມສະໝັກບັນຊີຜູ້ໃຊ້ງານ",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Consumer3(
                builder: (context,
                    UserProvider userProvider,
                    UserRoleProvider userRoleProvider,
                    RoleProvider roleProvider,
                    child) {
                  return Form(
                    key: formKey,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1.0,
                      child: Column(children: [
                        // ============ Username =============
                        Container(
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.account_circle),
                              labelText: 'ຊື່ຜູ້ໃຊ້ງານ',
                              errorStyle: errorStyle,
                              enabledBorder: enabledBorder,
                              focusedBorder: focusedBorder,
                              errorBorder: errorBorder,
                              focusedErrorBorder: errorBorder,
                              contentPadding: contentPadding,
                              errorMaxLines: 2,
                            ),
                            validator: (value) {
                              String newValue = value!.trim();
                              if (newValue.isEmpty) {
                                return "ປ້ອນຊື່ຜູ້ໃຊ້ງານກ່ອນ *";
                              } else {
                                if (newValue.length > 30) {
                                  return "ຊື່ຜູ້ໃຊ້ງານຕ້ອງຍາວບໍ່ເກີນ 30 ຕົວອັກສອນ *";
                                } else if (newValue.length < 4) {
                                  return "ຊື່ຜູ້ໃຊ້ງານຕ້ອງມີຢ່າງໜ້ອຍ 4 ຕົວອັກສອນ *";
                                } else if (RegExp(
                                            r'^[^0-9!@#\$%\^&*()_+-=/|<>?]\w*$')
                                        .hasMatch(newValue) ==
                                    false) {
                                  return "ຊື່ຜູ້ໃຊ້ງານຕ້ອງຂຶ້ນຕົ້ນດ້ວຍຕົວອັກສອນ, ຕ້ອງບໍ່ມີຄ່າຫວ່າງ ແລະ ບໍ່ມີຕົວອັກສອນພິເສດ *";
                                } else {
                                  List<User> checkUsername = userProvider
                                      .usersList
                                      .where((e) => e.username == newValue)
                                      .toList();
                                  if (checkUsername.length == 1) {
                                    return "ມີຊື່ຜູ້ໃຊ້ງານນີ້ແລ້ວ ກະລຸນາປ່ຽນຊື່ໃໝ່ *";
                                  }
                                }
                              }
                              return null;
                            },
                            onSaved: (val) {
                              userConstructor.username = val!;
                            },
                          ),
                        ),
                        // ============= End Username ===============

                        SizedBox(
                          height: 20.0,
                        ),

                        // ================ Email ==================
                        Container(
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              labelText: 'ອີເມວ',
                              errorStyle: errorStyle,
                              enabledBorder: enabledBorder,
                              focusedBorder: focusedBorder,
                              errorBorder: errorBorder,
                              focusedErrorBorder: errorBorder,
                              contentPadding: contentPadding,
                            ),
                            validator: (value) {
                              String newValue = value!.trim();
                              if (newValue.isEmpty) {
                                return "ປ້ອນອີເມວກ່ອນ *";
                              } else if (RegExp(
                                          r'^[^0-9!@#\$%\^&*()_+-=/|<>?]*[a-z0-9*]{4,40}@(gmail)|(outlook)|(yohoo)\.com$')
                                      .hasMatch(newValue) ==
                                  false) {
                                return "ອີເມວບໍ່ຖືກຕ້ອງ *";
                              } else {
                                List<User> checkEmail = userProvider.usersList
                                    .where((e) => e.email == newValue)
                                    .toList();
                                if (checkEmail.length == 1) {
                                  if (checkEmail[0].email == newValue) {
                                    return "ອີເມວນີ້ຖືກນຳໃຊ້ແລ້ວ ກະລຸນາໃຊ້ອີເມວອື່ນ *";
                                  }
                                }
                              }
                              return null;
                            },
                            onSaved: (val) {
                              userConstructor.email = val!;
                            },
                          ),
                        ),
                        // =============== End Email ===============

                        SizedBox(
                          height: 20.0,
                        ),

                        // =============== Mobile ==================
                        Container(
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone),
                              labelText: 'ເບີໂທ',
                              hintText: '020xxxxxxxx',
                              errorStyle: errorStyle,
                              enabledBorder: enabledBorder,
                              focusedBorder: focusedBorder,
                              errorBorder: errorBorder,
                              focusedErrorBorder: errorBorder,
                              contentPadding: contentPadding,
                            ),
                            validator: (value) {
                              /* ໃຊ້ repaceAll() function ເພື່ອຕັດຄ່າຫວ່າງອອກໄປ 
                                    ກ່ອນທີ່ຈະເອົາເບີໂທທຳງານຂັ້ນຕອນຕໍ່ໄປ */
                              String newValue = value!.replaceAll(" ", "");
                              if (newValue.isEmpty) {
                                return "ປ້ອນເບີໂທກ່ອນ *";
                              } else if (newValue.isNotEmpty) {
                                if (RegExp(r'^(020)[2579]\d{7}$')
                                        .hasMatch(newValue) ==
                                    false) {
                                  return "ເບີໂທບໍ່ຖືກຕ້ອງ *";
                                } else {
                                  List<User> checkMobile = userProvider
                                      .usersList
                                      .where((e) => e.mobile == newValue)
                                      .toList();
                                  if (checkMobile.length == 1) {
                                    return "ເບີໂທນີ້ຖືກນຳໃຊ້ແລ້ວ ກະລຸນາປ່ຽນເບີອື່ນ *";
                                  }
                                }
                              }
                              return null;
                            },
                            onSaved: (val) {
                              userConstructor.mobile = val!;
                            },
                          ),
                        ),
                        // ================== End Mobile ==================

                        SizedBox(
                          height: 20.0,
                        ),

                        // =================== Password ===================
                        Container(
                          child: TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.password),
                              labelText: 'ລະຫັດຜ່ານ',
                              errorStyle: errorStyle,
                              errorMaxLines: 2,
                              enabledBorder: enabledBorder,
                              focusedBorder: focusedBorder,
                              errorBorder: errorBorder,
                              focusedErrorBorder: errorBorder,
                              contentPadding: contentPadding,
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Icon(
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  )),
                            ),
                            validator: (value) {
                              String newValue = value!;
                              if (newValue.isEmpty) {
                                return "ປ້ອນລະຫັດຜ່ານກ່ອນ *";
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
                          ),
                        ),
                        // ================== End Password ===================

                        SizedBox(
                          height: 20.0,
                        ),

                        // ================ Confirm Password ============
                        Container(
                          child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              labelText: 'ຢືນຢັນລະຫັດຜ່ານ',
                              errorStyle: errorStyle,
                              enabledBorder: enabledBorder,
                              focusedBorder: focusedBorder,
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
                                } else if (value != passwordController.text) {
                                  return "ລະຫັດຜ່ານບໍ່ຕົງກັນ *";
                                }
                              }
                              return null;
                            },
                            onSaved: (val) {
                              userConstructor.password = val!;
                            },
                          ),
                        ),
                        //================ End Confirm Password ==============

                        SizedBox(
                          height: 30.0,
                        ),

                        //=============== Submit Button ===================
                        ElevatedButton(
                          child: Text(
                            "ບັນທຶກ",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(
                                  MediaQuery.of(context).size.width * 1.0,
                                  50.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              var user_id_pk = uuid;
                              User addedUser = User(
                                  user_id_pk: user_id_pk,
                                  username: userConstructor.username,
                                  email: userConstructor.email,
                                  mobile: userConstructor.mobile,
                                  password: userConstructor.password);

                              // Added Role User
                              List<Role> roleList = roleProvider.roleList
                                  .where((e) => e.role == "User")
                                  .toList();

                              UserRole added_user_role = UserRole(
                                  user_id_fk: user_id_pk,
                                  role_id_fk: roleList[0].role_id_pk);

                              // Route to profile
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddProfileByUser(
                                            user: addedUser,
                                            user_role: added_user_role,
                                          )));
                            }
                          },
                        )
                        //=============== End Submit Button ===============
                      ]),
                    ),
                  );
                },
              )),
        ),
      ),
    );
  }
}
