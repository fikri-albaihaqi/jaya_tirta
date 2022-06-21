part of 'crud_penjual_bloc.dart';

abstract class CrudPenjualState extends Equatable {
  const CrudPenjualState();

  @override
  List<Object?> get props => [];
}

class CrudPenjualLoading extends CrudPenjualState {}

class CrudPenjualLoaded extends CrudPenjualState {
  final String? id;
  final String? nama;
  final String? noTelp;
  final Penjual penjual;

  CrudPenjualLoaded({
    this.id,
    this.nama,
    this.noTelp,
  }) : penjual = Penjual(
          id: id,
          nama: nama,
          noTelp: noTelp,
        );

  @override
  List<Object?> get props => [
        id,
        nama,
        noTelp,
      ];
}
