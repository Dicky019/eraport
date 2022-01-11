import 'package:eraport/app/data/color.dart';
import 'package:eraport/app/data/widgets/card_shadow.dart';
import 'package:eraport/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DetailPeringkatView extends StatelessWidget {
  const DetailPeringkatView({Key? key}) : super(key: key);

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
                    // width: 200,
                    color: controller.isDark.value
                        ? Colors.blueGrey[300]
                        : Colors.white,
                    // child: listSiswa(i, data),
                    child: ListTile(
                      onTap: () => Get.defaultDialog(
                        title: 'Peringkat',
                        middleText:
                            "Peringkat ${data.peringkat.juara} dari ${data.peringkat.jumlahOrang} siswa",
                      ),
                      leading: CircleAvatar(
                        backgroundColor: ColorPallet().yelowColor,
                        child: Text("${i + 1}"),
                        foregroundColor: Colors.white,
                      ),
                      title: Text(
                        data.kelas
                            .split(' ')
                            .map((e) => e[0].toUpperCase() + e.substring(1))
                            .join(' '),
                      ),
                      subtitle: Text(
                        "Peringkat ${data.peringkat.juara} dari ${data.peringkat.jumlahOrang} siswa",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Text(data.tahun),
                    ),
                  )),
            );
          }
        },
      ),
    );
  }
}
