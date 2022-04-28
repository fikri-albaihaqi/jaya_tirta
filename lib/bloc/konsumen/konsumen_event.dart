part of 'konsumen_bloc.dart';

abstract class KonsumenEvent extends Equatable {
  const KonsumenEvent();

  @override
  List<Object> get props => [];
}

class LoadKonsumen extends KonsumenEvent {}

class LoadedKonsumen extends KonsumenEvent {
  final List<Konsumen> konsumen;

  LoadedKonsumen(this.konsumen);

  @override
  List<Object> get props => [konsumen];
}
