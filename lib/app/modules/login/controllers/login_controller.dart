import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraport/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final count = 0.obs;
  final users = FirebaseFirestore.instance;
  final nis = TextEditingController(text: "21.003.001");
  final nama = TextEditingController(text: "ADRIAN MARWANTO LOLO");

  Future login() async {
    await users.collection("Siswa").doc(nis.text).get().then((value) {
      if (value.data()!['nama'] == nama.text) {
        Get.offAndToNamed(
          Routes.HOME,
          arguments: nis.text,
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
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
