import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:user_management_system/model/districts/district_constructor.dart';
import 'package:user_management_system/model/districts/district_provider.dart';
import 'package:user_management_system/model/profiles/profile_constructor.dart';
import 'package:user_management_system/model/profiles/profile_provider.dart';
import 'package:user_management_system/model/provinces/province_provider.dart';
import 'package:user_management_system/model/users/user_constructor.dart';
import 'package:user_management_system/model/users/user_provider.dart';
import 'package:user_management_system/model/users_has_roles/user_role_provider.dart';
import 'package:user_management_system/model/users_has_roles/users_roles_contructor.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class AddProfileByUser extends StatefulWidget {
  AddProfileByUser({required this.user, required this.user_role, super.key});

  User user =
      User(user_id_pk: "", username: "", email: "", mobile: "", password: "");
  UserRole user_role = UserRole(user_id_fk: "", role_id_fk: "");

  @override
  State<AddProfileByUser> createState() => _AddProfileByUserState();
}

class _AddProfileByUserState extends State<AddProfileByUser> {
  var profile_id_pk_uuid = Uuid().v4();

  final formKey = GlobalKey<FormBuilderState>();
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
      EdgeInsets.only(left: 10.0, top: 0.0, bottom: 0.0, right: 10.0);
  TextStyle errorStyle = TextStyle(fontSize: 14.0);

  Profile profileConstructor = Profile(
      user_id_fk: "",
      profile_id_pk: "",
      firstname: "",
      lastname: "",
      gender: "",
      dob: "",
      village: "",
      district_id_fk: "",
      province_id_fk: "",
      imgprofile: "");

