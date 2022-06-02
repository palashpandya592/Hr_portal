import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:interviewapp/interviewScreen/interviewCandidateListPage.dart';
import 'package:interviewapp/model.dart';

class candidateReviewPage extends StatefulWidget {
  InterviewBean interviewBean;
  String commonKey;

  candidateReviewPage({required this.interviewBean, required this.commonKey, Key? key}) : super(key: key);

  @override
  _candidateReviewPageState createState() => _candidateReviewPageState();
}

class _candidateReviewPageState extends State<candidateReviewPage> {
  DatabaseReference? _interviewRef;
  final _feedController = TextEditingController();
  final _hrReviewController = TextEditingController();
  bool? isApproved;

  @override
  void initState() {
    _interviewRef = FirebaseDatabase.instance.reference().child('interview');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("HR-Interview Review Screen"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 7),
          child: SingleChildScrollView(
            child: Column(
              children: [
                candidateDetailTile(title: "Name", value: widget.interviewBean.name ?? ""),
                candidateDetailTile(title: "Age", value: widget.interviewBean.age ?? ""),
                candidateDetailTile(title: "DOB", value: widget.interviewBean.dob ?? ""),
                candidateDetailTile(title: "Gender", value: widget.interviewBean.gender ?? ""),
                candidateDetailTile(title: "email", value: widget.interviewBean.email ?? ""),
                candidateDetailTile(title: "Contact Number", value: widget.interviewBean.mobileNum ?? ""),
                candidateDetailTile(title: "Work Option", value: widget.interviewBean.workPlaceOption ?? "-"),
                candidateDetailTile(title: "Current LPG", value: widget.interviewBean.currentLpg ?? ""),
                candidateDetailTile(title: "Expected LPG", value: widget.interviewBean.expectedLpg ?? ""),
                candidateDetailTile(title: "Notice Period", value: widget.interviewBean.prohibitionPeriod ?? ""),
                candidateDetailTile(title: "Education  ", value: widget.interviewBean.studies ?? ""),
                candidateDetailTile(title: "Tech.Skills", value: widget.interviewBean.skills ?? ""),
                widget.interviewBean.status == "In-Review"
                    ? Column(
                        children: [
                          textFieldWidget(
                              controller: _feedController,
                              title: "Interview feedback",
                              hintText: "Enter Interview feedback",
                              keyboardType: TextInputType.text,
                              height: 65,
                              width: MediaQuery.of(context).size.width),
                          textFieldWidget(
                              controller: _hrReviewController,
                              title: "Hr Review",
                              hintText: "Enter Hr Review",
                              keyboardType: TextInputType.text,
                              height: 55,
                              width: MediaQuery.of(context).size.width),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 40,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Wrap(
                                        crossAxisAlignment: WrapCrossAlignment.center,
                                        alignment: WrapAlignment.center,
                                        children: const [
                                          Text("Approve", style: TextStyle(fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          isApproved = true;
                                        });
                                        if (_hrReviewController.text.isNotEmpty && _feedController.text.isNotEmpty) {
                                          _updateInterviewData();
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Candidate Profile is Updated')));
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please Enter Required Details')));
                                        }
                                      }),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                SizedBox(
                                  width: 110,
                                  height: 40,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Wrap(
                                        crossAxisAlignment: WrapCrossAlignment.center,
                                        alignment: WrapAlignment.center,
                                        children: const [
                                          Text("Reject", style: TextStyle(fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          isApproved = false;
                                        });
                                        if (_hrReviewController.text.isNotEmpty && _feedController.text.isNotEmpty) {
                                          _updateInterviewData();
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Candidate Profile is Updated')));
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please Enter Required Details')));
                                        }
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          candidateDetailTile(title: "Interview FeedBack", value: widget.interviewBean.feedback ?? ""),
                          candidateDetailTile(title: "HR Review", value: widget.interviewBean.hrReview ?? ""),
                          candidateDetailTile(title: "Status", value: widget.interviewBean.status ?? ""),
                        ],
                      ),
              ],
            ),
          ),
        ));
  }

  void _updateInterviewData() {
    String? status = isApproved == true ? "Approved" : "Rejected";
    String? feedback = _feedController.text;
    String? hrReview = _hrReviewController.text;

    Map<String, String> interview = {'status': status, 'feedback': feedback, 'hrReview': hrReview};

    _interviewRef!
        .child(widget.commonKey)
        .update(interview)
        .then((value) => navigateToInterviewListPage(context));
    setState(() {});
    print("widget.commonKey${widget.commonKey}");
  }

  Widget candidateDetailTile({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "$title" " " ":",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.blue.withOpacity(0.7), fontWeight: FontWeight.w700, fontSize: 15),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: MediaQuery.of(context).size.width - 130,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w500),
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }

  Widget textFieldWidget(
      {TextEditingController? controller,
      TextInputType? keyboardType,
      String? hintText,
      double? width,
      double? height,
      String? title,
      String? imageUrl,
      bool? isMandatory = false}) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
        width: width ?? 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6.0, right: 5.0, bottom: 2.0),
              child: SizedBox(
                width: 280,
                child: Text(
                  title!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w700),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 0.0, 2, 0.0),
              child: Container(
                width: width ?? 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  //border: Border.all(color: Colors.grey.withOpacity(0.6)),
                ),
                child: TextFormField(
                  maxLines: 4,
                  controller: controller,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Field Can't be Empty ";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10.0),
                    ), //make the icon also change its color
                  ),
                  onChanged: (val) {
                    print(controller!.text.toString());
                    setState(() {});
                  },
                  keyboardType: keyboardType,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void navigateToInterviewListPage(BuildContext? context) {
  Navigator.push(context!, MaterialPageRoute(builder: (context) => const InterViewerCandidatePage()));
}
