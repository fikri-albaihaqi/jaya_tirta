import 'package:equatable/equatable.dart';
import 'package:jaya_tirta/data/models/models.dart';

class Filter extends Equatable {
  final List<StatusFilter> statusFilters;

  const Filter({
    this.statusFilters = const <StatusFilter>[],
  });

  Filter copyWith({
    List<StatusFilter>? statusFilters,
  }) {
    return Filter(
      statusFilters: statusFilters ?? this.statusFilters,
    );
  }

  @override
  List<Object?> get props => [statusFilters];
}
