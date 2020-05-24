import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:keep_full/database_helper.dart';
import '../../Blocs/authentication/bloc.dart';
import '../../Models/models.dart';

/// Authentication Bloc
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  User user;

  @override
  // TODO: implement initialState
  AuthenticationState get initialState => Uninitialized();

  AuthenticationBloc({@required User user}) : user = user;

  /// Map an event to a state
  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState(event);
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState(event);
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState(event);
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState(
      AuthenticationEvent event) async* {
    try {
      /// Get user from shared preferences
      this.user = await User.getUser();
      if (user.isLogged) {
        yield Authenticated(user);
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  /// map LoggedIn event to a state
  Stream<AuthenticationState> _mapLoggedInToState(LoggedIn event) async* {
    this.user = event.user;
    yield Authenticated(user);
  }

  /// map LoggedOut event to a state
  Stream<AuthenticationState> _mapLoggedOutToState(LoggedOut event) async* {
    /// Logout
    await user.logOut();

    App.clearSharedPreferences();

    /// Truncate database;
    await DataBaseHelper.instance.truncateDatabase();
    yield Unauthenticated();
  }
}
