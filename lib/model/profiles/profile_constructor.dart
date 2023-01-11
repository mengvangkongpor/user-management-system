class AddName {
  String profile_id_pk;
  String firstname;
  String lastname;
  AddName(
      {required this.profile_id_pk,
      required this.firstname,
      required this.lastname});
}

class AddGenderDob {
  String gender;
  String dob;
  AddGenderDob({required this.gender, required this.dob});
}

class AddAddress {
  String province_id_fk;
  String district_id_fk;
  String village;
  AddAddress(
      {required this.village,
      required this.district_id_fk,
      required this.province_id_fk});
}

class AddImgProfile {
  String imgprofile;
  AddImgProfile({required this.imgprofile});
}

class Profile {
  String user_id_fk;
  String profile_id_pk;
  String firstname;
  String lastname;
  String gender;
  String dob;
  String village;
  String district_id_fk;
  String province_id_fk;
  String imgprofile;
  Profile(
      {required this.user_id_fk,
      required this.profile_id_pk,
      required this.firstname,
      required this.lastname,
      required this.gender,
      required this.dob,
      required this.village,
      required this.district_id_fk,
      required this.province_id_fk,
      required this.imgprofile});
}
