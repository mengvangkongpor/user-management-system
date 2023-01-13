import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:user_management_system/model/provinces/province_constructor.dart';
import 'package:user_management_system/model/users_has_roles/user_role_provider.dart';

class notificationFromUser extends StatefulWidget {
  const notificationFromUser({super.key});

  @override
  State<notificationFromUser> createState() => _notificationFromUserState();
}

class _notificationFromUserState extends State<notificationFromUser> {
  final formKey = GlobalKey<FormState>();
  Province provinceConstructor = Province(province_id_pk: "", province: "");
  @override
  void initState() {
    super.initState();
    Provider.of<UserRoleProvider>(context, listen: false).showUserRole();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
