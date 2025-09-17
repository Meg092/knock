import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'app_setting_logic.dart';

class AppSettingPage extends GetView<AppSettingLogic> {
  Widget _item(int index) {
    final titles = ['Initialize data', 'About app'];
    return Container(
      width: double.infinity,
      height: 40,
      color: Colors.transparent,
      child: <Widget>[
        Text(titles[index],style:const TextStyle(color: Colors.white),),
        index == 0
            ? const Icon(
                Icons.keyboard_arrow_right,
                size: 20,
                color: Colors.grey,
              )
            : Obx(() {
                return Text(
                  controller.appVersion.value,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                );
              })
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
    ).gestures(onTap: () {
      if (index == 0) {
        controller.cleanFishData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
        foregroundColor: Colors.white,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: <Widget>[_item(0),_item(1)].toColumn(
                  separator: Divider(
                height: 15,
                color: Colors.grey[300],
              )),
            ).decorated(
                color: const Color(0xff313236),
                borderRadius: BorderRadius.circular(10))
          ].toColumn(),
        ).marginAll(15)),
      ),
    );
  }
}
