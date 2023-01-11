import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:user_management_system/model/roles/role_constructor.dart';
import 'package:user_management_system/model/roles/role_provider.dart';

class InformationRole extends StatefulWidget {
  const InformationRole({super.key});

  @override
  State<InformationRole> createState() => _InformationRoleState();
}

class _InformationRoleState extends State<InformationRole> {
  final formKey = GlobalKey<FormState>();
  Role roleConstructor = Role(role_id_pk: "", role: "");

  @override
  void initState() {
    super.initState();
    Provider.of<RoleProvider>(context, listen: false).showRole();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width * 1.0,
        padding: EdgeInsets.only(left: 5.0, right: 5.0),
        child: Consumer(
          builder: (context, RoleProvider roleProvider, child) {
            int Id = 1;
            return SingleChildScrollView(
              child: DataTable(
                columnSpacing: 10.0,
                showBottomBorder: true,
                dataRowHeight: 40.0,
                horizontalMargin: 0.0,
                headingRowHeight: 50.0,
                columns: [
                  DataColumn(
                      label: Expanded(
                    child: Text('ລຳດັບ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )),
                  )),
                  DataColumn(
                      label: Text(
                    'ແຂວງ',
                    // textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  )),
                  DataColumn(
                      label: Expanded(
                    child: Text(
                      'ແກ້ໄຂ',
                      textAlign: TextAlign.end,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  )),
                  DataColumn(
                      label: Expanded(
                    child: Text(
                      'ລົບ',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  )),
                ],
                rows: roleProvider.roleList
                    .map((e) => DataRow(cells: [
                          DataCell(Center(child: Text((Id++).toString()))),
                          DataCell(Text(e.role)),
                          DataCell(Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.penClip,
                                  size: 12.0,
                                  color: Colors.orange,
                                ),
                                onPressed: () {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.noHeader,
                                    animType: AnimType.bottomSlide,
                                    showCloseIcon: true,
                                    dismissOnTouchOutside: false,
                                    transitionAnimationDuration:
                                        Duration(seconds: 1),
                                    body: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Container(
                                        child: Form(
                                          key: formKey,
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                'ອັບເດດສະຖານະ',
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
                                                child: TextFormField(
                                                  autofocus: true,
                                                  minLines: 1,
                                                  initialValue: e.role,
                                                  decoration:
                                                      const InputDecoration(
                                                    errorStyle: TextStyle(
                                                        fontSize: 14.0),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 5.0,
                                                    ),
                                                  ),
                                                  validator: FormBuilderValidators
                                                      .required(
                                                          errorText:
                                                              'ປ້ອນຊື່ແຂວງກ່ອນ *'),
                                                  onSaved: (val) =>
                                                      roleConstructor.role =
                                                          val!,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              AnimatedButton(
                                                isFixedHeight: false,
                                                height: 40.0,
                                                text: 'ອັບເດດ',
                                                pressEvent: () {
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    formKey.currentState
                                                        ?.save();
                                                    var role_id_pk =
                                                        e.role_id_pk;
                                                    var role = roleConstructor
                                                        .role
                                                        .trim();
                                                    Role roles = Role(
                                                        role_id_pk: role_id_pk,
                                                        role: role);
                                                    RoleProvider provider =
                                                        Provider.of<
                                                                RoleProvider>(
                                                            context,
                                                            listen: false);
                                                    provider.solveRole(roles);
                                                    Future.delayed(
                                                        Duration(
                                                            milliseconds: 300),
                                                        () {
                                                      // Navigator.of(context).pop(
                                                      //     MaterialPageRoute(
                                                      //         builder: (context) =>
                                                      //             InformationRole()));
                                                      Navigator.pop(context);
                                                    });
                                                    setState(() {
                                                      Provider.of<RoleProvider>(
                                                              context,
                                                              listen: false)
                                                          .showRole();
                                                    });
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
                              )
                            ],
                          )),
                          DataCell(Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.trash,
                                  size: 12.0,
                                  color: Colors.red,
                                ),
                                onPressed: () {
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
                                      RoleProvider roleProvider =
                                          Provider.of<RoleProvider>(context,
                                              listen: false);
                                      roleProvider.removeRole(e.role_id_pk);

                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.success,
                                        title: 'ລົບສຳເລັດ',
                                        autoHide: Duration(milliseconds: 1600),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 30.0),
                                      )..show().then((value) => setState(() {
                                            Provider.of<RoleProvider>(context,
                                                    listen: false)
                                                .showRole();
                                          }));
                                    },
                                  )..show();
                                },
                              ),
                            ],
                          )),
                        ]))
                    .toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
