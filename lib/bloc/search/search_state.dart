part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Pesanan> pesanan;

  const SearchLoaded({this.pesanan = const <Pesanan>[]});

  @override
  List<Object?> get props => [pesanan];
}
