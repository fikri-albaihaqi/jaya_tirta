import 'package:bloc/bloc.dart';
import 'package:jaya_tirta/data/repositories/authentication/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authRepository;
  AuthenticationBloc({required this.authRepository})
      : super(UnAuthenticated()) {
    on<PenjualLogInRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.logIn(
            email: event.email, password: event.password);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    on<LogOutRequested>((event, emit) async {
      emit(Loading());
      await authRepository.logOut();
      emit(UnAuthenticated());
    });
    on<KonsumenLogInRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.konsumenLogIn();
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
  }
}
