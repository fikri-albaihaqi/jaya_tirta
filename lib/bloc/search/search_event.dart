part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class LoadSearch extends SearchEvent {}

class SearchPesanan extends SearchEvent {
  final String? parameter;

  const SearchPesanan({
    this.parameter,
  });

  @override
  List<Object?> get props => [
        parameter,
      ];
}

class UpdateResults extends SearchEvent {
  final List<Pesanan> pesanan;

  const UpdateResults(this.pesanan);

  @override
  List<Object?> get props => [pesanan];
}
