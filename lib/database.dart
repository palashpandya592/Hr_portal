import 'package:firebase_database/firebase_database.dart';

class InterviewDao {
  final DatabaseReference _interviewRef =
  FirebaseDatabase.instance.reference().child('interview');

  Query getInterviewQuery() {
    return _interviewRef;
  }

}

