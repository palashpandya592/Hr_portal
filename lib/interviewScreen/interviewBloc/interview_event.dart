import 'package:equatable/equatable.dart';
import 'package:interviewapp/model.dart';

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
  final List<InterviewBean> interview;

  const GetInterviewList(this.interview);

  @override
  List<Object> get props => [interview];
}
