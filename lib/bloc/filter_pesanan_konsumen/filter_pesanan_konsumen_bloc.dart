import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jaya_tirta/bloc/blocs.dart';
import 'package:jaya_tirta/data/models/models.dart';

part 'filter_pesanan_konsumen_event.dart';
part 'filter_pesanan_konsumen_state.dart';

class FilterPesananKonsumenBloc
    extends Bloc<FilterPesananKonsumenEvent, FilterPesananKonsumenState> {
  final PesananKonsumenBloc _pesananKonsumenBloc;

  FilterPesananKonsumenBloc({required PesananKonsumenBloc pesananKonsumenBloc})
      : _pesananKonsumenBloc = pesananKonsumenBloc,
        super(FilterPesananKonsumenLoading()) {
    on<LoadFilterPesananKonsumen>(_onLoadFilter);
    on<UpdateStatusFilterPesananKonsumen>(_onUpdateStatusFilter);
  }

  void _onLoadFilter(
    LoadFilterPesananKonsumen event,
    Emitter<FilterPesananKonsumenState> emit,
  ) async {
    emit(
      FilterPesananKonsumenLoaded(
        filter: Filter(
          statusFilters: StatusFilter.filters,
        ),
      ),
    );
  }

  void _onUpdateStatusFilter(
    UpdateStatusFilterPesananKonsumen event,
    Emitter<FilterPesananKonsumenState> emit,
  ) async {
    final state = this.state;
    if (state is FilterPesananKonsumenLoaded) {
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
        FilterPesananKonsumenLoaded(
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
    return (_pesananKonsumenBloc.state as PesananKonsumenLoaded)
        .pesanan
        .where(
          (pesanan) => status.any(
            (status) => pesanan.status!.contains(status!),
          ),
        )
        .toList();
  }
}
