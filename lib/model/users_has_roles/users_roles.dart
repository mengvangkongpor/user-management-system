import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:user_management_system/connectdb.dart';
import 'package:user_management_system/model/users_has_roles/user_role_provider.dart';
import 'package:user_management_system/model/users_has_roles/users_roles_contructor.dart';

class UserRolePage extends StatefulWidget {
  const UserRolePage({super.key});

  @override
  State<UserRolePage> createState() => _UserRolePageState();
}

class _UserRolePageState extends State<UserRolePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserRoleProvider>(context, listen: false).showUserRole();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "User_Role",
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      )),
      body: Column(
        children: [
          Container(
            child: Card(
                // color: Colors.red,
                margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
                child: ListTile(
                  title: Row(children: [
                    Text("User_id"),
                    SizedBox(
                      width: 200.0,
                    ),
                    Text("Role_id"),
                  ]),
                )),
          ),
          Consumer(
            builder: (context, UserRoleProvider provider, child) {
              return Flexible(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: provider.user_roleList.length,
                    itemBuilder: (context, index) {
                      UserRole data = provider.user_roleList[index];
                      return Card(
                          // color: Colors.red,
                          margin: EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 1.0),
                          child: ListTile(
                            title: Row(children: [
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                data.user_id_fk,
                                style: TextStyle(fontSize: 8.0),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                data.role_id_fk,
                                style: TextStyle(fontSize: 8.0),
                              ),
                            ]),
                            trailing: ElevatedButton(
                              child: Text("Hello"),
                              onPressed: () {
                                UserRole bbb = UserRole(
                                    user_id_fk: data.user_id_fk,
                                    role_id_fk: data.role_id_fk);
                                UserRoleProvider aaa =
                                    Provider.of<UserRoleProvider>(context,
                                        listen: false);
                                aaa.removeUserRole(bbb);
                              },
                            ),
                          ));
                    }),
              );
            },
          ),
        ],
      ),
    );
  }
}