  List<String> genderOptions = ["ຊາຍ", "ຍິງ", "ບໍ່ລະບຸ"];
  String? province_id_pk;
  String? district;
  List<District> autoDistrictList = [];

  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).showUser();
    Provider.of<ProvinceProvider>(context, listen: false).showProvince();
    Provider.of<DistrictProvider>(context, listen: false).showDistrict();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "ເພີ່ມໂປຣໄຟລ໌ຜູ້ໃຊ້ງານ",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ]),
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Consumer3(
                builder: (context,
                    UserProvider userProvider,
                    ProvinceProvider provinceProvider,
                    DistrictProvider districtProvider,
                    child) {
                  return FormBuilder(
                    key: formKey,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1.0,
                      child: Column(children: [
                        // ============ First Name =============
                        Container(
                          child: FormBuilderTextField(
                            name: 'First Name',
                            decoration: InputDecoration(
                              labelText: 'ຊື່',
                              errorStyle: errorStyle,
                              enabledBorder: enabledBorder,
                              focusedBorder: focusedBorder,
                              errorBorder: errorBorder,
                              focusedErrorBorder: errorBorder,
                              contentPadding: contentPadding,
                              errorMaxLines: 2,
                            ),
                            validator: FormBuilderValidators.required(
                                errorText: 'ປ້ອນຊື່ກ່ອນ *'),
                            onSaved: (val) {
                              profileConstructor.firstname = val!;
                            },
                          ),
                        ),
                        // ============= End First Name ===============

                        SizedBox(
                          height: 25.0,
                        ),

                        // ============ Last Name =============
                        Container(
                          child: FormBuilderTextField(
                            name: 'Last Name',
                            decoration: InputDecoration(
                              labelText: 'ນາມສະກຸນ',
                              errorStyle: errorStyle,
                              enabledBorder: enabledBorder,
                              focusedBorder: focusedBorder,
                              errorBorder: errorBorder,
                              focusedErrorBorder: errorBorder,
                              contentPadding: contentPadding,
                              errorMaxLines: 2,
                            ),
                            validator: FormBuilderValidators.required(
                                errorText: 'ປ້ອນຊື່ກ່ອນ *'),
                            onSaved: (val) {
                              profileConstructor.lastname = val!;
                            },
                          ),
                        ),
                        // ============= End Last Name ===============

                        // =============== Gender ================
                        Container(
                          child: FormBuilderRadioGroup(
                            wrapAlignment: WrapAlignment.start, // default
                            wrapSpacing: 15.0, // spacing choose gender
                            orientation: OptionsOrientation
                                .wrap, // ຈັດຮູບແບບລວງນອນ, ລວງຕັ້ງ wrap is default value
                            activeColor: Theme.of(context).primaryColor,
                            name: "Gender",
                            options: genderOptions
                                .map((e) => FormBuilderFieldOption(
                                      value: e,
                                      child: Text(e),
                                    ))
                                .toList(growable: false),
                            validator: FormBuilderValidators.required(
                                errorText: "ເລືອກເພດກ່ອນ *"),
                            onSaved: (val) {
                              profileConstructor.gender = val.toString();
                            },
                            controlAffinity: ControlAffinity.leading,
                          ),
                        ),
                        // ============= End Gender ===============

                        SizedBox(
                          height: 25.0,
                        ),

                        // ============ Date of Birth =============
                        Container(
                          child: DateTimePicker(
                            type: DateTimePickerType.date,
                            decoration: InputDecoration(
                              labelText: 'ວັນເດືອນປີເກີດ',
                              errorStyle: errorStyle,
                              prefixIcon: Icon(Icons.event),
                              enabledBorder: enabledBorder,
                              focusedBorder: focusedBorder,
                              errorBorder: errorBorder,
                              focusedErrorBorder: errorBorder,
                              contentPadding: contentPadding,
                            ),
                            dateMask: 'dd/MM/yyyy',
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2030),
                            validator: FormBuilderValidators.required(
                                errorText: 'ເລືອກວັນເດືອນປີເກີດ *'),
                            onSaved: (val) {
                              profileConstructor.dob = val.toString();
                            },
                          ),
                        ),
                        // ============= End Date of Birth ===============

                        SizedBox(
                          height: 25.0,
                        ),

                        // =============== Province ================
                        Container(
                          child: DropdownButtonFormField(
                            value: province_id_pk,
                            decoration: InputDecoration(
                              labelText: 'ແຂວງ',
                              errorStyle: errorStyle,
                              enabledBorder: enabledBorder,
                              focusedBorder: focusedBorder,
                              errorBorder: errorBorder,
                              focusedErrorBorder: focusedBorder,
                              contentPadding: contentPadding,
                            ),
                            items: provinceProvider.provinceList.map((value) {
                              return DropdownMenuItem<String>(
                                  value: value.province_id_pk,
                                  child: Text(value.province));
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                province_id_pk = val;
                                // ເມື່ອເລືອກເມືອງແລ້ວ ແຕ່ຢາກປ່ຽນແຂວງ ເມື່ອກັບມາເລືອກແຂວງ ເມືອງເກົ່າຈະເປັນຄ່າວ່າງ
                                district = null;
                                autoDistrictList = districtProvider.districtList
                                    .where((element) =>
                                        element.province_id_fk.toString() ==
                                        province_id_pk.toString())
                                    .toList();
                              });
                            },
                            validator: FormBuilderValidators.required(
                                errorText: "ເລືອກແຂວງກ່ອນ *"),
                            onSaved: (val) {
                              profileConstructor.province_id_fk =
                                  val.toString();
                            },
                          ),
                        ),
                        // ============= End Province ===============

                        SizedBox(
                          height: 25.0,
                        ),

                        // =============== District ================
                        Container(
                          child: DropdownButtonFormField(
                            value: district,
                            decoration: InputDecoration(
                              labelText: 'ເມືອງ',
                              errorStyle: errorStyle,
                              enabledBorder: enabledBorder,
                              focusedBorder: focusedBorder,
                              errorBorder: errorBorder,
                              focusedErrorBorder: focusedBorder,
                              contentPadding: contentPadding,
                            ),
                            items: autoDistrictList
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem(
                                  value: value.district_id_pk,
                                  child: Text(value.district));
                            }).toList(),
                            validator: FormBuilderValidators.required(
                                errorText: "ເລືອກເມືອງກ່ອນ *"),
                            onChanged: (val) {
                              setState(() {
                                district = val.toString();
                              });
                            },
                            onSaved: (val) {
                              profileConstructor.district_id_fk =
                                  val.toString();
                            },
                          ),
                        ),
                        // ============= End District ===============

                        SizedBox(
                          height: 25.0,
                        ),

                        // =============== Village ================
                        Container(
                          child: FormBuilderTextField(
                            name: 'Village',
                            decoration: InputDecoration(
                              labelText: 'ບ້ານ',
                              errorStyle: errorStyle,
                              enabledBorder: enabledBorder,
                              focusedBorder: focusedBorder,
                              errorBorder: errorBorder,
                              focusedErrorBorder: errorBorder,
                              contentPadding: contentPadding,
                              errorMaxLines: 2,
                            ),
                            validator: FormBuilderValidators.required(
                                errorText: 'ປ້ອນຊື່ບ້ານກ່ອນ *'),
                            onSaved: (val) {
                              profileConstructor.village = val!;
                            },
                          ),
                        ),

                        // ============= End District ===============

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

                              UserProvider provider_user =
                                  Provider.of<UserProvider>(context,
                                      listen: false);
                              provider_user.addUser(widget.user);

                              UserRoleProvider provider_userrole =
                                  Provider.of<UserRoleProvider>(context,
                                      listen: false);
                              provider_userrole.addUserRole(widget.user_role);

                              Profile profile = Profile(
                                  user_id_fk: widget.user.user_id_pk,
                                  profile_id_pk: profile_id_pk_uuid,
                                  firstname: profileConstructor.firstname,
                                  lastname: profileConstructor.lastname,
                                  gender: profileConstructor.gender,
                                  dob: profileConstructor.dob,
                                  village: profileConstructor.village,
                                  district_id_fk:
                                      profileConstructor.district_id_fk,
                                  province_id_fk:
                                      profileConstructor.province_id_fk,
                                  imgprofile: "");
                              ProfileProvider provider =
                                  Provider.of<ProfileProvider>(context,
                                      listen: false);
                              provider.addProfile(profile);

                              Navigator.of(context)
                                ..pop()
                                ..pop()
                                ..popUntil((route) => route.isCurrent);
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
