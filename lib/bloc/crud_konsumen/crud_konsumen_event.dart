part of 'crud_konsumen_bloc.dart';

abstract class CrudKonsumenEvent extends Equatable {
  const CrudKonsumenEvent();

  @override
  List<Object?> get props => [];
}

class AddKonsumen extends CrudKonsumenEvent {
  final String? id;
  final String? nama;
  final String? alamat;
  final String? noTelp;
  final String? keckelurahan;
  final String? jumlahPinjaman;

  const AddKonsumen({
    this.id,
    this.nama,
    this.alamat,
    this.noTelp,
    this.keckelurahan,
    this.jumlahPinjaman,
  });

  @override
  List<Object?> get props => [
        id,
        nama,
        alamat,
        noTelp,
        keckelurahan,
        jumlahPinjaman,
      ];
}

class ConfirmAddKonsumen extends CrudKonsumenEvent {
  final Konsumen konsumen;

  const ConfirmAddKonsumen({required this.konsumen});

  @override
  List<Object> get props => [konsumen];
}

class UpdateKonsumen extends CrudKonsumenEvent {
  final String? id;
  final String? nama;
  final String? alamat;
  final String? noTelp;
  final String? keckelurahan;
  final String? jumlahPinjaman;

  const UpdateKonsumen({
    this.id,
    this.nama,
    this.alamat,
    this.noTelp,
    this.keckelurahan,
    this.jumlahPinjaman,
  });

  @override
  List<Object?> get props => [
        id,
        nama,
        alamat,
        noTelp,
        keckelurahan,
        jumlahPinjaman,
      ];
}

class ConfirmUpdateKonsumen extends CrudKonsumenEvent {
  final Konsumen konsumen;
  final String? id;

  const ConfirmUpdateKonsumen({required this.konsumen, required this.id});

  @override
  List<Object> get props => [konsumen];
}

class DeleteKonsumen extends CrudKonsumenEvent {
  final String id;

  const DeleteKonsumen({required this.id});

  @override
  List<Object> get props => [];
}
