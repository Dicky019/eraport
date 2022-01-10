import 'package:eraport/app/data/color.dart';
import 'package:eraport/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InputDecoration decorationTextFromField(String? label) => InputDecoration(
          labelText: label!,
          floatingLabelStyle: const TextStyle(color: Color(0xff2FA8B9)),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff808080),
              width: 2,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff808080),
              width: 2,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff2FA8B9),
              width: 2,
            ),
          ),
        );

    // Widget get(){}

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SvgPicture.asset(
              //   'assets/logo.svg',
              //   height: Get.height * 0.3,
              // ),
              Image.asset(
                'assets/logo.png',
                height: Get.height * 0.3,
              ),

              const Text(
                'E-Raport',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: Get.height * 0.045,
              ),
              SizedBox(
                width: Get.width * 0.88,
                child: TextFormField(
                  controller: controller.nis,
                  decoration: decorationTextFromField('Nomor induk Siswa'),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              SizedBox(
                // height:Get.height * 0.07,
                width: Get.width * 0.88,
                child: TextFormField(
                  controller: controller.nama,
                  decoration: decorationTextFromField('Kata Sandi'),
                ),
              ),
              SizedBox(
                height: Get.height * 0.07,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: ColorPallet().primariColor,
                    minimumSize: Size(
                      Get.width * 0.9,
                      Get.height * 0.07,
                    )),
                onPressed: () {
                  // Get.offAllNamed(Routes.HOME);
                  // Get.toNamed(Routes.HOME);
                  controller.login();
                },
                child: const Text(
                  'Masuk',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



