import 'package:bloc/bloc.dart';
import 'package:flutter_todo/models/user.dart';
import 'package:flutter_todo/pages/login_screen/bloc/index.dart';
import 'package:flutter_todo/repository/user_repository.dart';
import 'package:meta/meta.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  LoginScreenBloc({@required this.userRepository})
      : assert(userRepository != null);

  final UserRepository userRepository;

  @override
  LoginScreenState get initialState => AuthenticationUninitialized();

  @override
  Stream<LoginScreenState> mapEventToState(LoginScreenEvent event) async* {
    if (event is AuthenticateUser) {
      final User userDetails = await userRepository.authenticateUser(
        username: event.username,
        password: event.password,
      );

      if (userDetails.id.toString() == event.password) {
        yield AuthenticationSuccess();
      } else {
        yield AuthenticationFailed();
      }
    } else if (event is UnauthenticateUser) {
      await userRepository.logoutUser();

      yield Unauthenticated();
    }
  }
}
