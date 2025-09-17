
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingLogic extends GetxController {

  var appVersion = '1.0.0'.obs;

  cleanFishData() async {
    Get.dialog(AlertDialog(
      title: const Text('Warm reminder'),
      content: const Text('Do you want to initialize data?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel',style: TextStyle(color: Colors.black),),
        ),
        TextButton(
          onPressed: () async {
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            final nowKey = DateFormat('yyyy-MM-dd').format(DateTime.now());
            await prefs.setInt(nowKey, 0);
            await prefs.setInt('bgImg', 0);
            await prefs.setInt('voice', 0);
            await prefs.setInt('style', 0);
            await prefs.setInt('intervalDuration', 1);
            await prefs.setInt('totalDuration', 60*30);
            Get.back();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ));
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    var info = await PackageInfo.fromPlatform();
    appVersion.value = info.version;
    super.onInit();
  }

}
