import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_management_system/model/provinces/province_constructor.dart';
import 'package:user_management_system/model/provinces/province_provider.dart';

import 'district_constructor.dart';
import 'district_provider.dart';

class InformationDistrict extends StatefulWidget {
  const InformationDistrict({super.key});

  @override
  State<InformationDistrict> createState() => _Informationelementtate();
}

class _Informationelementtate extends State<InformationDistrict> {
  final formKey = GlobalKey<FormState>();
  Province provinceConstructor = Province(province_id_pk: "", province: "");
  District districtConstructor =
      District(province_id_fk: "", district_id_pk: "", district: "");

  List<Province> provinceData = [];
  String? dropdown;

  // Shared Preferences
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
    Provider.of<DistrictProvider>(context, listen: false).showDistrict();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2(builder: (context, ProvinceProvider provinceProvider,
        DistrictProvider districtProvider, child) {
      int Id = 1;
      if (UserID_Login == null && Role_Login == null) {
        return Center(child: CircularProgressIndicator());
      } else {
        // Data Table for Admin
        if (Role_Login == "Admin") {
          return Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width * 1.0,
              child: Consumer2(
                builder: (context, ProvinceProvider provinceProvider,
                    DistrictProvider districtProvider, child) {
                  int Id = 1;
                  return SingleChildScrollView(
                    child: DataTable(
                      columnSpacing: 10.0,
                      showBottomBorder: true,
                      dataRowHeight: 45.0,
                      horizontalMargin: 5.0,
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
                          'ເມືອງ',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Text(
                          'ແຂວງ',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Expanded(
                          child: Text(
                            'ອື່ນໆ',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        )),
                      ],
                      rows: districtProvider.districtList.map((element) {
                        provinceData = provinceProvider.provinceList
                            .where((provinces) =>
                                provinces.province_id_pk ==
                                element.province_id_fk)
                            .toList();
                        return DataRow(cells: [
                          DataCell(Center(child: Text((Id++).toString()))),
                          DataCell(Text(element.district)),
                          DataCell(Text(provinceData[0].province)),
                          DataCell(
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                PopupMenuButton(
                                    iconSize: 15.0,
                                    onSelected: (item) {
                                      if (item == "update") {
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
                                                      'ອັບເດດເມືອງ',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6,
                                                    ),
                                                    Divider(),
                                                    const SizedBox(
                                                      height: 30.0,
                                                    ),
                                                    DropdownButtonFormField(
                                                      value: dropdown,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'ເລືອກແຂວງ',
                                                        errorStyle: TextStyle(
                                                            fontSize: 14.0),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 0.0,
                                                                horizontal:
                                                                    10.0),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1.5,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1.5,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1.5,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1.5,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                      items: provinceProvider
                                                          .provinceList
                                                          .map<
                                                                  DropdownMenuItem<
                                                                      String>>(
                                                              (value) {
                                                        return DropdownMenuItem<
                                                                String>(
                                                            value: value
                                                                .province_id_pk,
                                                            child: Text(value
                                                                .province));
                                                      }).toList(),
                                                      validator:
                                                          FormBuilderValidators
                                                              .required(
                                                                  errorText:
                                                                      'ເລືອກແຂວງກ່ອນ *'),
                                                      onChanged: (val) {
                                                        provinceProvider
                                                            .showProvince();
                                                        setState(() {
                                                          dropdown = val;
                                                        });
                                                      },
                                                      onSaved: (val) {
                                                        districtConstructor
                                                                .province_id_fk =
                                                            val.toString();
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 50.0,
                                                    ),
                                                    TextFormField(
                                                      autofocus: true,
                                                      minLines: 1,
                                                      initialValue:
                                                          element.district,
                                                      decoration:
                                                          InputDecoration(
                                                        errorStyle: TextStyle(
                                                            fontSize: 14.0),
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        0.0,
                                                                    horizontal:
                                                                        10.0),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1.5,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1.5,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1.5,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1.5,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                      validator:
                                                          FormBuilderValidators
                                                              .required(
                                                                  errorText:
                                                                      'ປ້ອນເມືອງກ່ອນ *'),
                                                      onSaved: (val) =>
                                                          districtConstructor
                                                              .district = val!,
                                                    ),
                                                    const SizedBox(
                                                      height: 30,
                                                    ),
                                                    AnimatedButton(
                                                      isFixedHeight: false,
                                                      height: 40.0,
                                                      text: 'ອັບເດດ',
                                                      pressEvent: () {
                                                        if (formKey
                                                            .currentState!
                                                            .validate()) {
                                                          formKey.currentState
                                                              ?.save();
                                                          print(
                                                              districtConstructor
                                                                  .district);
                                                          District districts = District(
                                                              province_id_fk:
                                                                  districtConstructor
                                                                      .province_id_fk,
                                                              district_id_pk:
                                                                  element
                                                                      .district_id_pk,
                                                              district:
                                                                  districtConstructor
                                                                      .district);
                                                          DistrictProvider
                                                              provider_district =
                                                              Provider.of<
                                                                      DistrictProvider>(
                                                                  context,
                                                                  listen:
                                                                      false);
                                                          provider_district
                                                              .solveDistrict(
                                                                  districts);

                                                          Future.delayed(
                                                              Duration(
                                                                  milliseconds:
                                                                      300), () {
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                          setState(() {
                                                            Provider.of<DistrictProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .showDistrict();
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
                                      } else if (item == "delete") {
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
                                          padding: EdgeInsets.symmetric(
                                              vertical: 20.0),
                                          btnOkText: 'ຕົກລົງ',
                                          btnCancelText: 'ຍົກເລີກ',
                                          btnCancelOnPress: () {},
                                          btnOkOnPress: () {
                                            DistrictProvider provider_district =
                                                Provider.of<DistrictProvider>(
                                                    context,
                                                    listen: false);
                                            provider_district.removeDistrict(
                                                element.district_id_pk);

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
                                                  Provider.of<DistrictProvider>(
                                                          context,
                                                          listen: false)
                                                      .showDistrict();
                                                  Provider.of<ProvinceProvider>(
                                                          context,
                                                          listen: false)
                                                      .showProvince();
                                                });
                                              });
                                          },
                                        )..show();
                                      }
                                    },
                                    itemBuilder: (context) => [
                                          PopupMenuItem(
                                            value: "update",
                                            child: Text("ແກ້ໄຂ"),
                                          ),
                                          PopupMenuItem(
                                            value: "delete",
                                            child: Text("ລົບ"),
                                          ),
                                        ]),
                              ],
                            ),
                          )
                        ]);
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
          );
        }
        // Data Table for Manger
        else if (Role_Login == "Manager") {
          return Scaffold(
            appBar: AppBar(
                title: Text(
              "ເມືອງ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
            body: Container(
              width: MediaQuery.of(context).size.width * 1.0,
              margin:
                  const EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
              child: DataTable2(
                border: TableBorder(
                  left: BorderSide(width: 1.0, color: Colors.blue.shade100),
                  top: BorderSide(width: 1.0, color: Colors.blue.shade100),
                  right: BorderSide(width: 1.0, color: Colors.blue.shade100),
                  bottom: BorderSide(width: 1.0, color: Colors.blue.shade100),
                  horizontalInside:
                      BorderSide(width: 1.0, color: Colors.blue.shade100),
                ),
                fixedTopRows: 1,
                columnSpacing: 10.0,
                dataRowHeight: 45.0,
                dividerThickness: 0,
                horizontalMargin: 5.0,
                headingRowHeight: 50.0,
                columns: [
                  DataColumn2(
                      fixedWidth: 50,
                      label: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('ລຳດັບ',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      )),
                  DataColumn2(
                    fixedWidth: 140,
                    label: Text('ເມືອງ',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                  DataColumn2(
                    fixedWidth: 140,
                    label: Text('ແຂວງ',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                  DataColumn2(
                      fixedWidth: 55,
                      label: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('ແກ້ໄຂ',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      )),
                ],
                rows: districtProvider.districtList.map((element) {
                  provinceData = provinceProvider.provinceList
                      .where((provinces) =>
                          provinces.province_id_pk == element.province_id_fk)
                      .toList();
                  return DataRow(cells: [
                    DataCell(Center(child: Text((Id++).toString()))),
                    DataCell(Text(element.district)),
                    DataCell(Text(provinceData[0].province)),
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
                              transitionAnimationDuration: Duration(seconds: 1),
                              body: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      children: [
                                        Text(
                                          'ອັບເດດເມືອງ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                        Divider(),
                                        const SizedBox(
                                          height: 30.0,
                                        ),
                                        DropdownButtonFormField(
                                          value: dropdown,
                                          decoration: InputDecoration(
                                            labelText: 'ເລືອກແຂວງ',
                                            errorStyle:
                                                TextStyle(fontSize: 14.0),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 0.0,
                                                    horizontal: 10.0),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 1.5,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 1.5,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 1.5,
                                                color: Colors.red,
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 1.5,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                          items: provinceProvider.provinceList
                                              .map<DropdownMenuItem<String>>(
                                                  (value) {
                                            return DropdownMenuItem<String>(
                                                value: value.province_id_pk,
                                                child: Text(value.province));
                                          }).toList(),
                                          validator:
                                              FormBuilderValidators.required(
                                                  errorText: 'ເລືອກແຂວງກ່ອນ *'),
                                          onChanged: (val) {
                                            provinceProvider.showProvince();
                                            setState(() {
                                              dropdown = val;
                                            });
                                          },
                                          onSaved: (val) {
                                            districtConstructor.province_id_fk =
                                                val.toString();
                                          },
                                        ),
                                        SizedBox(
                                          height: 50.0,
                                        ),
                                        TextFormField(
                                          autofocus: true,
                                          minLines: 1,
                                          initialValue: element.district,
                                          decoration: InputDecoration(
                                            errorStyle:
                                                TextStyle(fontSize: 14.0),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 0.0,
                                                    horizontal: 10.0),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 1.5,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 1.5,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 1.5,
                                                color: Colors.red,
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 1.5,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                          validator:
                                              FormBuilderValidators.required(
                                                  errorText: 'ປ້ອນເມືອງກ່ອນ *'),
                                          onSaved: (val) => districtConstructor
                                              .district = val!,
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
                                              formKey.currentState?.save();
                                              print(
                                                  districtConstructor.district);
                                              District districts = District(
                                                  province_id_fk:
                                                      districtConstructor
                                                          .province_id_fk,
                                                  district_id_pk:
                                                      element.district_id_pk,
                                                  district: districtConstructor
                                                      .district);
                                              DistrictProvider
                                                  provider_district =
                                                  Provider.of<DistrictProvider>(
                                                      context,
                                                      listen: false);
                                              provider_district
                                                  .solveDistrict(districts);

                                              Future.delayed(
                                                  Duration(milliseconds: 300),
                                                  () {
                                                Navigator.pop(context);
                                              });
                                              setState(() {
                                                Provider.of<DistrictProvider>(
                                                        context,
                                                        listen: false)
                                                    .showDistrict();
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
                  ]);
                }).toList(),
              ),
            ),
          );
        }
        // Datable for user
        else {
          return Scaffold(
            appBar: AppBar(
                title: Text(
              "ເມືອງ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: DataTable2(
                border: TableBorder.all(width: 1, color: Colors.blue.shade100),
                columnSpacing: 20,
                dividerThickness: 0,
                dataRowHeight: 45.0,
                horizontalMargin: 10,
                headingRowHeight: 50.0,
                minWidth: MediaQuery.of(context).size.width * 1.0,
                columns: [
                  DataColumn2(
                      fixedWidth: MediaQuery.of(context).size.width * 0.15,
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
                      fixedWidth: MediaQuery.of(context).size.width * 0.35,
                      label: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ເມືອງ',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                  DataColumn2(
                      fixedWidth: MediaQuery.of(context).size.width * 0.35,
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
                rows: districtProvider.districtList.map((element) {
                  provinceData = provinceProvider.provinceList
                      .where((provinces) =>
                          provinces.province_id_pk == element.province_id_fk)
                      .toList();
                  return DataRow(cells: [
                    DataCell(Center(child: Text((Id++).toString()))),
                    DataCell(Text(element.district)),
                    DataCell(Text(provinceData[0].province)),
                  ]);
                }).toList(),
              ),
            ),
          );
        }
      }
    });
  }
}
