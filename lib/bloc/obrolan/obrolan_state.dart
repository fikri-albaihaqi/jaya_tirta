part of 'obrolan_bloc.dart';

abstract class ObrolanState extends Equatable {
  const ObrolanState();

  @override
  List<Object> get props => [];
}

class ObrolanInitial extends ObrolanState {}

class ObrolanLoadSuccess extends ObrolanState {
  final Obrolan obrolan;
  const ObrolanLoadSuccess({
    required this.obrolan,
  });
}

class ObrolanLoadFailure extends ObrolanState {
  final String message;
  const ObrolanLoadFailure({
    required this.message,
  });
}

class ObrolanLoadInprogress extends ObrolanState {}

class ObrolanCreationSuccess extends ObrolanState {
  final String obrolanId;
  const ObrolanCreationSuccess({
    required this.obrolanId,
  });
}

class ObrolanCreationInprogress extends ObrolanState {}

class ObrolanCreationFailure extends ObrolanState {
  final String message;
  const ObrolanCreationFailure({
    required this.message,
  });
}
