part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// When the user signing in with email and password this event is called and the [AuthRepository] is called to sign in the user
class LogInRequested extends AuthenticationEvent {
  final String email;
  final String password;

  LogInRequested(this.email, this.password);
}

// When the user signing out this event is called and the [AuthRepository] is called to sign out the user
class LogOutRequested extends AuthenticationEvent {}
