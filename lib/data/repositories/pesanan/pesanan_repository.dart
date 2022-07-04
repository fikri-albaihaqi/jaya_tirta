import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:jaya_tirta/data/models/models.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

class PesananRepository {
  final FirebaseFirestore _firebaseFirestore;

  PesananRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<List<Pesanan>> getAllPesanan() {
    return _firebaseFirestore
        .collection('pesanan')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Pesanan.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Pesanan>> getRiwayatPesanan() {
    return _firebaseFirestore
        .collection('pesanan')
        .where('status', isEqualTo: 'Pesanan Selesai')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((docs) => Pesanan.fromSnapshot(docs)).toList();
    });
  }

  Future<void> saveDataPenjualan(List<Pesanan> dataPenjualan) async {
    var excel = Excel.createExcel(); //create an excel sheet
    Sheet sheetJanuari = excel['Januari'];
    Sheet sheetFebruari = excel['Februari'];
    Sheet sheetMaret = excel['Maret'];
    Sheet sheetApril = excel['April'];
    Sheet sheetMei = excel['Mei'];
    Sheet sheetJuni = excel['Juni'];
    Sheet sheetJuli = excel['Juli'];
    Sheet sheetAgustus = excel['Agustus'];
    Sheet sheetSeptember = excel['September'];
    Sheet sheetOktober = excel['Oktober'];
    Sheet sheetNovember = excel['November'];
    Sheet sheetDesember = excel['Desember'];
    int a = 1,
        b = 1,
        c = 1,
        d = 1,
        e = 1,
        f = 1,
        g = 1,
        h = 1,
        j = 1,
        k = 1,
        l = 1,
        m = 1;

    for (int i = 0; i < dataPenjualan.length; i++) {
      if (dataPenjualan.elementAt(i).dateSort!.substring(5, 7) == '01') {
        a++;
        var cellJudulNomor = sheetJanuari.cell(CellIndex.indexByString("A1"));
        cellJudulNomor.value = 'No';
        var cellJudulNama = sheetJanuari.cell(CellIndex.indexByString("B1"));
        cellJudulNama.value = 'Nama';
        var cellJudulAlamat = sheetJanuari.cell(CellIndex.indexByString("C1"));
        cellJudulAlamat.value = 'Alamat';
        var cellJudulPinjaman =
            sheetJanuari.cell(CellIndex.indexByString("D1"));
        cellJudulPinjaman.value = 'Jumlah Pinjaman';
        var cellJudulTanggal = sheetJanuari.cell(CellIndex.indexByString("E1"));
        cellJudulTanggal.value = 'Tanggal Pemesanan';

        var cellNomor = sheetJanuari.cell(CellIndex.indexByString("A${a}"));
        cellNomor.value = a;

        var cellNama = sheetJanuari.cell(CellIndex.indexByString("B${a}"));
        cellNama.value = dataPenjualan.elementAt(i).namaKonsumen;

        var cellAlamat = sheetJanuari.cell(CellIndex.indexByString("C${a}"));
        cellAlamat.value = dataPenjualan.elementAt(i).alamat;

        var cellPinjaman = sheetJanuari.cell(CellIndex.indexByString("D${a}"));
        cellPinjaman.value = dataPenjualan.elementAt(i).jumlahPinjaman;

        var cellTanggalPembelian =
            sheetJanuari.cell(CellIndex.indexByString("E${a}"));
        cellTanggalPembelian.value = dataPenjualan.elementAt(i).dateSort;
      } else if (dataPenjualan.elementAt(i).dateSort!.substring(5, 7) == '02') {
        b++;
        var cellJudulNomor = sheetFebruari.cell(CellIndex.indexByString("A1"));
        cellJudulNomor.value = 'No';
        var cellJudulNama = sheetFebruari.cell(CellIndex.indexByString("B1"));
        cellJudulNama.value = 'Nama';
        var cellJudulAlamat = sheetFebruari.cell(CellIndex.indexByString("C1"));
        cellJudulAlamat.value = 'Alamat';
        var cellJudulPinjaman =
            sheetFebruari.cell(CellIndex.indexByString("D1"));
        cellJudulPinjaman.value = 'Jumlah Pinjaman';
        var cellJudulTanggal =
            sheetFebruari.cell(CellIndex.indexByString("E1"));
        cellJudulTanggal.value = 'Tanggal Pemesanan';

        var cellNomor = sheetFebruari.cell(CellIndex.indexByString("A${b}"));
        cellNomor.value = b;

        var cellNama = sheetFebruari.cell(CellIndex.indexByString("B${b}"));
        cellNama.value = dataPenjualan.elementAt(i).namaKonsumen;

        var cellAlamat = sheetFebruari.cell(CellIndex.indexByString("C${b}"));
        cellAlamat.value = dataPenjualan.elementAt(i).alamat;

        var cellPinjaman = sheetFebruari.cell(CellIndex.indexByString("D${b}"));
        cellPinjaman.value = dataPenjualan.elementAt(i).jumlahPinjaman;

        var cellTanggalPembelian =
            sheetFebruari.cell(CellIndex.indexByString("E${b}"));
        cellTanggalPembelian.value = dataPenjualan.elementAt(i).dateSort;
      } else if (dataPenjualan.elementAt(i).dateSort!.substring(5, 7) == '03') {
        c++;
        var cellJudulNomor = sheetMaret.cell(CellIndex.indexByString("A1"));
        cellJudulNomor.value = 'No';
        var cellJudulNama = sheetMaret.cell(CellIndex.indexByString("B1"));
        cellJudulNama.value = 'Nama';
        var cellJudulAlamat = sheetMaret.cell(CellIndex.indexByString("C1"));
        cellJudulAlamat.value = 'Alamat';
        var cellJudulPinjaman = sheetMaret.cell(CellIndex.indexByString("D1"));
        cellJudulPinjaman.value = 'Jumlah Pinjaman';
        var cellJudulTanggal = sheetMaret.cell(CellIndex.indexByString("E1"));
        cellJudulTanggal.value = 'Tanggal Pemesanan';

        var cellNomor = sheetMaret.cell(CellIndex.indexByString("A${c}"));
        cellNomor.value = c;

        var cellNama = sheetMaret.cell(CellIndex.indexByString("B${c}"));
        cellNama.value = dataPenjualan.elementAt(i).namaKonsumen;

        var cellAlamat = sheetMaret.cell(CellIndex.indexByString("C${c}"));
        cellAlamat.value = dataPenjualan.elementAt(i).alamat;

        var cellPinjaman = sheetMaret.cell(CellIndex.indexByString("D${c}"));
        cellPinjaman.value = dataPenjualan.elementAt(i).jumlahPinjaman;

        var cellTanggalPembelian =
            sheetMaret.cell(CellIndex.indexByString("E${c}"));
        cellTanggalPembelian.value = dataPenjualan.elementAt(i).dateSort;
      } else if (dataPenjualan.elementAt(i).dateSort!.substring(5, 7) == '04') {
        d++;
        var cellJudulNomor = sheetApril.cell(CellIndex.indexByString("A1"));
        cellJudulNomor.value = 'No';
        var cellJudulNama = sheetApril.cell(CellIndex.indexByString("B1"));
        cellJudulNama.value = 'Nama';
        var cellJudulAlamat = sheetApril.cell(CellIndex.indexByString("C1"));
        cellJudulAlamat.value = 'Alamat';
        var cellJudulPinjaman = sheetApril.cell(CellIndex.indexByString("D1"));
        cellJudulPinjaman.value = 'Jumlah Pinjaman';
        var cellJudulTanggal = sheetApril.cell(CellIndex.indexByString("E1"));
        cellJudulTanggal.value = 'Tanggal Pemesanan';

        var cellNomor = sheetApril.cell(CellIndex.indexByString("A${d}"));
        cellNomor.value = d;

        var cellNama = sheetApril.cell(CellIndex.indexByString("B${d}"));
        cellNama.value = dataPenjualan.elementAt(i).namaKonsumen;

        var cellAlamat = sheetApril.cell(CellIndex.indexByString("C${d}"));
        cellAlamat.value = dataPenjualan.elementAt(i).alamat;

        var cellPinjaman = sheetApril.cell(CellIndex.indexByString("D${d}"));
        cellPinjaman.value = dataPenjualan.elementAt(i).jumlahPinjaman;

        var cellTanggalPembelian =
            sheetApril.cell(CellIndex.indexByString("E${d}"));
        cellTanggalPembelian.value = dataPenjualan.elementAt(i).dateSort;
      } else if (dataPenjualan.elementAt(i).dateSort!.substring(5, 7) == '05') {
        e++;
        var cellJudulNomor = sheetMei.cell(CellIndex.indexByString("A1"));
        cellJudulNomor.value = 'No';
        var cellJudulNama = sheetMei.cell(CellIndex.indexByString("B1"));
        cellJudulNama.value = 'Nama';
        var cellJudulAlamat = sheetMei.cell(CellIndex.indexByString("C1"));
        cellJudulAlamat.value = 'Alamat';
        var cellJudulPinjaman = sheetMei.cell(CellIndex.indexByString("D1"));
        cellJudulPinjaman.value = 'Jumlah Pinjaman';
        var cellJudulTanggal = sheetMei.cell(CellIndex.indexByString("E1"));
        cellJudulTanggal.value = 'Tanggal Pemesanan';

        var cellNomor = sheetMei.cell(CellIndex.indexByString("A${e}"));
        cellNomor.value = e;

        var cellNama = sheetMei.cell(CellIndex.indexByString("B${e}"));
        cellNama.value = dataPenjualan.elementAt(i).namaKonsumen;

        var cellAlamat = sheetMei.cell(CellIndex.indexByString("C${e}"));
        cellAlamat.value = dataPenjualan.elementAt(i).alamat;

        var cellPinjaman = sheetMei.cell(CellIndex.indexByString("D${e}"));
        cellPinjaman.value = dataPenjualan.elementAt(i).jumlahPinjaman;

        var cellTanggalPembelian =
            sheetMei.cell(CellIndex.indexByString("E${e}"));
        cellTanggalPembelian.value = dataPenjualan.elementAt(i).dateSort;
      } else if (dataPenjualan.elementAt(i).dateSort!.substring(5, 7) == '06') {
        f++;
        var cellJudulNomor = sheetJuni.cell(CellIndex.indexByString("A1"));
        cellJudulNomor.value = 'No';
        var cellJudulNama = sheetJuni.cell(CellIndex.indexByString("B1"));
        cellJudulNama.value = 'Nama';
        var cellJudulAlamat = sheetJuni.cell(CellIndex.indexByString("C1"));
        cellJudulAlamat.value = 'Alamat';
        var cellJudulPinjaman = sheetJuni.cell(CellIndex.indexByString("D1"));
        cellJudulPinjaman.value = 'Jumlah Pinjaman';
        var cellJudulTanggal = sheetJuni.cell(CellIndex.indexByString("E1"));
        cellJudulTanggal.value = 'Tanggal Pemesanan';

        var cellNomor = sheetJuni.cell(CellIndex.indexByString("A${f}"));
        cellNomor.value = f;

        var cellNama = sheetJuni.cell(CellIndex.indexByString("B${f}"));
        cellNama.value = dataPenjualan.elementAt(i).namaKonsumen;

        var cellAlamat = sheetJuni.cell(CellIndex.indexByString("C${f}"));
        cellAlamat.value = dataPenjualan.elementAt(i).alamat;

        var cellPinjaman = sheetJuni.cell(CellIndex.indexByString("D${f}"));
        cellPinjaman.value = dataPenjualan.elementAt(i).jumlahPinjaman;

        var cellTanggalPembelian =
            sheetJuni.cell(CellIndex.indexByString("E${f}"));
        cellTanggalPembelian.value = dataPenjualan.elementAt(i).dateSort;
      } else if (dataPenjualan.elementAt(i).dateSort!.substring(5, 7) == '07') {
        g++;
        var cellJudulNomor = sheetJuli.cell(CellIndex.indexByString("A1"));
        cellJudulNomor.value = 'No';
        var cellJudulNama = sheetJuli.cell(CellIndex.indexByString("B1"));
        cellJudulNama.value = 'Nama';
        var cellJudulAlamat = sheetJuli.cell(CellIndex.indexByString("C1"));
        cellJudulAlamat.value = 'Alamat';
        var cellJudulPinjaman = sheetJuli.cell(CellIndex.indexByString("D1"));
        cellJudulPinjaman.value = 'Jumlah Pinjaman';
        var cellJudulTanggal = sheetJuli.cell(CellIndex.indexByString("E1"));
        cellJudulTanggal.value = 'Tanggal Pemesanan';

        var cellNomor = sheetJuli.cell(CellIndex.indexByString("A${g}"));
        cellNomor.value = g;

        var cellNama = sheetJuli.cell(CellIndex.indexByString("B${g}"));
        cellNama.value = dataPenjualan.elementAt(i).namaKonsumen;

        var cellAlamat = sheetJuli.cell(CellIndex.indexByString("C${g}"));
        cellAlamat.value = dataPenjualan.elementAt(i).alamat;

        var cellPinjaman = sheetJuli.cell(CellIndex.indexByString("D${g}"));
        cellPinjaman.value = dataPenjualan.elementAt(i).jumlahPinjaman;

        var cellTanggalPembelian =
            sheetJuli.cell(CellIndex.indexByString("E${g}"));
        cellTanggalPembelian.value = dataPenjualan.elementAt(i).dateSort;
      } else if (dataPenjualan.elementAt(i).dateSort!.substring(5, 7) == '08') {
        h++;
        var cellJudulNomor = sheetAgustus.cell(CellIndex.indexByString("A1"));
        cellJudulNomor.value = 'No';
        var cellJudulNama = sheetAgustus.cell(CellIndex.indexByString("B1"));
        cellJudulNama.value = 'Nama';
        var cellJudulAlamat = sheetAgustus.cell(CellIndex.indexByString("C1"));
        cellJudulAlamat.value = 'Alamat';
        var cellJudulPinjaman =
            sheetAgustus.cell(CellIndex.indexByString("D1"));
        cellJudulPinjaman.value = 'Jumlah Pinjaman';
        var cellJudulTanggal = sheetAgustus.cell(CellIndex.indexByString("E1"));
        cellJudulTanggal.value = 'Tanggal Pemesanan';

        var cellNomor = sheetAgustus.cell(CellIndex.indexByString("A${h}"));
        cellNomor.value = h;

        var cellNama = sheetAgustus.cell(CellIndex.indexByString("B${h}"));
        cellNama.value = dataPenjualan.elementAt(i).namaKonsumen;

        var cellAlamat = sheetAgustus.cell(CellIndex.indexByString("C${h}"));
        cellAlamat.value = dataPenjualan.elementAt(i).alamat;

        var cellPinjaman = sheetAgustus.cell(CellIndex.indexByString("D${h}"));
        cellPinjaman.value = dataPenjualan.elementAt(i).jumlahPinjaman;

        var cellTanggalPembelian =
            sheetAgustus.cell(CellIndex.indexByString("E${h}"));
        cellTanggalPembelian.value = dataPenjualan.elementAt(i).dateSort;
      } else if (dataPenjualan.elementAt(i).dateSort!.substring(5, 7) == '09') {
        j++;
        var cellJudulNomor = sheetSeptember.cell(CellIndex.indexByString("A1"));
        cellJudulNomor.value = 'No';
        var cellJudulNama = sheetSeptember.cell(CellIndex.indexByString("B1"));
        cellJudulNama.value = 'Nama';
        var cellJudulAlamat =
            sheetSeptember.cell(CellIndex.indexByString("C1"));
        cellJudulAlamat.value = 'Alamat';
        var cellJudulPinjaman =
            sheetSeptember.cell(CellIndex.indexByString("D1"));
        cellJudulPinjaman.value = 'Jumlah Pinjaman';
        var cellJudulTanggal =
            sheetSeptember.cell(CellIndex.indexByString("E1"));
        cellJudulTanggal.value = 'Tanggal Pemesanan';

        var cellNomor = sheetSeptember.cell(CellIndex.indexByString("A${j}"));
        cellNomor.value = j;

        var cellNama = sheetSeptember.cell(CellIndex.indexByString("B${j}"));
        cellNama.value = dataPenjualan.elementAt(i).namaKonsumen;

        var cellAlamat = sheetSeptember.cell(CellIndex.indexByString("C${j}"));
        cellAlamat.value = dataPenjualan.elementAt(i).alamat;

        var cellPinjaman =
            sheetSeptember.cell(CellIndex.indexByString("D${j}"));
        cellPinjaman.value = dataPenjualan.elementAt(i).jumlahPinjaman;

        var cellTanggalPembelian =
            sheetSeptember.cell(CellIndex.indexByString("E${j}"));
        cellTanggalPembelian.value = dataPenjualan.elementAt(i).dateSort;
      } else if (dataPenjualan.elementAt(i).dateSort!.substring(5, 7) == '10') {
        k++;
        var cellJudulNomor = sheetOktober.cell(CellIndex.indexByString("A1"));
        cellJudulNomor.value = 'No';
        var cellJudulNama = sheetOktober.cell(CellIndex.indexByString("B1"));
        cellJudulNama.value = 'Nama';
        var cellJudulAlamat = sheetOktober.cell(CellIndex.indexByString("C1"));
        cellJudulAlamat.value = 'Alamat';
        var cellJudulPinjaman =
            sheetOktober.cell(CellIndex.indexByString("D1"));
        cellJudulPinjaman.value = 'Jumlah Pinjaman';
        var cellJudulTanggal = sheetOktober.cell(CellIndex.indexByString("E1"));
        cellJudulTanggal.value = 'Tanggal Pemesanan';

        var cellNomor = sheetOktober.cell(CellIndex.indexByString("A${k}"));
        cellNomor.value = k;

        var cellNama = sheetOktober.cell(CellIndex.indexByString("B${k}"));
        cellNama.value = dataPenjualan.elementAt(i).namaKonsumen;

        var cellAlamat = sheetOktober.cell(CellIndex.indexByString("C${k}"));
        cellAlamat.value = dataPenjualan.elementAt(i).alamat;

        var cellPinjaman = sheetOktober.cell(CellIndex.indexByString("D${k}"));
        cellPinjaman.value = dataPenjualan.elementAt(i).jumlahPinjaman;

        var cellTanggalPembelian =
            sheetOktober.cell(CellIndex.indexByString("E${k}"));
        cellTanggalPembelian.value = dataPenjualan.elementAt(i).dateSort;
      } else if (dataPenjualan.elementAt(i).dateSort!.substring(5, 7) == '11') {
        l++;
        var cellJudulNomor = sheetNovember.cell(CellIndex.indexByString("A1"));
        cellJudulNomor.value = 'No';
        var cellJudulNama = sheetNovember.cell(CellIndex.indexByString("B1"));
        cellJudulNama.value = 'Nama';
        var cellJudulAlamat = sheetNovember.cell(CellIndex.indexByString("C1"));
        cellJudulAlamat.value = 'Alamat';
        var cellJudulPinjaman =
            sheetNovember.cell(CellIndex.indexByString("D1"));
        cellJudulPinjaman.value = 'Jumlah Pinjaman';
        var cellJudulTanggal =
            sheetNovember.cell(CellIndex.indexByString("E1"));
        cellJudulTanggal.value = 'Tanggal Pemesanan';

        var cellNomor = sheetNovember.cell(CellIndex.indexByString("A${l}"));
        cellNomor.value = l;

        var cellNama = sheetNovember.cell(CellIndex.indexByString("B${l}"));
        cellNama.value = dataPenjualan.elementAt(i).namaKonsumen;

        var cellAlamat = sheetNovember.cell(CellIndex.indexByString("C${l}"));
        cellAlamat.value = dataPenjualan.elementAt(i).alamat;

        var cellPinjaman = sheetNovember.cell(CellIndex.indexByString("D${l}"));
        cellPinjaman.value = dataPenjualan.elementAt(i).jumlahPinjaman;

        var cellTanggalPembelian =
            sheetNovember.cell(CellIndex.indexByString("E${l}"));
        cellTanggalPembelian.value = dataPenjualan.elementAt(i).dateSort;
      } else if (dataPenjualan.elementAt(i).dateSort!.substring(5, 7) == '12') {
        m++;
        var cellJudulNomor = sheetDesember.cell(CellIndex.indexByString("A1"));
        cellJudulNomor.value = 'No';
        var cellJudulNama = sheetDesember.cell(CellIndex.indexByString("B1"));
        cellJudulNama.value = 'Nama';
        var cellJudulAlamat = sheetDesember.cell(CellIndex.indexByString("C1"));
        cellJudulAlamat.value = 'Alamat';
        var cellJudulPinjaman =
            sheetDesember.cell(CellIndex.indexByString("D1"));
        cellJudulPinjaman.value = 'Jumlah Pinjaman';
        var cellJudulTanggal =
            sheetDesember.cell(CellIndex.indexByString("E1"));
        cellJudulTanggal.value = 'Tanggal Pemesanan';

        var cellNomor = sheetDesember.cell(CellIndex.indexByString("A${m}"));
        cellNomor.value = m;

        var cellNama = sheetDesember.cell(CellIndex.indexByString("B${m}"));
        cellNama.value = dataPenjualan.elementAt(i).namaKonsumen;

        var cellAlamat = sheetDesember.cell(CellIndex.indexByString("C${m}"));
        cellAlamat.value = dataPenjualan.elementAt(i).alamat;

        var cellPinjaman = sheetDesember.cell(CellIndex.indexByString("D${m}"));
        cellPinjaman.value = dataPenjualan.elementAt(i).jumlahPinjaman;

        var cellTanggalPembelian =
            sheetDesember.cell(CellIndex.indexByString("E${m}"));
        cellTanggalPembelian.value = dataPenjualan.elementAt(i).dateSort;
      }
    }

    if (await Permission.storage.request().isGranted) {
      File(join("/storage/emulated/0/Download/excel.xlsx"))
        ..createSync(recursive: true)
        ..writeAsBytesSync(excel.encode()!);
      print('done');
    } else {
      print('failed');
    }
  }

  Stream<List<Pesanan>> getPesananKonsumen(String id) {
    return _firebaseFirestore
        .collection('pesanan')
        .where('konsumen.idKonsumen', isEqualTo: id)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((docs) => Pesanan.fromSnapshot(docs)).toList();
    });
  }

  Future<void> addPesanan(Pesanan pesanan) async {
    return _firebaseFirestore
        .collection('pesanan')
        .add(pesanan.toDocument())
        .then((value) => print(pesanan));
  }

  Future<void> deletePesanan(String id) {
    return _firebaseFirestore.collection('pesanan').doc(id).delete();
  }

  Future<void> updatePesanan(Pesanan pesanan, String id) {
    return _firebaseFirestore
        .collection('pesanan')
        .doc(id)
        .update(
          {
            'status': pesanan.status,
            'jumlah': pesanan.jumlah,
            'total': pesanan.total,
            'produk.idProduk': pesanan.idProduk,
            'produk.namaProduk': pesanan.namaProduk,
            'produk.gambar': pesanan.gambar,
            'produk.harga': pesanan.harga,
            'produk.stok': pesanan.stok,
            'konsumen.idKonsumen': pesanan.idKonsumen,
            'konsumen.namaKonsumen': pesanan.namaKonsumen,
            'konsumen.alamat': pesanan.alamat,
            'konsumen.noTelp': pesanan.noTelp,
            'konsumen.keckelurahan': pesanan.keckelurahan,
            'konsumen.jumlahPinjaman': pesanan.jumlahPinjaman,
          },
        )
        .then((_) => print(pesanan.status))
        .catchError((onError) => print('Update failed: $onError'));
  }
}
