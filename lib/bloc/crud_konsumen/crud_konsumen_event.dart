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

  AddKonsumen({
    this.id,
    this.nama,
    this.alamat,
    this.noTelp,
  });

  @override
  List<Object?> get props => [
        id,
        nama,
        alamat,
        noTelp,
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

  UpdateKonsumen({
    this.id,
    this.nama,
    this.alamat,
    this.noTelp,
  });

  @override
  List<Object?> get props => [
        id,
        nama,
        alamat,
        noTelp,
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
