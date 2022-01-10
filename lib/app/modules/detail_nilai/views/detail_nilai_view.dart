import 'package:eraport/app/data/color.dart';
import 'package:eraport/app/data/widgets/card_shadow.dart';
import 'package:eraport/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DetailNilaiView extends StatelessWidget {
  const DetailNilaiView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Scaffold(
      body: ListView.builder(
        // controller: sC,
        itemCount: controller.nilaiSiswa.length,
        itemBuilder: (ctx, i) {
          var data = controller.nilaiSiswa[i];
          return Padding(
            padding: i == 0 ? const EdgeInsets.only(top: 5) : EdgeInsets.zero,
            child: Obx(
              () => CardShadow(
                horizontal: 20,
                color: controller.isDark.value
                    ? Colors.blueGrey[300]
                    : Colors.white,
                child: listSiswa(i, data),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget listSiswa(int i, NilaiSemester data) {
  final controller = Get.find<HomeController>();
  var kurangKKM = 0;

  for (var e in data.nilaiKhusus) {
    var nilaiPengetahuan = (e.pengetahuan / 100 * 30);
    var nilaiKeterampilan = (e.keterampilan / 100 * 70);
    if ((nilaiKeterampilan + nilaiPengetahuan) < e.kkn) {
      // print(e.kkn);
      // print(nilaiKeterampilan + nilaiPengetahuan);
      kurangKKM++;
    }
  }
  for (var e in data.nilaiUmum) {
    var nilaiPengetahuan = (e.pengetahuan / 100 * 30);
    var nilaiKeterampilan = (e.keterampilan / 100 * 70);
    if ((nilaiKeterampilan + nilaiPengetahuan) < e.kkn) {
      // print(e.kkn);
      // print(nilaiKeterampilan + nilaiPengetahuan);
      kurangKKM++;
    }
  }
  var panjangSemuaNilai = data.nilaiKhusus.length + data.nilaiUmum.length;

  // var persenNilai = (data.jumlahNilai / (panjangSemuaNilai * 100)) * 100;

  // print(persenNilai);

  final onTap = false.obs;

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: kurangKKM == 0
          ? controller.isDark.value
              ? Colors.blueGrey[300]
              : Colors.white
          : Colors.red[100],
    ),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: ExpansionTile(
            // textColor: Get.isDarkMode ? Colors.blueGrey[300] : Colors.white,
            onExpansionChanged: (v) => onTap.value = v,
            leading: CircleAvatar(
              backgroundColor: ColorPallet().yelowColor,
              child: Text("${i + 1}"),
              foregroundColor: Colors.white,
            ),
            title: Text(data.tahun.split(' ').join('-')),
            subtitle: Text(
              data.kelas
                  .split(' ')
                  .map((e) => e[0].toUpperCase() + e.substring(1))
                  .join(' '),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nilai Rata-Rata : ${data.jumlahNilai.toStringAsFixed(1)}",
                ),
                Text(
                  "Nilai Yang di Isi : $panjangSemuaNilai",
                ),
              ],
            ),
            // expandedAlignment: Alignment.topLeft,
            childrenPadding: const EdgeInsets.all(15),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LineWidget(kurangKKM: kurangKKM),
              const Text(
                "Muatan Nasional",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              LineWidget(
                kurangKKM: kurangKKM,
              ),
              ...dataNilai(
                data.nilaiUmum,
                controller.isDark.value ? Colors.blue[900]! : Colors.blue[100]!,
              ),
              LineWidget(
                kurangKKM: kurangKKM,
              ),
              const Text(
                "Muatan Peminatan Kejuruan",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              LineWidget(
                kurangKKM: kurangKKM,
              ),
              ...dataNilai(
                  data.nilaiKhusus,
                  controller.isDark.value
                      ? Colors.yellow[900]!
                      : Colors.yellow[100]!),
              LineWidget(
                kurangKKM: kurangKKM,
              ),
            ],
          ),
        ),
        // SizedBox(
        //   height: 15,
        // ),
        Obx(
          () => onTap.value == false
              ? Column(
                  children: [
                    LinearPercentIndicator(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      lineHeight: 5.0,
                      percent: data.jumlahNilai * 0.01,
                      progressColor: Colors.blue,
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                  ],
                )
              : SizedBox(),
        ),
      ],
    ),
  );
}

List<Widget> dataNilai(List<DetailNilai> pelajaran, Color color) {
  return List.generate(pelajaran.length, (index) {
    var value = pelajaran[index];
    return Container(
      color: color,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${value.type} : ${value.name}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "KKM : ${value.kkn.toString()}",
          ),
          Text(
            "Keterampilan : ${value.keterampilan.toString()}",
          ),
          Text(
            "Pengetahuan : ${value.pengetahuan.toString()}",
          ),
          Text(
            "Nilai Akhir : ${(value.pengetahuan / 100 * 30) + (value.keterampilan / 100 * 70)}",
          ),
        ],
      ),
    );
  });
}

class LineWidget extends StatelessWidget {
  const LineWidget({
    Key? key,
    required this.kurangKKM,
  }) : super(key: key);

  final int kurangKKM;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: kurangKKM == 0 ? Colors.black : Colors.white,
      thickness: 2,
    );
  }
}
