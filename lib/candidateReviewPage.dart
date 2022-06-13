import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:interviewapp/interviewScreen/interviewCandidateListPage.dart';
import 'package:interviewapp/model.dart';

class CandidateReviewPage extends StatefulWidget {
  InterviewBean interviewBean;
  String commonKey;
  bool? isHrRole;

  CandidateReviewPage({required this.interviewBean, required this.commonKey, Key? key,this.isHrRole}) : super(key: key);

  @override
  _CandidateReviewPageState createState() => _CandidateReviewPageState();
}

class _CandidateReviewPageState extends State<CandidateReviewPage> {
  DatabaseReference? _interviewRef;
  final _technicalReviewController = TextEditingController();
  final _practicalReview = TextEditingController();
  final _hrReviewController = TextEditingController();
  bool? isApproved;
  bool? isTeamLeadApproved;

  @override
  void initState() {
    _interviewRef = FirebaseDatabase.instance.reference().child('interview');
    print("commonKey${widget.commonKey}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
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
                candidateDetailTile(title: "Department", value: widget.interviewBean.department ?? ""),
                candidateDetailTile(title: "Work Option", value: widget.interviewBean.workPlaceOption ?? "-"),
                candidateDetailTile(title: "Current LPG", value: widget.interviewBean.currentLpg ?? ""),
                candidateDetailTile(title: "Expected LPG", value: widget.interviewBean.expectedLpg ?? ""),
                candidateDetailTile(title: "Notice Period", value: widget.interviewBean.prohibitionPeriod ?? ""),
                candidateDetailTile(title: "Education  ", value: widget.interviewBean.studies ?? ""),
                candidateDetailTile(title: "Tech.Skills", value: widget.interviewBean.skills ?? ""),

                widget.interviewBean.status == "In-Review" || widget.interviewBean.teamLeadStatus == "In-Review"
                    ? Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          !widget.isHrRole! && widget.interviewBean.practicalReview ==null ?  textFieldWidget(
                              controller: _practicalReview,
                              title: "Practical Review",
                              hintText: "Enter Practical Review",
                              keyboardType: TextInputType.text,
                              height: 50,
                              width: MediaQuery.of(context).size.width):Container(),
                         !widget.isHrRole! && widget.interviewBean.technicalReview ==null ?  textFieldWidget(
                              controller: _technicalReviewController,
                              title: "Technical Review",
                              hintText: "Enter Technical Review",
                              keyboardType: TextInputType.text,
                              height: 50,
                              width: MediaQuery.of(context).size.width):Container(),
                         widget.isHrRole==true && widget.interviewBean.hrReview ==null?
                         textFieldWidget(
                              controller: _hrReviewController,
                              title: "Hr Review",
                              hintText: "Enter Hr Review",
                              keyboardType: TextInputType.text,
                              height: 20,
                              width: MediaQuery.of(context).size.width):Container(),
                          const SizedBox(height: 20),
                          (widget.isHrRole! && widget.interviewBean.hrReview==null) ||
                              (!widget.isHrRole! && widget.interviewBean.practicalReview ==null)?
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
                                        if (widget.isHrRole ==true? hrValidateForm(context: context):teamLeadValidateForm(context: context)) {
                                         widget.isHrRole ==true? _updateHrInterviewData():_updateTeamLeadInterviewData();
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
                                        if (widget.isHrRole ==true? hrValidateForm(context: context):teamLeadValidateForm(context: context)) {
                                          widget.isHrRole ==true? _updateHrInterviewData():_updateTeamLeadInterviewData();
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Candidate Profile is Updated')));
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please Enter Required Details')));
                                        }
                                      }),
                                ),
                              ],
                            ),
                          ) :Container(),
                        ],
                      )
                    : Column(
                        children: [
                          candidateDetailTile(title: "Technical Review", value: widget.interviewBean.technicalReview ?? ""),
                          candidateDetailTile(title: "Practical Review", value: widget.interviewBean.practicalReview ?? ""),
                          candidateDetailTile(title: "HR Review", value: widget.interviewBean.hrReview ?? ""),
                          candidateDetailTile(title: "Hr Status", value: widget.interviewBean.status ?? ""),
                          candidateDetailTile(title: "TeamLead status", value: widget.interviewBean.teamLeadStatus ?? ""),
                        ],
                      ),
              ],
            ),
          ),
        ));
  }

  void _updateHrInterviewData() {
    String? status = widget.isHrRole ==true ?isApproved == true ? "Approved" : "Rejected":"In-Review";
    String? hrReview = widget.interviewBean.hrReview == null ?_hrReviewController.text: widget.interviewBean.hrReview;

    Map<String, String> interview = {'status': status, 'hrReview': hrReview!};

    _interviewRef!
        .child(widget.commonKey)
        .update(interview)
        .then((value) => navigateToInterviewListPage(context));
    setState(() {});
    print("widget.commonKey${widget.commonKey}");
    print("interview222${interview}");
  }

  void _updateTeamLeadInterviewData() {
    String? teamLeadStatus = widget.isHrRole ==false ? isApproved == true ? "Approved" : "Rejected":"In-Review";
    String? technicalReview = widget.interviewBean.technicalReview ==null?_technicalReviewController.text:widget.interviewBean.technicalReview;
    String? practicalReview =  widget.interviewBean.practicalReview ==null ?_practicalReview.text:widget.interviewBean.practicalReview;

    Map<String, String> interview = {'technicalReview': technicalReview!, 'practicalReview':practicalReview!,'teamLeadStatus':teamLeadStatus};

    _interviewRef!
        .child(widget.commonKey)
        .update(interview)
        .then((value) => navigateToInterviewListPage(context));
    setState(() {});
    print("widget.commonKey${widget.commonKey}");
    print("interview222${interview}");
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
            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.indigo.withOpacity(0.7), fontWeight: FontWeight.w700, fontSize: 15),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: MediaQuery.of(context).size.width - 130,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }

  Widget textFieldWidget({
      TextEditingController? controller,
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
                  maxLines: 3,
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

  bool hrValidateForm({required BuildContext context}) {
    if (_hrReviewController.text.toString() == "") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Enter Hr-Review")));
      return false;
    } else {
      return true;
    }
  }

  bool teamLeadValidateForm({required BuildContext context}) {
    if (_practicalReview.text.toString() == "") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Enter Practical-Review")));
      return false;
    } if (_technicalReviewController.text.toString() == "") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Enter Technical-Review")));
      return false;
    } else {
      return true;
    }
  }

}

void navigateToInterviewListPage(BuildContext? context) {
  Navigator.push(context!, MaterialPageRoute(builder: (context) => const InterViewerCandidatePage()));
}
