part of 'konsumen_bloc.dart';

abstract class KonsumenEvent extends Equatable {
  const KonsumenEvent();

  @override
  List<Object> get props => [];
}

class LoadAllKonsumen extends KonsumenEvent {}

class LoadKonsumen extends KonsumenEvent {
  final String? id;

  const LoadKonsumen({required this.id});

  @override
  List<Object> get props => [];
}

class LoadedKonsumen extends KonsumenEvent {
  final List<Konsumen> konsumen;

  const LoadedKonsumen(this.konsumen);

  @override
  List<Object> get props => [konsumen];
}
