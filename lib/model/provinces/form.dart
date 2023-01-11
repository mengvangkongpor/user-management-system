import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'province_constructor.dart';
import 'province_provider.dart';

class FormProvince extends StatefulWidget {
  const FormProvince({super.key});

  @override
  State<FormProvince> createState() => _FormProvinceState();
}

class _FormProvinceState extends State<FormProvince> {
  var uuid = Uuid();

  final formKey = GlobalKey<FormState>();
  TextEditingController provinceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<ProvinceProvider>(context, listen: false).showProvince();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width * 1.0,
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
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
                TextFormField(
                  controller: provinceController,
                  decoration: InputDecoration(
                      hintText: 'ປ້ອນຊື່ແຂວງ',
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
                            provinceController = TextEditingController();
                          });
                        },
                        child: Icon(
                          FontAwesomeIcons.circleXmark,
                          size: 20.0,
                          color: Colors.blue,
                        ),
                      )),
                  validator: FormBuilderValidators.required(
                      errorText: "ປ້ອນແຂວງກ່ອນ *"),
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
                      String province_id_pk = uuid.v4();
                      String provinceName = provinceController.text.trim();
                      Province provinces = Province(
                          province_id_pk: province_id_pk,
                          province: provinceName);
                      ProvinceProvider provider =
                          Provider.of<ProvinceProvider>(context, listen: false);
                      provider.addProvince(provinces);
                      provinceController.clear();
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
