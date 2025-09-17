import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knock_fish/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_widget/styled_widget.dart';

import 'fish_setting_logic.dart';

class FishSettingPage extends GetView<FishSettingLogic> {
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
            const Text(
              'Skin',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 80,
              child: GridView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemCount: 4,
                  itemBuilder: (_, index) {
                    return Obx(() {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: controller.bgImg.value == index
                                ? Colors.white
                                : const Color(0xff252529)),
                        child: <Widget>[
                          Image.asset(
                            'assets/small$index.png',
                            fit: BoxFit.cover,
                          )
                        ].toRow(mainAxisAlignment: MainAxisAlignment.center),
                      ).gestures(onTap: () async {
                        controller.bgImg.value = index;
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setInt('bgImg', index);
                      });
                    });
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Voice',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 80,
              child: GridView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemCount: 4,
                  itemBuilder: (_, index) {
                    return Obx(() {
                      return Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: controller.voice.value == index
                                ? Colors.white
                                : const Color(0xff252529)),
                        alignment: Alignment.center,
                        child: Text(
                          'Number ${index + 1}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: controller.voice.value == index
                                  ? Colors.black
                                  : Colors.white),
                        ),
                      ).gestures(onTap: () async {
                        controller.voice.value = index;
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setInt('voice', index);
                      });
                    });
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Mode',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 80,
              child: GridView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemCount: 2,
                  itemBuilder: (_, index) {
                    return Obx(() {
                      return Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: controller.style.value == index
                                ? Colors.white
                                : const Color(0xff252529)),
                        alignment: Alignment.center,
                        child: Text(
                          index == 0 ? 'Manual' : 'Auto',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: controller.style.value == index
                                  ? Colors.black
                                  : Colors.white),
                        ),
                      ).gestures(onTap: () async {
                        controller.style.value = index;
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setInt('style', index);
                      });
                    });
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Interval duration',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            <Widget>[
              Expanded(child: SliderTheme(
                  data: SliderThemeData(
                      thumbColor: primaryColor,
                      activeTrackColor: primaryColor,
                      inactiveTrackColor: const Color(0xff252529),
                      trackHeight: 3),
                  child: Obx(() {
                    return Slider(
                        value: controller.intervalDuration.value.toDouble(),
                        min: 1,
                        max: 30,
                        onChanged: (v) async {
                          controller.intervalDuration.value = v.toInt();
                          final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                          await prefs.setInt('intervalDuration', v.toInt());
                        });
                  }))),
              Obx(() {
                return Text(
                  '${controller.intervalDuration.value}s',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                );
              })
            ].toRow(),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Total duration',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            <Widget>[
              Expanded(child: SliderTheme(
                  data: SliderThemeData(
                      thumbColor: primaryColor,
                      activeTrackColor: primaryColor,
                      inactiveTrackColor: const Color(0xff252529),
                      trackHeight: 3),
                  child: Obx(() {
                    return Slider(
                        value: controller.totalDuration.value.toDouble(),
                        min: 60,
                        max: 60*60,
                        onChanged: (v) async {
                          controller.totalDuration.value = v.toInt();
                          final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                          await prefs.setInt('totalDuration', v.toInt());
                        });
                  }))),
              Obx(() {
                return Text(
                  '${controller.totalDuration.value~/60}minutes',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                );
              })
            ].toRow()
          ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
        ).marginAll(15)),
      ),
    );
  }
}
