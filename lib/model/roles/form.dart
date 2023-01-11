import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:user_management_system/model/roles/role_constructor.dart';
import 'package:user_management_system/model/roles/role_provider.dart';
import 'package:uuid/uuid.dart';

class FormRole extends StatefulWidget {
  const FormRole({super.key});

  @override
  State<FormRole> createState() => _FormRoleState();
}

class _FormRoleState extends State<FormRole> {
  var uuid = Uuid();

  final formKey = GlobalKey<FormState>();
  TextEditingController roleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<RoleProvider>(context, listen: false).showRole();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Container(
            width: MediaQuery.of(context).size.width * 1.0,
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Row(
                    children: [
                      Text(
                        "ສະຖານະ :",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  controller: roleController,
                  decoration: InputDecoration(
                      hintText: 'ປ້ອນສະຖານະ',
                      hintStyle: TextStyle(fontSize: 16.0),
                      errorStyle: TextStyle(fontSize: 14.0),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 0.0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(width: 1.5, color: Colors.blue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(width: 1.5, color: Colors.blue),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(width: 1.5, color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(width: 1.5, color: Colors.red),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            roleController = TextEditingController();
                          });
                        },
                        child: Icon(
                          FontAwesomeIcons.circleXmark,
                          size: 20.0,
                          color: Colors.blue,
                        ),
                      )),
                  validator: FormBuilderValidators.required(
                      errorText: "ປ້ອນສະຖານະກ່ອນ *"),
                ),
                SizedBox(
                  height: 30.0,
                ),
                AnimatedButton(
                  text: 'ບັນທຶກ',
                  buttonTextStyle:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  borderRadius: BorderRadius.circular(5.0),
                  pressEvent: () {
                    if (formKey.currentState!.validate()) {
                      String role_id_pk = uuid.v4();
                      String roleName = roleController.text.trim();
                      Role roles = Role(role_id_pk: role_id_pk, role: roleName);

                      RoleProvider provider =
                          Provider.of<RoleProvider>(context, listen: false);
                      provider.addRole(roles);
                      roleController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
