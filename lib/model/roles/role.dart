import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_management_system/model/roles/role_provider.dart';
import 'form.dart';
import 'information.dart';

class RolePage extends StatefulWidget {
  const RolePage({super.key});

  @override
  State<RolePage> createState() => _RolePageState();
}

class _RolePageState extends State<RolePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<RoleProvider>(context, listen: false).showRole();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "ສະຖານະ",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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
                ]),
          ),
          body: TabBarView(
            children: [
              FormRole(),
              InformationRole(),
            ],
          ),
        ),
      ),
    );
  }
}
