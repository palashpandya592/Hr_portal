import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:interviewapp/model.dart';

abstract class InterviewState extends Equatable {
  const InterviewState();

  @override
  List<Object?> get props => [];
}

class InterviewInitial extends InterviewState {
  @override
  List<Object?> get props => [];
}

class InterviewLoading extends InterviewState {
  @override
  List<Object?> get props => [];
}

class InterViewSuccess extends InterviewState {
  Map<dynamic,dynamic>? data;

   InterViewSuccess({this.data});

  @override
  List<Object?> get props => [data];
}

class InterViewFailure extends InterviewState {
  final String? error;

  const InterViewFailure({this.error});

  @override
  List<Object?> get props => [error];
}
