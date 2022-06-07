part of 'filter_bloc.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object> get props => [];
}

class LoadFilter extends FilterEvent {
  @override
  List<Object> get props => [];
}

class UpdateStatusFilter extends FilterEvent {
  final StatusFilter statusFilter;

  const UpdateStatusFilter({required this.statusFilter});

  @override
  List<Object> get props => [statusFilter];
}
