import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraport/app/data/ranking_controller.dart';
import 'package:eraport/app/modules/detail_komen/views/detail_komen_view.dart';
import 'package:eraport/app/modules/detail_nilai/views/detail_nilai_view.dart';
import 'package:eraport/app/modules/detail_peringkat/views/detail_peringkat_view.dart';
import 'package:eraport/app/modules/detail_person/views/detail_person_view.dart';
import 'package:eraport/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final selectedIndex = 0.obs;

  final onloading = false.obs;
  final users = FirebaseFirestore.instance;
  late String nis = '';
  final rank = RankingController();
  var jam = 19;
  var selamatDatang = "";
  late InfoSiswa infoSiswa =
      InfoSiswa("nis", "namaOrangTua", "noOrtu", "imageSiswa");

  var isDark = false.obs;

  List<String> nameAppbar = [
    'Home',
    'Nilai',
    'Komen',
    'Peringkat',
  ];

  List<GButton> listTab = [
    GButton(
      icon: LineIcons.home,
      text: 'Home',
    ),
    GButton(
      icon: LineIcons.fileAlt,
      text: 'Nilai',
    ),
    GButton(
      icon: LineIcons.edit,
      text: 'Komen',
    ),
    GButton(
      icon: LineIcons.addressCard,
      text: 'Peringkat',
    ),
  ];

  late List<NilaiSemester> nilaiSiswa = [
    NilaiSemester(
      0,
      nilaiUmum: [],
      nilaiKhusus: [],
      semester: '',
      jurusan: '',
      kelas: '',
      tahun: '',
      komentar: '',
      peringkat: Peringkat(0, 0),
    )
  ];

  late List<Widget> listWidget = [];

  Future getInfoSiswa() async {
    onloading.value = !onloading.value;
    await users
        .collection("Siswa")
        .doc(nis)
        .get()
        .then(
          (value) => infoSiswa = InfoSiswa(
            value.data()!['nama'].toString(),
            value.data()!['namaOrtu'].toString(),
            value.data()!['noOrtu'].toString(),
            value.data()!['imageSiswa'].toString(),
          ),
        )
        .whenComplete(
          () => onloading.value = !onloading.value,
        );
    print(infoSiswa.imageSiswa);
  }

  Future getDataNilaiSiswa() async {
    onloading.value = !onloading.value;
    await users
        .collection("Siswa")
        .doc(nis)
        .collection("nilai")
        .get()
        .then((value) {
      var list = <NilaiSemester>[];
      value.docs.forEach((e) {
        var dataListUmum = e.data()['nilai_umum'] as List;
        var dataListKhusus = e.data()['nilai_khusus'] as List;
        var listPelajaranDataUmum = <DetailNilai>[];
        var listPelajaranDataKhusus = <DetailNilai>[];
        var jumlahNilaiKhusus = 0.0;
        var jumlahNilaiUmum = 0.0;

        dataListKhusus.forEach((element) {
          var val = element as Map;

          val.forEach((key, value) {
            // var noKhusus = 0;
            // print(noKhusus++);
            listPelajaranDataKhusus.add(
              DetailNilai(
                key,
                value['nama'],
                value['kkn'],
                int.tryParse(value['Pengetahuan'].toString()) ?? 0,
                int.tryParse(value['Keterampilan'].toString()) ?? 0,
              ),
            );
          });
        });

        dataListUmum.forEach((element) {
          var val = element as Map;

          val.forEach((key, value) {
            listPelajaranDataUmum.add(
              DetailNilai(
                key,
                value['nama'],
                value['kkn'],
                int.tryParse(value['Pengetahuan'].toString()) ?? 0,
                int.tryParse(value['Keterampilan'].toString()) ?? 0,
              ),
            );
          });
        });

        listPelajaranDataKhusus.forEach((element) {
          var nilaiPengetahuan = (element.pengetahuan / 100 * 30);
          var nilaiKeterampilan = (element.keterampilan / 100 * 70);
          jumlahNilaiKhusus =
              jumlahNilaiKhusus + (nilaiKeterampilan + nilaiPengetahuan);
        });

        listPelajaranDataUmum.forEach((element) {
          var nilaiPengetahuan = (element.pengetahuan / 100 * 30);
          var nilaiKeterampilan = (element.keterampilan / 100 * 70);
          jumlahNilaiUmum =
              jumlahNilaiUmum + (nilaiKeterampilan + nilaiPengetahuan);
        });

        // jumlahNilai = 0;
        var nilaiAkhir = (jumlahNilaiKhusus + jumlahNilaiUmum) /
            (listPelajaranDataKhusus.length + listPelajaranDataUmum.length);

        list.add(
          NilaiSemester(
            nilaiAkhir,
            peringkat: Peringkat(0, 0),
            nilaiUmum: listPelajaranDataUmum,
            nilaiKhusus: listPelajaranDataKhusus,
            semester: e.id.split('-').toList()[2].toString(),
            jurusan: e.id.split('-').toList()[1].toString(),
            kelas: e.id.split('-').toList()[3].toString(),
            tahun: e.id.split('-').toList()[0].toString(),
            komentar: e.data()['catatanAkademik'] ?? "",
          ),
        );
      });
      nilaiSiswa = list;
    }).whenComplete(() => onloading.value = !onloading.value);
  }

  late List<List<RankingSiswa>> listRanking = [];

  @override
  void onInit() async {
    nis = Get.arguments;
    if (jam < 12 && jam > 5) {
      selamatDatang = "Selamat Pagi";
    } else if (jam >= 12 && jam < 15) {
      selamatDatang = "Selamat Siang";
    } else if (jam >= 15 && jam < 19) {
      selamatDatang = "Selamat Sore";
    } else if (jam >= 19) {
      selamatDatang = "Selamat Malam";
    }
    await getInfoSiswa();
    await getDataNilaiSiswa();
    // print();
    //
    onloading.value = !onloading.value;
    for (var i = 0; i < nilaiSiswa.length; i++) {
      var nilai = nilaiSiswa[i];

      var data = await rank.getDataSiswa(
        nilai.tahun.split(' ').join('-').toString(),
        nilai.jurusan,
        nilai.semester,
        nilai.kelas,
      );
      listRanking.add(data);
    }

    for (var i = 0; i < nilaiSiswa.length; i++) {
      var item = listRanking[i];
      var info = nilaiSiswa[i];
      item.sort((a, b) {
        var nilai = a.nama!.compareTo(b.nama!);
        print("${a.nama} -- ${b.nama} $nilai");
        if (b.jumlahNilai.compareTo(a.jumlahNilai) == 0) {
          return a.nama!.compareTo(b.nama!);
        }
        return b.jumlahNilai.compareTo(a.jumlahNilai);
      });
      for (var i = 0; i < item.length; i++) {
        if (item[i].nama == infoSiswa.nama && item[i].nis == nis) {
          print("assssssss${i + 1} ${item.length}");
          info.peringkat = Peringkat(i + 1, item.length);
        }
      }
    }

    listWidget = [
      const Home(),
      const DetailNilaiView(),
      const DetailKomenView(),
      const DetailPeringkatView(),
      const DetailPersonView(),
    ];
    onloading.value = !onloading.value;
    // var listRank = listRanking;

    // for (var ranking in listRank) {}

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

class Peringkat {
  final int juara;
  final int jumlahOrang;

  Peringkat(this.juara, this.jumlahOrang);
}

class InfoSiswa {
  final String nama;
  final String namaOrangTua;
  final String noOrtu;
  final String imageSiswa;
  InfoSiswa(this.nama, this.namaOrangTua, this.noOrtu, this.imageSiswa);
}

class NilaiSemester {
  final String semester;
  final String tahun;
  final String kelas;
  final String jurusan;
  final String komentar;
  final double jumlahNilai;
  late Peringkat peringkat;
  final List<DetailNilai> nilaiUmum;
  final List<DetailNilai> nilaiKhusus;
  NilaiSemester(
    this.jumlahNilai, {
    required this.nilaiUmum,
    required this.nilaiKhusus,
    required this.tahun,
    required this.jurusan,
    required this.semester,
    required this.kelas,
    required this.komentar,
    required this.peringkat,
  });
}

class DetailNilai {
  final String type;
  final String name;
  final int kkn;
  final int pengetahuan;
  final int keterampilan;
  DetailNilai(
      this.type, this.name, this.kkn, this.pengetahuan, this.keterampilan);
}
