
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:knock_fish/pages/app_setting/app_setting_binding.dart';
import 'package:knock_fish/pages/app_setting/app_setting_view.dart';
import 'package:knock_fish/pages/fish_launch/fish_launch_binding.dart';
import 'package:knock_fish/pages/fish_launch/fish_launch_view.dart';
import 'package:knock_fish/pages/fish_main/fish_main_binding.dart';
import 'package:knock_fish/pages/fish_main/fish_main_view.dart';
import 'package:knock_fish/pages/fish_setting/fish_setting_binding.dart';
import 'package:knock_fish/pages/fish_setting/fish_setting_true.dart';
import 'package:knock_fish/pages/fish_setting/fish_setting_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color primaryColor = const Color(0xffff6c00);
Color bgColor = const Color(0xff16171e);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bgImg = prefs.getInt('bgImg');
  if (bgImg == null) {
    await prefs.setInt('bgImg', 0);
    await prefs.setInt('voice', 0);
    await prefs.setInt('style', 0);
    await prefs.setInt('intervalDuration', 1);
    await prefs.setInt('totalDuration', 60*30);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Fish,
      initialRoute: '/FishLaunch',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

List<GetPage<dynamic>> Fish =[
  GetPage(name: '/FishLaunch', page: () => FishLaunchView(), binding: FishLaunchBinding()),
  GetPage(name: '/FishMainPage', page: () => const FishMainPage(), binding: FishMainBinding()),
  GetPage(name: '/FishSettingPage', page: () => FishSettingPage(), binding: FishSettingBinding()),
  GetPage(name: '/FishTrue', page: () => FishSettingTrue()),
  GetPage(name: '/AppSettingPage', page: () => AppSettingPage(), binding: AppSettingBinding()),
];
