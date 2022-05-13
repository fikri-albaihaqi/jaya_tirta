part of 'shared_preferences_bloc.dart';

abstract class SharedPreferencesEvent extends Equatable {
  const SharedPreferencesEvent();

  @override
  List<Object> get props => [];
}

class LoadSharedPreferences extends SharedPreferencesEvent {}

class LoadedSharedPreferences extends SharedPreferencesEvent {
  final List<String> konsumen;

  const LoadedSharedPreferences(this.konsumen);

  @override
  List<Object> get props => [konsumen];
}
