part of 'peramalan_bulanan_bloc.dart';

abstract class PeramalanBulananState extends Equatable {
  const PeramalanBulananState();

  @override
  List<Object> get props => [];
}

class PeramalanBulananLoading extends PeramalanBulananState {}

class PeramalanBulananLoaded extends PeramalanBulananState {
  final List<Ramalan> peramalan;

  const PeramalanBulananLoaded({this.peramalan = const <Ramalan>[]});

  @override
  List<Object> get props => [peramalan];
}
