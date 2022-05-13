part of 'crud_produk_bloc.dart';

abstract class CrudProdukState extends Equatable {
  const CrudProdukState();

  @override
  List<Object?> get props => [];
}

class CrudProdukLoading extends CrudProdukState {}

class CrudProdukLoaded extends CrudProdukState {
  final String? id;
  final String? namaProduk;
  final String? gambar;
  final String? harga;
  final String? stok;
  final Produk produk;

  CrudProdukLoaded({
    this.id,
    this.namaProduk,
    this.gambar,
    this.harga,
    this.stok,
  }) : produk = Produk(
          id: id,
          namaProduk: namaProduk,
          gambar: gambar,
          harga: harga,
          stok: stok,
        );

  @override
  List<Object?> get props => [
        id,
        namaProduk,
        gambar,
        harga,
        stok,
      ];
}
