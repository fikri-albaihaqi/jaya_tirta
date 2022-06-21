part of 'peramalan_mingguan_bloc.dart';

abstract class PeramalanMingguanState extends Equatable {
  const PeramalanMingguanState();

  @override
  List<Object> get props => [];
}

class PeramalanMingguanLoading extends PeramalanMingguanState {}

class PeramalanMingguanLoaded extends PeramalanMingguanState {
  final List<Ramalan> peramalan;

  const PeramalanMingguanLoaded({this.peramalan = const <Ramalan>[]});

  @override
  List<Object> get props => [peramalan];
}
