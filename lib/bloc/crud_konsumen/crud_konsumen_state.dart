part of 'crud_konsumen_bloc.dart';

abstract class CrudKonsumenState extends Equatable {
  const CrudKonsumenState();

  @override
  List<Object?> get props => [];
}

class CrudKonsumenLoading extends CrudKonsumenState {}

class CrudKonsumenLoaded extends CrudKonsumenState {
  final String? id;
  final String? nama;
  final String? alamat;
  final String? noTelp;
  final Konsumen konsumen;
  final String? keckelurahan;

  CrudKonsumenLoaded(
      {this.id, this.nama, this.alamat, this.noTelp, this.keckelurahan})
      : konsumen = Konsumen(
          id: id,
          nama: nama,
          alamat: alamat,
          noTelp: noTelp,
          keckelurahan: keckelurahan,
        );

  @override
  List<Object?> get props => [
        id,
        nama,
        alamat,
        noTelp,
        keckelurahan,
      ];
}
