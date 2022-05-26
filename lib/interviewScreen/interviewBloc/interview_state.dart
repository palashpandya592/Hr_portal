import 'package:equatable/equatable.dart';
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
  final List<InterviewBean>? interViewList;

  const InterViewSuccess({this.interViewList});

  @override
  List<Object?> get props => [interViewList!];
}

class InterViewFailure extends InterviewState {
  final String? error;

  const InterViewFailure({this.error});

  @override
  List<Object?> get props => [error];
}
