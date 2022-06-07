import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/data/models/models.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final PesananBloc _pesananBloc;

  FilterBloc({required PesananBloc pesananBloc})
      : _pesananBloc = pesananBloc,
        super(FilterLoading()) {
    on<LoadFilter>(_onLoadFilter);
    on<UpdateStatusFilter>(_onUpdateStatusFilter);
  }

  void _onLoadFilter(
    LoadFilter event,
    Emitter<FilterState> emit,
  ) async {
    emit(
      FilterLoaded(
        filter: Filter(
          statusFilters: StatusFilter.filters,
        ),
      ),
    );
  }

  void _onUpdateStatusFilter(
    UpdateStatusFilter event,
    Emitter<FilterState> emit,
  ) async {
    final state = this.state;
    if (state is FilterLoaded) {
      final List<StatusFilter> updatedStatusFilters =
          state.filter.statusFilters.map((statusFilter) {
        return statusFilter.id == event.statusFilter.id
            ? event.statusFilter
            : statusFilter;
      }).toList();

      var status = updatedStatusFilters
          .where((filter) => filter.value)
          .map((filter) => filter.status)
          .toList();

      List<Pesanan> filteredPesanan = _getFilteredPesanan(
        status,
      );

      emit(
        FilterLoaded(
          filter: Filter(
            statusFilters: updatedStatusFilters,
          ),
          filteredPesanan: filteredPesanan,
        ),
      );
    }
  }

  List<Pesanan> _getFilteredPesanan(
    List<String?> status,
  ) {
    return (_pesananBloc.state as PesananLoaded)
        .pesanan
        .where(
          (pesanan) => status.any(
            (status) => pesanan.status!.contains(status!),
          ),
        )
        .toList();
  }
}
