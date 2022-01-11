
import 'package:eraport/app/data/widgets/card_shadow.dart';
import 'package:eraport/app/modules/home/controllers/home_controller.dart';
import 'package:eraport/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class DetailPersonView extends StatelessWidget {
  const DetailPersonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
          // backgroundColor: ColorPallet().primariColor,
          actions: [
            IconButton(
                onPressed: () {
                  Get.offAllNamed(Routes.LOGIN);
                },
                icon: const Icon(LineIcons.alternateSignOut))
          ],
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Material(
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () => Get.dialog(
                    Image.network(
                      controller.infoSiswa.imageSiswa,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      controller.infoSiswa.imageSiswa,
                      height: 160,
                      width: 160,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Detail(
                subTitel: controller.infoSiswa.nama,
                titel: 'Nama',
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Detail(
                subTitel: controller.nis,
                titel: 'Nis',
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Detail(
                subTitel: controller.infoSiswa.namaOrangTua,
                titel: 'Nama Orang Tua',
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Detail(
                subTitel: controller.infoSiswa.noOrtu,
                titel: 'No Orang Tua',
              ),
            ),
          ],
        ));
  }
}

class Detail extends StatelessWidget {
  const Detail({
    Key? key,
    required this.titel,
    required this.subTitel,
  }) : super(key: key);

  final String titel;
  final String subTitel;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: CardShadow(
            color:
                controller.isDark.value ? Colors.blueGrey[300] : Colors.white,
            child: SizedBox(
                height: 40,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      titel,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                )),
          ),
        ),
        Expanded(
          flex: 6,
          child: CardShadow(
            color:
                controller.isDark.value ? Colors.blueGrey[300] : Colors.white,
            child: SizedBox(
              height: 40,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    ": $subTitel",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
