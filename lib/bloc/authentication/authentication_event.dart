part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PenjualLogInRequested extends AuthenticationEvent {
  final String email;
  final String password;

  PenjualLogInRequested(this.email, this.password);
}

class KonsumenLogInRequested extends AuthenticationEvent {}

class LogOutRequested extends AuthenticationEvent {}
