import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interviewapp/interviewScreen/interviewBloc/interview_event.dart';
import 'package:interviewapp/interviewScreen/interviewBloc/interview_state.dart';
import 'package:interviewapp/repository/interview_repository.dart';
import 'package:interviewapp/sigInSignUp/blocs/authBloc/auth_events.dart';

class InterviewBloc extends Bloc<AuthenticationEvent, InterviewState> {
  InterviewRepository _interviewRepository;
  StreamSubscription? _streamSubscription;

  InterviewBloc({required InterviewRepository interviewRepository})
      : _interviewRepository = interviewRepository,
        super(InterviewLoading());

  @override
  Stream<InterviewState> mapEventToState(AuthenticationEvent event) async* {
    /* if(event is LoadInterviewList){
      yield* _mapLoadInterviewerToSate();
    }*/
    /* if(event is GetInterviewList){
      yield* _mapGetInterviewerToSate(event);
    }
  }*/
/*   Stream<InterviewState> _mapLoadInterviewerToSate() async*{
     _streamSubscription!.cancel();
     _streamSubscription =_interviewRepository.getAllInterviewList().listen((interview) =>add(
         GetInterviewList(interview),
     ),);
   }*/

    Stream<InterviewState> _mapGetInterviewerToSate(GetInterviewList event) async* {
      yield InterViewSuccess(interViewList: event.interview);
    }
  }

/*if(event is GetInterviewList){
      yield InterviewLoading();
      _streamSubscription!.cancel();
  }*/

}
