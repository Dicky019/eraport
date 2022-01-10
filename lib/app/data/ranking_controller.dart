import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RankingController extends GetxController {
  var no = 0;

  var noUmum = 0;
  final users = FirebaseFirestore.instance;
  final kurangKKM = 0;
  // final indexDataSiswa = RankingSiswa(
  //   '213321',
  //   'diki',
  //   '12313',
  //   [
  //     Ranking(
  //       "type",
  //       "name",
  //       0,
  //       0,
  //       0,
  //     )
  //   ],
  //   [
  //     Ranking(
  //       "type",
  //       "name",
  //       0,
  //       0,
  //       0,
  //     ),
  //   ],
  //   0,
  //   0,
  // ).obs;
  final onloading = false.obs;

  Future<List<RankingSiswa>> getDataSiswa(
      String tahunAjaran, String jurusan, String semester, String kelas) async {
    onloading.value = !onloading.value;

    List<RankingSiswa> dataSiswa = <RankingSiswa>[];

    try {
      await users
          .collection(tahunAjaran)
          .doc(jurusan)
          .collection(semester)
          .doc(kelas)
          .collection('Siswa')
          .orderBy('nama', descending: false)
          .get()
          .then((value) {
        dataSiswa = value.docs.map((e) {
          var dataListUmum = e.data()['nilai_umum'] as List;
          var dataListKhusus = e.data()['nilai_khusus'] as List;
          var listPelajaranDataUmum = <Ranking>[];
          var listPelajaranDataKhusus = <Ranking>[];
          var jumlahNilaiKhusus = 0.0;
          var jumlahNilaiUmum = 0.0;
          dataListKhusus.forEach((element) {
            var val = element as Map;

            val.forEach((key, value) {
              // var noKhusus = 0;
              // print(noKhusus++);
              listPelajaranDataKhusus.add(
                Ranking(
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
                Ranking(
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
            // print("keterampilan : ${element.keterampilan}");
            // print("pengetahuan : ${element.pengetahuan}");
            // print("jumlah Nilai Khusus : $jumlahNilaiKhusus");
            // print((element.keterampilan + element.pengetahuan) / 2);
          });

          listPelajaranDataUmum.forEach((element) {
            var nilaiPengetahuan = (element.pengetahuan / 100 * 30);
            var nilaiKeterampilan = (element.keterampilan / 100 * 70);
            jumlahNilaiUmum =
                jumlahNilaiUmum + (nilaiKeterampilan + nilaiPengetahuan);
            // print("keterampilan : ${element.keterampilan}");
            // print("pengetahuan : ${element.pengetahuan}");
            // print("jumlah Nilai Umum : $jumlahNilaiUmum");
            // print((element.keterampilan + element.pengetahuan) / 2);
          });

          // jumlahNilai = 0;
          var nilaiAkhir = (jumlahNilaiKhusus + jumlahNilaiUmum) /
              (listPelajaranDataKhusus.length + listPelajaranDataUmum.length);

          return RankingSiswa(
            e.id,
            e.data()['nama'],
            e.data()['nis'],
            listPelajaranDataKhusus,
            listPelajaranDataUmum,
            no++,
            nilaiAkhir,
          );
        }).toList();
      }).whenComplete(() => onloading.value = !onloading.value);
    } catch (e) {
      print(e);
    }
    return dataSiswa;
  }

  var jumlahNilai = 0.0;
  var jumlahNilaiRata = 0.0;
  var nilaiMax = 0.0;
  var nilaiMin = 0.0;

  // @override
  // void onInit() async {
  //   await getDataSiswa();
  //   dataSiswa.sort((a, b) {
  //     var nilai = a.nama!.compareTo(b.nama!);
  //     print("${a.nama} -- ${b.nama} $nilai");
  //     if (b.jumlahNilai.compareTo(a.jumlahNilai) == 0) {
  //       return a.nama!.compareTo(b.nama!);
  //     }
  //     return b.jumlahNilai.compareTo(a.jumlahNilai);
  //   });
  //   indexDataSiswa.value = dataSiswa.first;
  //   dataSiswa.forEach((e) {
  //     jumlahNilai = jumlahNilai + e.jumlahNilai;
  //     print(jumlahNilai);
  //   });
  //   jumlahNilaiRata = jumlahNilai / dataSiswa.length;
  //   nilaiMax = dataSiswa.first.jumlahNilai;
  //   nilaiMin = dataSiswa.last.jumlahNilai;

  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {}
}

class Ranking {
  final String type;
  final String name;
  final int kkn;
  final int pengetahuan;
  final int keterampilan;
  Ranking(this.type, this.name, this.kkn, this.pengetahuan, this.keterampilan);
}

class RankingSiswa {
  final String? id;
  final String? nama;
  final String? nis;
  final List<Ranking> pelajaranKhusus;
  final List<Ranking> pelajaranUmum;
  final double jumlahNilai;
  final int no;
  RankingSiswa(
    this.id,
    this.nama,
    this.nis,
    this.pelajaranKhusus,
    this.pelajaranUmum,
    this.no,
    this.jumlahNilai,
  );
}
