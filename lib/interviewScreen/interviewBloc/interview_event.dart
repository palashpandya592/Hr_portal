import 'package:equatable/equatable.dart';

abstract class InterviewEvent extends Equatable {
  const InterviewEvent();

  @override
  List<Object> get props => [];
}

class LoadInterviewList extends InterviewEvent {
  @override
  List<Object> get props => [];
}

class GetInterviewList extends InterviewEvent {

  @override
  List<Object> get props => [];
}
