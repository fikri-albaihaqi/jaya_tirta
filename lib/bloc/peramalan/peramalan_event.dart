part of 'peramalan_bloc.dart';

abstract class PeramalanEvent extends Equatable {
  const PeramalanEvent();

  @override
  List<Object> get props => [];
}

class LoadPeramalan extends PeramalanEvent {}

class LoadedPeramalan extends PeramalanEvent {
  final List<Peramalan> peramalan;

  const LoadedPeramalan(this.peramalan);

  @override
  List<Object> get props => [peramalan];
}
