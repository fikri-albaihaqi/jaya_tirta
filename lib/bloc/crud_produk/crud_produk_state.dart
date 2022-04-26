part of 'crud_produk_bloc.dart';

abstract class CrudProdukState extends Equatable {
  const CrudProdukState();

  @override
  List<Object?> get props => [];
}

class CrudProdukLoading extends CrudProdukState {}

class CrudProdukLoaded extends CrudProdukState {
  final String? namaProduk;
  final String? gambar;
  final String? harga;
  final String? stok;
  final Produk produk;

  CrudProdukLoaded({
    this.namaProduk,
    this.gambar,
    this.harga,
    this.stok,
  }) : produk = Produk(
          namaProduk: namaProduk,
          gambar: gambar,
          harga: harga,
          stok: stok,
        );

  @override
  // TODO: implement props
  List<Object?> get props => [
        namaProduk,
        gambar,
        harga,
        stok,
      ];
}
