import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationLoading extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationSuccess extends AuthenticationState {
  final User? user;

  const AuthenticationSuccess({this.user});

  @override
  List<Object?> get props => [user!];
}

class AuthenticationFailure extends AuthenticationState {
  final String? error;

  const AuthenticationFailure({this.error});

  @override
  List<Object?> get props => [error];
}
