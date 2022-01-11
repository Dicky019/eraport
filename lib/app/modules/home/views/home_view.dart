import 'package:eraport/app/data/color.dart';
import 'package:eraport/app/data/widgets/card_shadow.dart';
import 'package:eraport/app/modules/detail_person/views/detail_person_view.dart';
import 'package:eraport/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.nameAppbar[controller.selectedIndex.value],
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.to(const DetailPersonView());
          },
          icon: const Icon(
            LineIcons.userCircleAlt,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.offAllNamed(Routes.LOGIN);
            },
            icon: const Icon(
              LineIcons.alternateSignOut,
            ),
          )
        ],
        centerTitle: true,
      ),
      bottomNavigationBar: Obx(() => Container(
            decoration: BoxDecoration(
              color: controller.isDark.value
                  ? ColorPallet().primariColor
                  : Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: Obx(() => GNav(
                      rippleColor: Colors.grey[100]!,
                      hoverColor: Colors.grey[100]!,
                      gap: 8,
                      activeColor: ColorPallet().yelowColor,
                      iconSize: 24,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      duration: const Duration(milliseconds: 400),
                      tabBackgroundColor: Colors.grey[100]!,
                      color: controller.isDark.value
                          ? Colors.white
                          : ColorPallet().primariColor,
                      tabs: controller.listTab,
                      selectedIndex: controller.selectedIndex.value,
                      onTabChange: (index) {
                        controller.selectedIndex.value = index;
                      },
                    )),
              ),
            ),
          )),
      body: Obx(
        () => controller.onloading.value == false
            ? controller.listWidget.elementAt(controller.selectedIndex.value)
            : const OnLoading(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (Get.isDarkMode) {
            controller.isDark.value = false;
            Get.changeThemeMode(ThemeMode.light);
          } else {
            controller.isDark.value = true;
            Get.changeThemeMode(ThemeMode.dark);
          }
        },
        child: Obx(
          () => Icon(
            controller.isDark.value ? LineIcons.cloudWithMoon : LineIcons.sun,
          ),
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key? key,
    // required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 30,
          ),
          HeadingWidget(
            controller: controller,
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: LihatSemuaWidget(
              onPressed: () {
                controller.selectedIndex.value = 1;
              },
              label: 'Statik Nilai',
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                controller.nilaiSiswa.length,
                (i) {
                  var data = controller.nilaiSiswa[i];
                  return Padding(
                    padding: i == 0
                        ? const EdgeInsets.only(left: 15)
                        : EdgeInsets.zero,
                    child: Obx(() => CardShadow(
                          vertical: 10,
                          width: 330,
                          color: controller.isDark.value
                              ? Colors.blueGrey[300]
                              : Colors.white,
                          child: listSiswa(i, data),
                        )),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: LihatSemuaWidget(
              onPressed: () {
                // Get.toNamed(
                //   Routes.DETAIL_NILAI,
                //   arguments: controller.nilaiSiswa,
                // );
                controller.selectedIndex.value = 2;
              },
              label: 'Komentar Wali Kelas',
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                controller.nilaiSiswa.length,
                (i) {
                  var data = controller.nilaiSiswa[i];
                  return Padding(
                    padding: i == 0
                        ? const EdgeInsets.only(left: 15)
                        : EdgeInsets.zero,
                    child: Obx(() => CardShadow(
                          vertical: 10,
                          width: 280,
                          color: controller.isDark.value
                              ? Colors.blueGrey[300]
                              : Colors.white,
                          // child: listSiswa(i, data),
                          child: ListTile(
                            onTap: () => Get.defaultDialog(
                              title: 'Komentar',
                              middleText: data.komentar,
                            ),
                            // leading: CircleAvatar(
                            //   backgroundColor: ColorPallet().yelowColor,
                            //   child: Text("${i + 1}"),
                            //   foregroundColor: Colors.white,
                            // ),
                            title: Text(
                              data.kelas
                                  .split(' ')
                                  .map((e) =>
                                      e[0].toUpperCase() + e.substring(1))
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
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: LihatSemuaWidget(
              onPressed: () {
                // Get.toNamed(
                //   Routes.DETAIL_NILAI,
                //   arguments: controller.nilaiSiswa,
                // );
                controller.selectedIndex.value = 2;
              },
              label: 'Peringkat Kelas',
              button: false,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            // scrollDirection: Axis.horizontal,
            child: Column(
              children: List.generate(
                controller.nilaiSiswa.length,
                (i) {
                  var data = controller.nilaiSiswa[i];
                  return Padding(
                    padding: i == 0
                        ? const EdgeInsets.only(top: 5)
                        : EdgeInsets.zero,
                    child: Obx(
                      () => CardShadow(
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
                          // leading: CircleAvatar(
                          //   backgroundColor: ColorPallet().yelowColor,
                          //   child: Text("${i + 1}"),
                          //   foregroundColor: Colors.white,
                          // ),
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
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(data.tahun.split(' ').join('-')),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(data.semester),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget listSiswa(int i, NilaiSemester data) {
  var kurangKKM = 0;

  final controller = Get.find<HomeController>();

  data.nilaiKhusus.forEach((e) {
    var nilaiPengetahuan = (e.pengetahuan / 100 * 30);
    var nilaiKeterampilan = (e.keterampilan / 100 * 70);
    if ((nilaiKeterampilan + nilaiPengetahuan) < e.kkn) {
      // print(e.kkn);
      // print(nilaiKeterampilan + nilaiPengetahuan);
      kurangKKM++;
    }
  });
  data.nilaiUmum.forEach((e) {
    var nilaiPengetahuan = (e.pengetahuan / 100 * 30);
    var nilaiKeterampilan = (e.keterampilan / 100 * 70);
    if ((nilaiKeterampilan + nilaiPengetahuan) < e.kkn) {
      // print(e.kkn);
      // print(nilaiKeterampilan + nilaiPengetahuan);
      kurangKKM++;
    }
  });
  var panjangSemuaNilai = data.nilaiKhusus.length + data.nilaiUmum.length;

  // var persenNilai = (data.jumlahNilai / (panjangSemuaNilai * 100)) * 100;

  print(data.jumlahNilai * 0.01);

  final onTap = false.obs;

  return Container(
    // height: 60,
    // width: 6,
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
        ListTile(
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
        ),
        Obx(
          () => onTap.value == false
              ? Column(
                  children: [
                    LinearPercentIndicator(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      lineHeight: 5.0,
                      percent: data.jumlahNilai * 0.01,
                      progressColor: ColorPallet().secondColor,
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

class LihatSemuaWidget extends StatelessWidget {
  final Function() onPressed;
  final String label;
  final bool button;
  const LihatSemuaWidget({
    Key? key,
    required this.onPressed,
    required this.label,
    this.button = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        const Spacer(),
        button
            ? TextButton(
                onPressed: onPressed,
                style: TextButton.styleFrom(
                  shadowColor: ColorPallet().primariColor,
                ),
                child: const Text(
                  'Lihat Semua',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}

class HeadingWidget extends StatelessWidget {
  const HeadingWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.selamatDatang,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color(
                      0xff808080,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  controller.infoSiswa.nama,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 2,
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
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OnLoading extends StatelessWidget {
  const OnLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CupertinoActivityIndicator(),
    );
  }
}
