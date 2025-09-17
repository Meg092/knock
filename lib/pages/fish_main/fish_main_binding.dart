import 'package:get/get.dart';

import 'fish_main_logic.dart';

class FishMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FishMainLogic());
  }
}
