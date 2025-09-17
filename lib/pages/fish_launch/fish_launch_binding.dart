import 'package:get/get.dart';

import 'fish_launch_logic.dart';

class FishLaunchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      FishLaunchLogic(),
      permanent: true,
    );
  }
}
