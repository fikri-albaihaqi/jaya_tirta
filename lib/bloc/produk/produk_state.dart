part of 'produk_bloc.dart';

abstract class ProdukState extends Equatable {
  const ProdukState();

  @override
  List<Object?> get props => [];
}

class ProdukLoading extends ProdukState {}

class ProdukLoaded extends ProdukState {
  final List<Produk> produk;

  const ProdukLoaded({this.produk = const <Produk>[]});

  @override
  List<Object> get props => [produk];
}
