part of 'crud_penjual_bloc.dart';

abstract class CrudPenjualEvent extends Equatable {
  const CrudPenjualEvent();

  @override
  List<Object?> get props => [];
}

class UpdatePenjual extends CrudPenjualEvent {
  final String? id;
  final String? nama;
  final String? noTelp;

  const UpdatePenjual({
    this.id,
    this.nama,
    this.noTelp,
  });

  @override
  List<Object?> get props => [
        id,
        nama,
        noTelp,
      ];
}

class ConfirmUpdatePenjual extends CrudPenjualEvent {
  final Penjual penjual;
  final String? id;

  const ConfirmUpdatePenjual({required this.penjual, required this.id});

  @override
  List<Object> get props => [penjual];
}
