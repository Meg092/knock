import 'package:get/get.dart';

import 'fish_setting_logic.dart';

class FishSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FishSettingLogic());
  }
}
