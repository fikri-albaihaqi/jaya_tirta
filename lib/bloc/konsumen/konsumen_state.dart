part of 'konsumen_bloc.dart';

abstract class KonsumenState extends Equatable {
  const KonsumenState();

  @override
  List<Object> get props => [];
}

class KonsumenLoading extends KonsumenState {}

class KonsumenLoaded extends KonsumenState {
  final List<Konsumen> konsumen;

  KonsumenLoaded({this.konsumen = const <Konsumen>[]});

  @override
  List<Object> get props => [konsumen];
}
