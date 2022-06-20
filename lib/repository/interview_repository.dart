import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:interviewapp/model.dart';

abstract class BaseRepository {
  Stream<List<InterviewBean>> getAllInterviewList();
}

class InterviewRepository extends BaseRepository {
  final FirebaseFirestore? _firebaseFirestore;

  InterviewRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<InterviewBean>> getAllInterviewList() {
    return _firebaseFirestore!
        .collection('interview')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => InterviewBean.fromJson(doc.data()))
          .toList();
    });
  }
}
