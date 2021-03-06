import 'package:eraport/app/data/color.dart';
import 'package:eraport/app/data/widgets/card_shadow.dart';
import 'package:eraport/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DetailKomenView extends StatelessWidget {
  const DetailKomenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Scaffold(
      body: ListView.builder(
        itemCount: controller.nilaiSiswa.length,
        itemBuilder: (ctx, i) {
          {
            var data = controller.nilaiSiswa[i];
            return Padding(
              padding: i == 0 ? const EdgeInsets.only(top: 5) : EdgeInsets.zero,
              child: Obx(() => CardShadow(
                    horizontal: 20,
                    // width: 270,
                    color: controller.isDark.value
                        ? Colors.blueGrey[300]
                        : Colors.white,
                    // child: listSiswa(i, data),
                    child: ListTile(
                      onTap: () => Get.defaultDialog(
                        title: 'Komentar',
                        middleText: data.komentar,
                      ),
                      title: Text(
                        data.kelas
                            .split(' ')
                            .map((e) => e[0].toUpperCase() + e.substring(1))
                            .join(' '),
                      ),
                      subtitle: Text(
                        data.komentar,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(data.tahun.split(' ').join('-')),
                          const SizedBox(
                            height: 2.5,
                          ),
                          Text(data.semester),
                        ],
                      ),
                    ),
                  )),
            );
          }
        },
      ),
    );
  }
}
