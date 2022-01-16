import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraport/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final users = FirebaseFirestore.instance;
  final nis = TextEditingController(text: "");
  final nama = TextEditingController(text: "");
  final _prefs = SharedPreferences.getInstance();

  Future login() async {
    var nisSiswa = "";
    if (nis.text.split('/').toList().length == 2) {
      nisSiswa = nis.text.split('/').join(' ').trim().toString();
    } else {
      nisSiswa = nis.text;
    }
    await users.collection("Siswa").doc(nisSiswa).get().then((value) async {
      if (value.data()!['nama'] == nama.text) {
        final SharedPreferences prefs = await _prefs;
        prefs.setString("nis", nisSiswa);
        nis.clear();
        nama.clear();
        Get.offAndToNamed(
          Routes.HOME,
          arguments: nisSiswa,
        );
      } else if (value.data()!['nama'] != nama.text) {
        // Get.offAndToNamed(Routes.HOME);
        dialog("SALAH", "Nama Anda Salah", []);
      } else {
        dialog("SALAH", "Nis Anda Salah", []);
      }
    });
  }

  void dialog(String title, String middleText, List<Widget> actions) {
    Get.defaultDialog(title: title, middleText: middleText, actions: actions);
  }

  @override
  void onInit() async {
    var get = await _prefs;
    var _nis = get.getString("nis") ?? '';
    print(_nis);
    if (_nis != '') {
      Get.offAllNamed(
        Routes.HOME,
        arguments: _nis,
      );
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }


  @override
  void onClose() {}
}
