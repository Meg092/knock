import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'fish_launch_logic.dart';

class FishLaunchView extends GetView<FishLaunchLogic> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => controller.pouros.value
              ? const CircularProgressIndicator(color: Colors.white)
              : buildError(),
        ),
      ),
    );
  }

  Widget buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              controller.hjpn();
            },
            icon: const Icon(
              Icons.restart_alt,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
