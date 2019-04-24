import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_todo/pages/init_app/bloc/init_app_event.dart';
import 'package:flutter_todo/pages/init_app/bloc/init_app_state.dart';
import 'package:flutter_todo/repository/user_repository.dart';

class InitAppBloc extends Bloc<InitAppEvent, InitAppState> {
  InitAppBloc({@required this.userRepository}) : assert(userRepository != null);

  final UserRepository userRepository;

  @override
  InitAppState get initialState => UserUninitialized();

  @override
  Stream<InitAppState> mapEventToState(InitAppEvent event) async* {
    if (event is AppStarted) {
      final bool hasToken = await userRepository.hasToken();

      if (hasToken) {
        yield UserAuthenticated();
      } else {
        yield UserUnauthenticated();
      }
    }
  }
}
