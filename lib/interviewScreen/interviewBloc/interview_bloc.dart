import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interviewapp/interviewScreen/interviewBloc/interview_event.dart';
import 'package:interviewapp/interviewScreen/interviewBloc/interview_state.dart';
import 'package:interviewapp/model.dart';
import 'package:interviewapp/repository/interview_repository.dart';
import 'package:interviewapp/sigInSignUp/blocs/authBloc/auth_events.dart';

class InterviewBloc extends Bloc<InterviewEvent, InterviewState> {
  InterviewBloc(InterviewLoading initialState) : super(initialState);

  @override
  Stream<InterviewState> mapEventToState(InterviewEvent event) async* {
    List<InterviewBean>? interviewList;
    Map<dynamic,dynamic>? exist;
    final firestoreInstance = FirebaseFirestore.instance;

    if (event is GetInterviewList) {
      yield InterviewLoading();
      try {
        print("1111111111111");
        yield InterviewLoading();
        print("2222222222");
        var snapshot  = FirebaseDatabase.instance.reference().child('interview').orderByValue().once().
        then((DataSnapshot snapshot) async{
          exist =snapshot.value;
          print("exist${exist!.values}");
           }
          );
        print("33333333");
        yield InterViewSuccess(data: exist);
      } catch (e) {
        yield InterViewFailure(error: e.toString());
      }
    }

  }
  }
