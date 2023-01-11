// import 'dart:io';

// import 'package:cool_alert/cool_alert.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:uuid/uuid.dart';

// class ImgProfilePage extends StatefulWidget {
//   ImgProfilePage({
//     super.key,
//     required this.user_id_pk,
//     required this.fisrtname,
//     required this.lastname,
//     required this.gender,
//     required this.dob,
//     required this.village,
//     required this.district_id_fk,
//     required this.province_id_fk,
//   });
//   final String user_id_pk;
//   final String fisrtname;
//   final String lastname;
//   final String gender;
//   final String dob;
//   final String village;
//   final String district_id_fk;
//   final String province_id_fk;

//   @override
//   State<ImgProfilePage> createState() => _ImgProfilePageState();
// }

// class _ImgProfilePageState extends State<ImgProfilePage> {
//   Uuid uuid = Uuid();
//   final ImagePicker _picker = ImagePicker();
//   File? _file;
//   XFile? image;
//   String validate = "";

//   Future<void> chooseImage(ImageSource imageSource) async {
//     image = await _picker.pickImage(
//         source: imageSource, maxHeight: 600.0, maxWidth: 600.0);
//     setState(() {
//       _file = File(image!.path);
//     });
//   }

//   Widget Back() {
//     return Container(
//       width: MediaQuery.of(context).size.width * 0.24,
//       child: ElevatedButton(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.keyboard_arrow_left),
//             Text(
//               "ກັບຄືນ",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//         onPressed: (() => Navigator.of(context).pop(MaterialPageRoute(
//             builder: (context) => AddressPage(
//                 user_id_pk: "${widget.user_id_pk}",
//                 firstname: "${widget.fisrtname}",
//                 lastname: "${widget.lastname}",
//                 gender: "${widget.gender}",
//                 dob: "${widget.dob}")))),
//       ),
//     );
//   }

//   Widget Save() {
//     return Container(
//       width: MediaQuery.of(context).size.width * 0.24,
//       child: ElevatedButton(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "ບັນທຶກ",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//         onPressed: () {
//           if (_file == null) {
//             setState(() {
//               validate = "ເລືອກຮູບໂປຣຟາຍກ່ອນ *";
//             });
//           } else {
//             setState(() {
//               validate = "";
//             });
//             var fileName = _file.toString();
//             print(_file);
//             // var _img = fileName
//             //     .replaceAll(
//             //         "File: '/data/user/0/com.example.user_management_system/cache/",
//             //         "")
//             //     .replaceAll("'", "");
//             // Profile profile = Profile(
//             //     user_id_fk: "${widget.user_id_pk}",
//             //     profile_id_pk: uuid.v4(),
//             //     firstname: "${widget.fisrtname}",
//             //     lastname: "${widget.lastname}",
//             //     gender: "${widget.gender}",
//             //     dob: "${widget.dob}",
//             //     village: "${widget.village}",
//             //     district_id_fk: "${widget.district_id_fk}",
//             //     province_id_fk: "${widget.province_id_fk}",
//             //     imgprofile: _img);
//             // ProfileProvider profileProvider =
//             //     Provider.of<ProfileProvider>(context, listen: false);
//             // profileProvider.addProfile(profile);
//             CoolAlert.show(
//               context: context,
//               type: CoolAlertType.success,
//               title: 'ຖືກຕ້ອງ',
//               text: 'ບັນທຶກໂປຣຟາຍສຳເລັດ',
//               autoCloseDuration: Duration(seconds: 2),
//               backgroundColor: Theme.of(context).primaryColor,
//               // flareAnimationName: 'play',
//               // confirmBtnText: 'Ok',
//               // onConfirmBtnTap: () => Navigator.pop(context),
//               confirmBtnTextStyle: TextStyle(
//                   fontSize: 16.0,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold),
//               // autoCloseDuration: Duration(seconds: 2),
//               // animType: ຮູບແບບການແຈ້ງເຕືອນ: ໝູນ, ຂຶ້ນກາງຈໍ, ຂຶ້ນຈາກ ຊ້າຍ, ຂວາ, ລຸ່ມ, ເທິງ
//               animType: CoolAlertAnimType.scale,

//               loopAnimation: true,
//               //false ເຮັດໃຫ້ຕ້ອງກົດປຸ່ມ ຕົກລົງຈຶ່ງປິດ cool_alert ໄດ້
//               //true ເຮັດໃຫ້ກົດໜ້າຈໍບ່ອນໃດ ກໍ່ປິດ cool_alert ໄດ້ , true is default
//               barrierDismissible: true,
//             );

//             // Navigator.pushAndRemoveUntil(context,
//             //     MaterialPageRoute(builder: (context) {
//             //   return Home(
//             //     currentIndex2: 3,
//             //   );
//             // }), (route) => route.isFirst);
//           }
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("ລະບົບຈັດການຜູ້ໃຊ້ງານ")),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Container(
//             width: MediaQuery.of(context).size.width * 0.8,
//             height: MediaQuery.of(context).size.height * 0.8,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   children: [
//                     Container(
//                       width: MediaQuery.of(context).size.width * 0.75,
//                       height: MediaQuery.of(context).size.height * 0.5,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.rectangle,
//                         borderRadius: BorderRadius.circular(10.0),
//                         image: DecorationImage(
//                             image: AssetImage('assets/images/chooseimage.png'),
//                             fit: BoxFit.fill),
//                       ),
//                       margin: const EdgeInsets.only(
//                         top: 50.0,
//                       ),
//                       child: _file == null
//                           ? Text("")
//                           : Image.file(_file!, fit: BoxFit.fill),
//                     ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.03,
//                       child: Text(
//                         validate.toString(),
//                         style: TextStyle(color: Colors.red, fontSize: 18.0),
//                       ),
//                     ),
//                     Container(
//                       height: MediaQuery.of(context).size.height * 0.1,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Container(
//                             child: IconButton(
//                               icon: Icon(
//                                 Icons.camera_alt,
//                                 size: 40.0,
//                                 color: Theme.of(context).primaryColor,
//                               ),
//                               onPressed: () {
//                                 chooseImage(ImageSource.camera);
//                               },
//                             ),
//                           ),
//                           Container(
//                             child: IconButton(
//                               icon: Icon(
//                                 Icons.image,
//                                 size: 40.0,
//                                 color: Theme.of(context).primaryColor,
//                               ),
//                               onPressed: () {
//                                 chooseImage(ImageSource.gallery);
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 Container(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Back(),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width * 0.3,
//                       ),
//                       Save(),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
