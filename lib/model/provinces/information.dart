import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'province_constructor.dart';
import 'province_provider.dart';

class InformationProvince extends StatefulWidget {
  const InformationProvince({super.key});

  @override
  State<InformationProvince> createState() => _InformationProvinceState();
}

class _InformationProvinceState extends State<InformationProvince> {
  final formKey = GlobalKey<FormState>();
  Province provinceConstructor = Province(province_id_pk: "", province: "");

  //Load User Shared Preferences
  String? UserID_Login;
  String? Role_Login;
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
    Provider.of<ProvinceProvider>(context, listen: false).showProvince();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, ProvinceProvider provinceProvider, child) {
      int Id = 1;
      if (UserID_Login == null && Role_Login == null) {
        return Center(child: CircularProgressIndicator());
      } else {
        if (Role_Login == "Admin") {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: DataTable2(
                border: TableBorder(
                  left: BorderSide(width: 1, color: Colors.blue.shade100),
                  top: BorderSide(width: 1, color: Colors.blue.shade100),
                  right: BorderSide(width: 1, color: Colors.blue.shade100),
                  bottom: BorderSide(width: 1, color: Colors.blue.shade100),
                  horizontalInside:
                      BorderSide(width: 1, color: Colors.blue.shade100),
                ),
                minWidth: MediaQuery.of(context).size.width * 1.0,
                columnSpacing: 20.0,
                dataRowHeight: 40.0,
                horizontalMargin: 0,
                headingRowHeight: 40.0,
                dividerThickness: 0,
                columns: [
                  DataColumn2(
                      fixedWidth: MediaQuery.of(context).size.width * 0.15,
                      label: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('ລຳດັບ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      )),
                  DataColumn2(
                      fixedWidth: MediaQuery.of(context).size.width * 0.39,
                      label: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'ແຂວງ',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      )),
                  DataColumn2(
                      fixedWidth: MediaQuery.of(context).size.width * 0.2,
                      label: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ແກ້ໄຂ',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                  DataColumn2(
                      fixedWidth: MediaQuery.of(context).size.width * 0.2,
                      label: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ລົບ',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                ],
                rows: provinceProvider.provinceList
                    .map((e) => DataRow2(cells: [
                          DataCell(Center(child: Text((Id++).toString()))),
                          DataCell(Text(e.province)),
                          DataCell(Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                                'ອັບເດດແຂວງ',
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
                                                  initialValue: e.province,
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
                                                      provinceConstructor
                                                          .province = val!,
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
                                                    Province provinces = Province(
                                                        province_id_pk:
                                                            e.province_id_pk,
                                                        province:
                                                            provinceConstructor
                                                                .province);
                                                    ProvinceProvider provider =
                                                        Provider.of<
                                                                ProvinceProvider>(
                                                            context,
                                                            listen: false);
                                                    provider.solveProvince(
                                                        provinces);
                                                    Future.delayed(
                                                        Duration(
                                                            milliseconds: 300),
                                                        () {
                                                      Navigator.of(context).pop(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  InformationProvince()));
                                                    });
                                                    setState(() {
                                                      Provider.of<ProvinceProvider>(
                                                              context,
                                                              listen: false)
                                                          .showProvince();
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
                                      ProvinceProvider provinceProvider =
                                          Provider.of<ProvinceProvider>(context,
                                              listen: false);
                                      provinceProvider
                                          .removeProvince(e.province_id_pk);

                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.success,
                                        title: 'ລົບສຳເລັດ',
                                        autoHide: Duration(milliseconds: 1600),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 30.0),
                                      )..show().then((value) => setState(() {
                                            Provider.of<ProvinceProvider>(
                                                    context,
                                                    listen: false)
                                                .showProvince();
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
            ),
          );
        }
        // Show for Manager
        else if (Role_Login == "Manager") {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "ແຂວງ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width * 1.0,
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10.0),
              child: DataTable2(
                border: TableBorder.all(color: Colors.blue.shade100, width: 1),
                fixedTopRows: 1,
                columnSpacing: 20,
                horizontalMargin: 5,
                dataRowHeight: 40,
                columns: [
                  DataColumn2(
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ລຳດັບ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    fixedWidth: 70.0,
                  ),
                  DataColumn2(
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ແຂວງ',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    fixedWidth: 200.0,
                  ),
                  DataColumn2(
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ແກ້ໄຂ',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    fixedWidth: 80.0,
                  ),
                ],
                rows: provinceProvider.provinceList
                    .map((e) => DataRow2(
                          cells: [
                            DataCell(Center(child: Text((Id++).toString()))),
                            DataCell(Text(e.province)),
                            DataCell(Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                                  'ອັບເດດແຂວງ',
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
                                                    initialValue: e.province,
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
                                                        provinceConstructor
                                                            .province = val!,
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
                                                      Province provinces = Province(
                                                          province_id_pk:
                                                              e.province_id_pk,
                                                          province:
                                                              provinceConstructor
                                                                  .province);
                                                      ProvinceProvider
                                                          provider =
                                                          Provider.of<
                                                                  ProvinceProvider>(
                                                              context,
                                                              listen: false);
                                                      provider.solveProvince(
                                                          provinces);
                                                      Future.delayed(
                                                          Duration(
                                                              milliseconds:
                                                                  300), () {
                                                        Navigator.of(context).pop(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        InformationProvince()));
                                                      });
                                                      setState(() {
                                                        Provider.of<ProvinceProvider>(
                                                                context,
                                                                listen: false)
                                                            .showProvince();
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
                          ],
                        ))
                    .toList(),
              ),
            ),
          );
        }
        // Show for User
        else {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "ແຂວງ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Scrollbar(
                scrollbarOrientation: ScrollbarOrientation.right,
                child: DataTable2(
                  border:
                      TableBorder.all(width: 1, color: Colors.blue.shade100),
                  dataRowHeight: 40.0,
                  columnSpacing: 20.0,
                  headingRowHeight: 40.0,
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                  dividerThickness: 0,
                  columns: [
                    DataColumn2(
                        fixedWidth: MediaQuery.of(context).size.width * 0.2,
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('ລຳດັບ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        )),
                    DataColumn2(
                        fixedWidth: MediaQuery.of(context).size.width * 0.4,
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'ແຂວງ',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  ],
                  rows: provinceProvider.provinceList
                      .map((e) => DataRow2(cells: [
                            DataCell(Center(child: Text((Id++).toString()))),
                            DataCell(Text(e.province)),
                          ]))
                      .toList(),
                ),
              ),
            ),
          );
        }
      }
    });
  }
}
