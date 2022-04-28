part of 'crud_konsumen_bloc.dart';

abstract class CrudKonsumenState extends Equatable {
  const CrudKonsumenState();

  @override
  List<Object?> get props => [];
}

class CrudKonsumenLoading extends CrudKonsumenState {}

class CrudKonsumenLoaded extends CrudKonsumenState {
  final String? nama;
  final String? alamat;
  final String? noTelp;
  final Konsumen konsumen;

  CrudKonsumenLoaded({
    this.nama,
    this.alamat,
    this.noTelp,
  }) : konsumen = Konsumen(
          nama: nama,
          alamat: alamat,
          noTelp: noTelp,
        );

  @override
  List<Object?> get props => [
        nama,
        alamat,
        noTelp,
      ];
}
