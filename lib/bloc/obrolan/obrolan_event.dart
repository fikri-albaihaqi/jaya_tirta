part of 'obrolan_bloc.dart';

abstract class ObrolanEvent extends Equatable {
  const ObrolanEvent();

  @override
  List<Object> get props => [];
}

class ObrolanDetailRequested extends ObrolanEvent {
  final UserChat loginUser;
  final UserChat receiver;
  const ObrolanDetailRequested({
    required this.loginUser,
    required this.receiver,
  });
}

class ObrolanCreated extends ObrolanEvent {
  final Obrolan obrolan;
  const ObrolanCreated({
    required this.obrolan,
  });
}
