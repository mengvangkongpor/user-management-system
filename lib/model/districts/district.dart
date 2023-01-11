import 'package:flutter/material.dart';
import 'package:user_management_system/model/districts/form.dart';
import 'package:user_management_system/model/districts/information.dart';

class DistrictPage extends StatefulWidget {
  const DistrictPage({super.key});

  @override
  State<DistrictPage> createState() => _DistrictPageState();
}

class _DistrictPageState extends State<DistrictPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "ເມືອງ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            bottom: TabBar(
              onTap: (_) {
                FocusManager.instance.primaryFocus!.unfocus();
              },
              labelStyle: TextStyle(fontSize: 16.0),
              tabs: [
                Tab(
                  text: 'ແບບຟອມບັນທຶກ',
                ),
                Tab(
                  text: 'ລາຍງານ',
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              FormDistrict(),
              InformationDistrict(),
            ],
          ),
        ));
  }
}
