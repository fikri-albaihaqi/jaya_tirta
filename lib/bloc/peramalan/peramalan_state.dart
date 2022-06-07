part of 'peramalan_bloc.dart';

abstract class PeramalanState extends Equatable {
  const PeramalanState();

  @override
  List<Object> get props => [];
}

class PeramalanLoading extends PeramalanState {}

class PeramalanLoaded extends PeramalanState {
  final List<Peramalan> peramalan;

  const PeramalanLoaded({this.peramalan = const <Peramalan>[]});

  @override
  List<Object> get props => [peramalan];
}
