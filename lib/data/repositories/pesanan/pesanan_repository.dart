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

    for (int i = 0; i < dataPenjualan.length; i++) {
      if (dataPenjualan.elementAt(i).dateSort!.substring(5, 7) == '01') {
        var cellNomor = sheetJanuari.cell(CellIndex.indexByString("A${i + 1}"));
        cellNomor.value = i + 1;

        var cellNama = sheetJanuari.cell(CellIndex.indexByString("B${i + 1}"));
        cellNama.value = dataPenjualan.elementAt(i).namaKonsumen;

        var cellAlamat =
            sheetJanuari.cell(CellIndex.indexByString("C${i + 1}"));
        cellAlamat.value = dataPenjualan.elementAt(i).alamat;

        var cellPinjaman =
            sheetJanuari.cell(CellIndex.indexByString("D${i + 1}"));
        cellPinjaman.value = dataPenjualan.elementAt(i).jumlahPinjaman;

        var cellTanggalPembelian =
            sheetJanuari.cell(CellIndex.indexByString("E${i + 1}"));
        cellTanggalPembelian.value = dataPenjualan.elementAt(i).dateSort;
      } else if (dataPenjualan.elementAt(i).dateSort!.substring(5, 7) == '02') {
        var cellNomor =
            sheetFebruari.cell(CellIndex.indexByString("A${i + 1}"));
        cellNomor.value = i + 1;

        var cellNama = sheetFebruari.cell(CellIndex.indexByString("B${i + 1}"));
        cellNama.value = dataPenjualan.elementAt(i).namaKonsumen;

        var cellAlamat =
            sheetFebruari.cell(CellIndex.indexByString("C${i + 1}"));
        cellAlamat.value = dataPenjualan.elementAt(i).alamat;

        var cellPinjaman =
            sheetFebruari.cell(CellIndex.indexByString("D${i + 1}"));
        cellPinjaman.value = dataPenjualan.elementAt(i).jumlahPinjaman;

        var cellTanggalPembelian =
            sheetFebruari.cell(CellIndex.indexByString("E${i + 1}"));
        cellTanggalPembelian.value = dataPenjualan.elementAt(i).dateSort;
      } else if (dataPenjualan.elementAt(i).dateSort!.substring(5, 7) == '03') {
        var cellNomor = sheetMaret.cell(CellIndex.indexByString("A${i + 1}"));
        cellNomor.value = i + 1;

        var cellNama = sheetMaret.cell(CellIndex.indexByString("B${i + 1}"));
        cellNama.value = dataPenjualan.elementAt(i).namaKonsumen;

        var cellAlamat = sheetMaret.cell(CellIndex.indexByString("C${i + 1}"));
        cellAlamat.value = dataPenjualan.elementAt(i).alamat;

        var cellPinjaman =
            sheetMaret.cell(CellIndex.indexByString("D${i + 1}"));
        cellPinjaman.value = dataPenjualan.elementAt(i).jumlahPinjaman;

        var cellTanggalPembelian =
            sheetMaret.cell(CellIndex.indexByString("E${i + 1}"));
        cellTanggalPembelian.value = dataPenjualan.elementAt(i).dateSort;
      } else if (dataPenjualan.elementAt(i).dateSort!.substring(5, 7) == '04') {
        var cellNomor = sheetApril.cell(CellIndex.indexByString("A${i + 1}"));
        cellNomor.value = i + 1;

        var cellNama = sheetApril.cell(CellIndex.indexByString("B${i + 1}"));
        cellNama.value = dataPenjualan.elementAt(i).namaKonsumen;

        var cellAlamat = sheetApril.cell(CellIndex.indexByString("C${i + 1}"));
        cellAlamat.value = dataPenjualan.elementAt(i).alamat;

        var cellPinjaman =
            sheetApril.cell(CellIndex.indexByString("D${i + 1}"));
        cellPinjaman.value = dataPenjualan.elementAt(i).jumlahPinjaman;

        var cellTanggalPembelian =
            sheetApril.cell(CellIndex.indexByString("E${i + 1}"));
        cellTanggalPembelian.value = dataPenjualan.elementAt(i).dateSort;
      } else if (dataPenjualan.elementAt(i).dateSort!.substring(5, 7) == '05') {
        var cellNomor = sheetMei.cell(CellIndex.indexByString("A${i + 1}"));
        cellNomor.value = i + 1;

        var cellNama = sheetMei.cell(CellIndex.indexByString("B${i + 1}"));
        cellNama.value = dataPenjualan.elementAt(i).namaKonsumen;

        var cellAlamat = sheetMei.cell(CellIndex.indexByString("C${i + 1}"));
        cellAlamat.value = dataPenjualan.elementAt(i).alamat;

        var cellPinjaman = sheetMei.cell(CellIndex.indexByString("D${i + 1}"));
        cellPinjaman.value = dataPenjualan.elementAt(i).jumlahPinjaman;

        var cellTanggalPembelian =
            sheetMei.cell(CellIndex.indexByString("E${i + 1}"));
        cellTanggalPembelian.value = dataPenjualan.elementAt(i).dateSort;
      } else if (dataPenjualan.elementAt(i).dateSort!.substring(5, 7) == '06') {
        var cellNomor = sheetJuni.cell(CellIndex.indexByString("A${i + 1}"));
        cellNomor.value = i + 1;

        var cellNama = sheetJuni.cell(CellIndex.indexByString("B${i + 1}"));
        cellNama.value = dataPenjualan.elementAt(i).namaKonsumen;

        var cellAlamat = sheetJuni.cell(CellIndex.indexByString("C${i + 1}"));
        cellAlamat.value = dataPenjualan.elementAt(i).alamat;

        var cellPinjaman = sheetJuni.cell(CellIndex.indexByString("D${i + 1}"));
        cellPinjaman.value = dataPenjualan.elementAt(i).jumlahPinjaman;

        var cellTanggalPembelian =
            sheetJuni.cell(CellIndex.indexByString("E${i + 1}"));
        cellTanggalPembelian.value = dataPenjualan.elementAt(i).dateSort;
      } else if (dataPenjualan.elementAt(i).dateSort!.substring(5, 7) == '07') {
        var cellNomor = sheetJuli.cell(CellIndex.indexByString("A${i + 1}"));
        cellNomor.value = i + 1;

        var cellNama = sheetJuli.cell(CellIndex.indexByString("B${i + 1}"));
        cellNama.value = dataPenjualan.elementAt(i).namaKonsumen;

        var cellAlamat = sheetJuli.cell(CellIndex.indexByString("C${i + 1}"));
        cellAlamat.value = dataPenjualan.elementAt(i).alamat;

        var cellPinjaman = sheetJuli.cell(CellIndex.indexByString("D${i + 1}"));
        cellPinjaman.value = dataPenjualan.elementAt(i).jumlahPinjaman;

        var cellTanggalPembelian =
            sheetJuli.cell(CellIndex.indexByString("E${i + 1}"));
        cellTanggalPembelian.value = dataPenjualan.elementAt(i).dateSort;
      } else if (dataPenjualan.elementAt(i).dateSort!.substring(5, 7) == '08') {
        var cellNomor = sheetAgustus.cell(CellIndex.indexByString("A${i + 1}"));
        cellNomor.value = i + 1;

        var cellNama = sheetAgustus.cell(CellIndex.indexByString("B${i + 1}"));
        cellNama.value = dataPenjualan.elementAt(i).namaKonsumen;

        var cellAlamat =
            sheetAgustus.cell(CellIndex.indexByString("C${i + 1}"));
        cellAlamat.value = dataPenjualan.elementAt(i).alamat;

        var cellPinjaman =
            sheetAgustus.cell(CellIndex.indexByString("D${i + 1}"));
        cellPinjaman.value = dataPenjualan.elementAt(i).jumlahPinjaman;

        var cellTanggalPembelian =
            sheetAgustus.cell(CellIndex.indexByString("E${i + 1}"));
        cellTanggalPembelian.value = dataPenjualan.elementAt(i).dateSort;
      } else if (dataPenjualan.elementAt(i).dateSort!.substring(5, 7) == '09') {
        var cellNomor =
            sheetSeptember.cell(CellIndex.indexByString("A${i + 1}"));
        cellNomor.value = i + 1;

        var cellNama =
            sheetSeptember.cell(CellIndex.indexByString("B${i + 1}"));
        cellNama.value = dataPenjualan.elementAt(i).namaKonsumen;

        var cellAlamat =
            sheetSeptember.cell(CellIndex.indexByString("C${i + 1}"));
        cellAlamat.value = dataPenjualan.elementAt(i).alamat;

        var cellPinjaman =
            sheetSeptember.cell(CellIndex.indexByString("D${i + 1}"));
        cellPinjaman.value = dataPenjualan.elementAt(i).jumlahPinjaman;

        var cellTanggalPembelian =
            sheetSeptember.cell(CellIndex.indexByString("E${i + 1}"));
        cellTanggalPembelian.value = dataPenjualan.elementAt(i).dateSort;
      } else if (dataPenjualan.elementAt(i).dateSort!.substring(5, 7) == '10') {
        var cellNomor = sheetOktober.cell(CellIndex.indexByString("A${i + 1}"));
        cellNomor.value = i + 1;

        var cellNama = sheetOktober.cell(CellIndex.indexByString("B${i + 1}"));
        cellNama.value = dataPenjualan.elementAt(i).namaKonsumen;

        var cellAlamat =
            sheetOktober.cell(CellIndex.indexByString("C${i + 1}"));
        cellAlamat.value = dataPenjualan.elementAt(i).alamat;

        var cellPinjaman =
            sheetOktober.cell(CellIndex.indexByString("D${i + 1}"));
        cellPinjaman.value = dataPenjualan.elementAt(i).jumlahPinjaman;

        var cellTanggalPembelian =
            sheetOktober.cell(CellIndex.indexByString("E${i + 1}"));
        cellTanggalPembelian.value = dataPenjualan.elementAt(i).dateSort;
      } else if (dataPenjualan.elementAt(i).dateSort!.substring(5, 7) == '11') {
        var cellNomor =
            sheetNovember.cell(CellIndex.indexByString("A${i + 1}"));
        cellNomor.value = i + 1;

        var cellNama = sheetNovember.cell(CellIndex.indexByString("B${i + 1}"));
        cellNama.value = dataPenjualan.elementAt(i).namaKonsumen;

        var cellAlamat =
            sheetNovember.cell(CellIndex.indexByString("C${i + 1}"));
        cellAlamat.value = dataPenjualan.elementAt(i).alamat;

        var cellPinjaman =
            sheetNovember.cell(CellIndex.indexByString("D${i + 1}"));
        cellPinjaman.value = dataPenjualan.elementAt(i).jumlahPinjaman;

        var cellTanggalPembelian =
            sheetNovember.cell(CellIndex.indexByString("E${i + 1}"));
        cellTanggalPembelian.value = dataPenjualan.elementAt(i).dateSort;
      } else if (dataPenjualan.elementAt(i).dateSort!.substring(5, 7) == '12') {
        var cellNomor =
            sheetDesember.cell(CellIndex.indexByString("A${i + 1}"));
        cellNomor.value = i + 1;

        var cellNama = sheetDesember.cell(CellIndex.indexByString("B${i + 1}"));
        cellNama.value = dataPenjualan.elementAt(i).namaKonsumen;

        var cellAlamat =
            sheetDesember.cell(CellIndex.indexByString("C${i + 1}"));
        cellAlamat.value = dataPenjualan.elementAt(i).alamat;

        var cellPinjaman =
            sheetDesember.cell(CellIndex.indexByString("D${i + 1}"));
        cellPinjaman.value = dataPenjualan.elementAt(i).jumlahPinjaman;

        var cellTanggalPembelian =
            sheetDesember.cell(CellIndex.indexByString("E${i + 1}"));
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
