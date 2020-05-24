import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../Models/models.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/// Event AppStarted
class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

/// Event LoggedIn
class LoggedIn extends AuthenticationEvent {
  final User user;

  LoggedIn(this.user);

  @override
  String toString() => 'LoggedIn';
}

/// Event LoggedOut
class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}