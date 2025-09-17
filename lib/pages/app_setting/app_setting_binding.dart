import 'package:get/get.dart';

import 'app_setting_logic.dart';

class AppSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppSettingLogic());
  }
}
