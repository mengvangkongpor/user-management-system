import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'form.dart';
import 'information.dart';
import 'province_provider.dart';

class ProvincePage extends StatefulWidget {
  const ProvincePage({super.key});

  @override
  State<ProvincePage> createState() => _ProvincePageState();
}

class _ProvincePageState extends State<ProvincePage> {
  @override
  void initState() {
    super.initState();

    Provider.of<ProvinceProvider>(context, listen: false).showProvince();
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
              "ແຂວງ",
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
              FormProvince(),
              InformationProvince(),
            ],
          ),
        ),
      ),
    );
  }
}
