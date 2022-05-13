import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jaya_tirta/data/repositories/konsumen/konsumen_repository.dart';

part 'shared_preferences_event.dart';
part 'shared_preferences_state.dart';

class SharedPreferencesBloc
    extends Bloc<SharedPreferencesEvent, SharedPreferencesState> {
  final KonsumenRepository _konsumenRepository;

  SharedPreferencesBloc({required KonsumenRepository konsumenRepository})
      : _konsumenRepository = konsumenRepository,
        super(const SharedPreferencesLoaded()) {
    on<LoadSharedPreferences>(_onLoadSharedPreferences);
    on<LoadedSharedPreferences>(_onLoadedSharedPreferences);
  }

  void _onLoadSharedPreferences(
    LoadSharedPreferences event,
    Emitter<SharedPreferencesState> emit,
  ) async {
    await _konsumenRepository.loadDataKonsumen().then(
          (konsumen) => add(
            LoadedSharedPreferences(konsumen),
          ),
        );
  }

  void _onLoadedSharedPreferences(
    LoadedSharedPreferences event,
    Emitter<SharedPreferencesState> emit,
  ) {
    emit(SharedPreferencesLoaded(konsumen: event.konsumen));
  }
}
