part of 'shared_preferences_bloc.dart';

abstract class SharedPreferencesState extends Equatable {
  const SharedPreferencesState();

  @override
  List<Object> get props => [];
}

class SharedPreferencesLoading extends SharedPreferencesState {}

class SharedPreferencesLoaded extends SharedPreferencesState {
  final List<String> konsumen;

  SharedPreferencesLoaded({this.konsumen = const <String>[]});

  @override
  List<Object> get props => [konsumen];
}
