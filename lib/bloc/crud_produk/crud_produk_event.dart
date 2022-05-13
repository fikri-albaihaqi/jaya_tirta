part of 'crud_produk_bloc.dart';

abstract class CrudProdukEvent extends Equatable {
  const CrudProdukEvent();

  @override
  List<Object?> get props => [];
}

class AddProduk extends CrudProdukEvent {
  final String? id;
  final String? namaProduk;
  final String? gambar;
  final String? harga;
  final String? stok;

  const AddProduk({
    this.id,
    this.namaProduk,
    this.gambar,
    this.harga,
    this.stok,
  });

  @override
  List<Object?> get props => [
        id,
        namaProduk,
        gambar,
        harga,
        stok,
      ];
}

class ConfirmAddProduk extends CrudProdukEvent {
  final Produk produk;

  const ConfirmAddProduk({required this.produk});

  @override
  List<Object> get props => [produk];
}

class UpdateProduk extends CrudProdukEvent {
  final String? id;
  final String? namaProduk;
  final String? gambar;
  final String? harga;
  final String? stok;

  const UpdateProduk({
    this.id,
    this.namaProduk,
    this.gambar,
    this.harga,
    this.stok,
  });

  @override
  List<Object?> get props => [
        id,
        namaProduk,
        gambar,
        harga,
        stok,
      ];
}

class ConfirmUpdateProduk extends CrudProdukEvent {
  final Produk produk;
  final String? id;

  const ConfirmUpdateProduk({required this.produk, required this.id});

  @override
  List<Object> get props => [produk];
}

class DeleteProduk extends CrudProdukEvent {
  final String id;

  const DeleteProduk({required this.id});

  @override
  List<Object> get props => [];
}
