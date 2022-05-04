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

  CrudKonsumenLoaded({
    this.id,
    this.nama,
    this.alamat,
    this.noTelp,
  }) : konsumen = Konsumen(
          id: id,
          nama: nama,
          alamat: alamat,
          noTelp: noTelp,
        );

  @override
  List<Object?> get props => [
        id,
        nama,
        alamat,
        noTelp,
      ];
}
