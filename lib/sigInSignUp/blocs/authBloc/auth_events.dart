import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class SignUpButtonEvent extends AuthenticationEvent {
  final String email, password;

  const SignUpButtonEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LoginButtonEvent extends AuthenticationEvent {
  final String email, password;

  const LoginButtonEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
