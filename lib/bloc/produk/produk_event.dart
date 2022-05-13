part of 'produk_bloc.dart';

abstract class ProdukEvent extends Equatable {
  const ProdukEvent();

  @override
  List<Object?> get props => [];
}

class LoadProduk extends ProdukEvent {}

class LoadedProduk extends ProdukEvent {
  final List<Produk> produk;

  const LoadedProduk(this.produk);

  @override
  List<Object> get props => [produk];
}
