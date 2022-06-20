import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interviewapp/interviewScreen/interviewBloc/interview_event.dart';
import 'package:interviewapp/interviewScreen/interviewBloc/interview_state.dart';
import 'package:interviewapp/model.dart';

class InterviewBloc extends Bloc<InterviewEvent, InterviewState> {
  InterviewBloc(InterviewLoading initialState) : super(initialState);

  @override
  Stream<InterviewState> mapEventToState(InterviewEvent event) async* {
    InterviewBean? interviewList;
    Map<dynamic, dynamic>? exist;
    final firestoreInstance = FirebaseFirestore.instance;

    if (event is GetInterviewList) {
      yield InterviewLoading();
      try {
        yield InterviewLoading();
        var snapshot = FirebaseDatabase.instance
            .reference()
            .child('interview')
            .orderByValue()
            .once()
            .then((DataSnapshot snapshot) async {
          String jsonsDataString = snapshot.value
              .toString(); // toString of Response's body is assigned to jsonDataString
        });

        yield InterViewSuccess(data: exist);
      } catch (e) {
        yield InterViewFailure(error: e.toString());
      }
    }
  }
}
