import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:user_management_system/model/districts/district_constructor.dart';
import 'package:user_management_system/model/districts/district_provider.dart';
import 'package:user_management_system/model/provinces/province_constructor.dart';
import 'package:user_management_system/model/provinces/province_provider.dart';
import 'package:uuid/uuid.dart';

class FormDistrict extends StatefulWidget {
  const FormDistrict({super.key});

  @override
  State<FormDistrict> createState() => _FormDistrictState();
}

class _FormDistrictState extends State<FormDistrict> {
  var uuid = Uuid();

  final formKey = GlobalKey<FormState>();
  TextEditingController provinceController = TextEditingController();
  Province provinceConstructor = Province(province_id_pk: "", province: "");
  District districtConstructor =
      District(province_id_fk: "", district_id_pk: "", district: "");

  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: BorderSide(width: 1.5, color: Colors.blue),
  );
  final errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: BorderSide(width: 1.5, color: Colors.red),
  );

  String? dropdown;

  @override
  void initState() {
    super.initState();
    Provider.of<ProvinceProvider>(context, listen: false).showProvince();
    Provider.of<DistrictProvider>(context, listen: false).showDistrict();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(body: Consumer2(builder: (context,
          ProvinceProvider provinceProvider,
          DistrictProvider districtProvider,
          child) {
        return Container(
          width: MediaQuery.of(context).size.width * 1.0,
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Row(
                      children: [
                        Text(
                          "ແຂວງ :",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                  DropdownButtonFormField2(
                    value: dropdown,
                    buttonHeight: 50.0,
                    hint: Text('ເລືອກແຂວງ'),
                    buttonDecoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
                    buttonPadding: EdgeInsets.only(left: 0.0, right: 5.0),
                    dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(width: 1.5, color: Colors.blue)),
                    itemHeight: 30,
                    dropdownPadding: const EdgeInsets.all(0),
                    dropdownMaxHeight: 600.0,
                    selectedItemHighlightColor: Colors.blue,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(fontSize: 14.0),
                      enabledBorder: border,
                      focusedBorder: border,
                      errorBorder: errorBorder,
                      focusedErrorBorder: errorBorder,
                      contentPadding: EdgeInsets.all(0.0),
                    ),
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 28.0,
                    iconEnabledColor: Colors.blue,
                    items: provinceProvider.provinceList
                        .map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                          value: value.province_id_pk,
                          child: Text(value.province));
                    }).toList(),
                    validator: FormBuilderValidators.required(
                        errorText: 'ເລືອກແຂວງກ່ອນ *'),
                    onChanged: (val) {
                      provinceProvider.showProvince();
                      setState(() {
                        dropdown = val;
                      });
                    },
                    onSaved: (val) {
                      districtConstructor.province_id_fk = val.toString();
                    },
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Row(
                      children: [
                        Text(
                          "ເມືອງ :",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'ປ້ອນຊື່ເມືອງ',
                      errorStyle: TextStyle(fontSize: 14.0),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 15.0),
                      enabledBorder: border,
                      focusedBorder: border,
                      errorBorder: errorBorder,
                      focusedErrorBorder: errorBorder,
                    ),
                    validator: FormBuilderValidators.required(
                        errorText: 'ປ້ອນຊື່ເມືອງກ່ອນ *'),
                    onSaved: (value) =>
                        districtConstructor.district = value.toString(),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  AnimatedButton(
                    text: 'ບັນທຶກ',
                    buttonTextStyle:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    borderRadius: BorderRadius.circular(5.0),
                    pressEvent: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState?.save();
                        District districts = District(
                            province_id_fk: districtConstructor.province_id_fk,
                            district_id_pk: uuid.v4(),
                            district: districtConstructor.district);
                        DistrictProvider provider =
                            Provider.of<DistrictProvider>(context,
                                listen: false);
                        provider.addDistrict(districts);
                        formKey.currentState!.reset();
                        setState(() {
                          dropdown = null;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      })),
    );
  }
}
