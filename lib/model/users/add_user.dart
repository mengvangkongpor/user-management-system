import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:user_management_system/model/profiles/create_profile_by_manager_admin.dart';
import 'package:user_management_system/model/roles/role_constructor.dart';
import 'package:user_management_system/model/roles/role_provider.dart';
import 'package:user_management_system/model/users/user_constructor.dart';
import 'package:user_management_system/model/users/user_provider.dart';
import 'package:user_management_system/model/users_has_roles/users_roles_contructor.dart';
import 'package:uuid/uuid.dart';

class addUser extends StatefulWidget {
  const addUser({super.key});

  @override
  State<addUser> createState() => _addUserState();
}

//---------------- Username ---------------------
class _addUserState extends State<addUser> {
  var uuid = Uuid();
  // formKey
  final _formKey = GlobalKey<FormState>();
  // Users _users = Users(username: "", email: "", mobile: "", password: "");
  // ສ້າງຕົວປ່ຽນໄວ້ ເພື່ອເອົາໄປ ກວດສອບວ່າ ລະຫັດຜ່ານ ກັບ ລະຫັດຢືນຢັນ ຕົງກັນບໍ
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _cfpassword = TextEditingController();
  // Enable , Focus Color
  OutlineInputBorder correctTextField = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: BorderSide(
        width: 1.5,
        color: Colors.blue,
      ));
  // Er
  OutlineInputBorder errorTextField = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: BorderSide(
        width: 1.5,
        color: Colors.red,
      ));
  OutlineInputBorder? focusedBorder;

  // ວາງຕົວປ່ຽນ ເພື່ອເອົາໄປໃຊ້ງານ ການສະແດງລະຫັດ ແລະ ເຊື່ອງລະຫັດ
  bool _obscureText = true;

  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).showUser();
    Provider.of<RoleProvider>(context, listen: false).showRole();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2(
        builder: (context, UserProvider userProvider, RoleProvider roleProvider,
            child) {
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        boxShadow: [
                          BoxShadow(
                            color: HexColor('#E8E8E8'),
                            offset: const Offset(
                              0.0,
                              0.0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 5.0,
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: const Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ),
                        ]),
                    child: Column(children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 1.0,
                        padding: const EdgeInsets.fromLTRB(10, 10.0, 10.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(
                                  50.0, 5.0, 0.0, 3.0),
                              child: Text(
                                "ຊື່ຜູ້ໃຊ້ງານ :",
                                style: TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            Container(
                              child: TextFormField(
                                controller: _username,
                                style: TextStyle(fontSize: 14.0),

                                decoration: InputDecoration(
                                  errorStyle: TextStyle(fontSize: 12.0),
                                  hintText: "ປ້ອນຊື່ຜູ້ໃຊ້ງານ",
                                  icon: Icon(
                                    Icons.person,
                                    size: 25.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  enabledBorder: correctTextField,
                                  focusedBorder: correctTextField,
                                  errorBorder: errorTextField,
                                  focusedErrorBorder: errorTextField,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() =>
                                          _username = TextEditingController());
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      size: 18.0,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                // validator: MultiValidator([
                                //   RequiredValidator(errorText: "ກະລຸນາປ້ອນຊື່ຜູ້ໃຊ້ກ່ອນ"),
                                //   MinLengthValidator(4,
                                //       errorText: "ຊື່ຜູ້ໃຊ້ຕ້ອງມີ 4 ຕົວສອນຂຶ້ນໄປ"),
                                // ]),
                                validator: (value) {
                                  // ໃຊ້ trim() function ເພື່ອຕັດຄ່າຫວ່າງຊ້າຍ, ຂວາ ອອກໄປ
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
                                // onSaved: (username_form) {
                                //   String username = username_form!;
                                //   _users.username = username.trim();
                                // },
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ===================== Email =========================
                      Container(
                        width: MediaQuery.of(context).size.width * 1.0,
                        padding: const EdgeInsets.fromLTRB(10, 5.0, 10.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(
                                  50.0, 5.0, 0.0, 3.0),
                              child: Text(
                                "ອີເມວ :",
                                style: TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            Container(
                              child: TextFormField(
                                controller: _email,
                                // ເປັນເຮັດໃຫ້ແປ້ນພິມ ມີປຸ່ມ @ ຂຶ້ນມາຢູ່ຂ້າງປຸ່ມປ່ຽນພາສາ
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(fontSize: 14.0),
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(fontSize: 12.0),
                                  hintText: "ປ້ອນອີເມວ",
                                  icon: Icon(
                                    Icons.email,
                                    size: 25.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  enabledBorder: correctTextField,
                                  focusedBorder: correctTextField,
                                  errorBorder: errorTextField,
                                  focusedErrorBorder: errorTextField,
                                  contentPadding: EdgeInsets.symmetric(
                                    // vertical: 10.0,
                                    horizontal: 10.0,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() =>
                                          _email = TextEditingController());
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      size: 18.0,
                                      color: Colors.blue,
                                    ),
                                  ),
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
                                    List<User> checkEmail = userProvider
                                        .usersList
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
                                // ຖ້າໃຊ້ package: form_field_validator
                                // MultiValidator([
                                //   RequiredValidator(errorText: "ກະລຸນາປ້ອນອີເມວກ່ອນ"),
                                //   EmailValidator(errorText: "ອີເມວບໍ່ຖືກຕ້ອງ"),
                                // ]),
                                // onSaved: (dynamic email_form) {
                                //   String email = email_form;
                                //   _users.email = email.replaceAll(" ", "");
                                // },
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ===================== Mobile Phone ==================
                      Container(
                        width: MediaQuery.of(context).size.width * 1.0,
                        padding: const EdgeInsets.fromLTRB(10, 5.0, 10.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(
                                  50.0, 5.0, 0.0, 3.0),
                              child: Text(
                                "ເບີໂທ :",
                                style: TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            Container(
                              child: TextFormField(
                                controller: _mobile,
                                // ກຳນົດຮູບແບບແປ້ນພິມຈາກມືຖືໃຫ້ເປັນແປ້ນພີມແບບຕົວເລກ
                                keyboardType: TextInputType.phone,
                                style: TextStyle(fontSize: 14.0),
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(fontSize: 12.0),
                                  hintText: "020xxxxxxxx",
                                  icon: Icon(
                                    Icons.call,
                                    size: 25.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  enabledBorder: correctTextField,
                                  focusedBorder: correctTextField,
                                  errorBorder: errorTextField,
                                  focusedErrorBorder: errorTextField,
                                  contentPadding: EdgeInsets.symmetric(
                                    // vertical: 10.0,
                                    horizontal: 10.0,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() =>
                                          _mobile = TextEditingController());
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      size: 18.0,
                                      color: Colors.blue,
                                    ),
                                  ),
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

                                // onSaved: (dynamic mobile_form) {
                                //   String mobile = mobile_form;
                                //   _users.mobile = mobile.replaceAll(" ", "");
                                // },
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ==================== Password =======================
                      Container(
                        width: MediaQuery.of(context).size.width * 1.0,
                        padding: const EdgeInsets.fromLTRB(10, 5.0, 10.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(
                                  50.0, 10.0, 0.0, 3.0),
                              child: Text(
                                "ລະຫັດຜ່ານ :",
                                style: TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            Container(
                              child: TextFormField(
                                controller: _password,
                                // ເຊື່ອງລະຫັດທີ່ປ້ອນ ໃຫ້ເປັນ (....)
                                obscureText: _obscureText,
                                keyboardType: TextInputType.visiblePassword,
                                maxLength: 20,
                                style: TextStyle(fontSize: 14.0),
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(fontSize: 12.0),
                                  hintText: "ປ້ອນລະຫັດຜ່ານ",
                                  icon: Icon(
                                    Icons.password,
                                    size: 25.0,
                                    color: Theme.of(context).primaryColor,
                                  ),

                                  enabledBorder: correctTextField,
                                  focusedBorder: correctTextField,
                                  errorBorder: errorTextField,
                                  focusedErrorBorder: errorTextField,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),

                                  // ສະແດງລະຫັດຜ່ານ ແລະ ເຊື່ອງລະຫັດຜ່ານ
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
                                        color: Theme.of(context).primaryColor,
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
                                // onSaved: (dynamic password_form) {
                                //   String password = password_form;
                                //   _users.password = password.replaceAll(" ", "");
                                // },
                              ),
                            ),
                          ],
                        ),
                      ),

                      // =================== Confirm password =================
                      Container(
                        width: MediaQuery.of(context).size.width * 1.0,
                        padding: const EdgeInsets.fromLTRB(10, 0.0, 10.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(
                                  50.0, 5.0, 0.0, 3.0),
                              child: Text(
                                "ຢືນຢັນລະຫັດຜ່ານ :",
                                style: TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            Container(
                              child: TextFormField(
                                controller: _cfpassword,

                                // ເຊື່ອງລະຫັດທີ່ປ້ອນ ໃຫ້ເປັນ (....)
                                obscureText: true,
                                maxLength: 20,
                                keyboardType: TextInputType.visiblePassword,
                                style: TextStyle(fontSize: 14.0),
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(fontSize: 12.0),
                                  hintText: "ປ້ອນລະຫັດຢືນຢັນ",
                                  icon: Icon(
                                    Icons.lock_outline,
                                    size: 25.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  enabledBorder: correctTextField,
                                  focusedBorder: correctTextField,
                                  errorBorder: errorTextField,
                                  focusedErrorBorder: errorTextField,
                                  contentPadding: EdgeInsets.symmetric(
                                    // vertical: 10.0,
                                    horizontal: 10.0,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() => _cfpassword =
                                          TextEditingController());
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      size: 18.0,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "ປ້ອນລະຫັດຢືນຢັນກ່ອນ *";
                                  } else {
                                    if (value.length < 6) {
                                      return "ລະຫັດຜ່ານຕ້ອງມີຢ່າງໜ້ອຍ 6 ຕົວຂຶ້ນໄປ *";
                                    } else if (value != _password.text) {
                                      return "ລະຫັດຜ່ານບໍ່ຕົງກັນ *";
                                    }
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ============== Button Submit or Save ================
                      Container(
                        width: MediaQuery.of(context).size.width * 1.0,
                        padding: EdgeInsets.only(
                          top: 20.0,
                          bottom: 25.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Reset
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0))),
                                onPressed: () {
                                  // ລ້າງຂໍ້ມູນ
                                  _formKey.currentState?.reset();
                                },
                                child: Text(
                                  "ລ້າງ",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            // Submit
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0))),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    var user_id_pk = uuid.v4();
                                    var username = _username.text;
                                    var email = _email.text;
                                    var mobile = _mobile.text;
                                    var password = _password.text;
                                    User _users = User(
                                        user_id_pk: user_id_pk,
                                        username: username,
                                        email: email,
                                        mobile: mobile,
                                        password: password);

                                    // ເອີ້ນໃຊ້ຂໍ້ມູນຈາກ provider
                                    // UserProvider provider =
                                    //     Provider.of<UserProvider>(context,
                                    //         listen: false);
                                    // provider.addUser(_users);
                                    // Added Role User
                                    List<Role> roleList = roleProvider.roleList
                                        .where((e) => e.role == "User")
                                        .toList();

                                    UserRole added_user_role = UserRole(
                                        user_id_fk: user_id_pk,
                                        role_id_fk: roleList[0].role_id_pk);

                                    _username.clear();
                                    _email.clear();
                                    _mobile.clear();
                                    _password.clear();
                                    _cfpassword.clear();

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddUProfileByAdmin(
                                                    user: _users,
                                                    user_role:
                                                        added_user_role)));
                                  }
                                },
                                child: Text(
                                  "ບັນທຶກ",
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
