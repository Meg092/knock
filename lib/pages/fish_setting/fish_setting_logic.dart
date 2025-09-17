import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FishSettingLogic extends GetxController {

  var bgImg = 0.obs;
  var bgVoice = 0.obs;
  var voice = 0.obs;
  var style = 1.obs;
  var intervalDuration = 1.obs;
  var totalDuration = (60*30).obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bgImg.value = prefs.getInt('bgImg') ?? 0;
    voice.value = prefs.getInt('voice') ?? 0;
    style.value = prefs.getInt('style') ?? 1;
    intervalDuration.value = prefs.getInt('intervalDuration') ?? 1;
    totalDuration.value = prefs.getInt('totalDuration') ?? 60 * 30;
    super.onInit();
  }

}
