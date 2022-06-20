import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:interviewapp/interviewScreen/interviewCandidateListPage.dart';
import 'package:interviewapp/model.dart';
import 'package:url_launcher/url_launcher.dart';

class CandidateReviewPage extends StatefulWidget {
  InterviewBean interviewBean;
  String commonKey;
  bool? isHrRole;

  CandidateReviewPage(
      {required this.interviewBean,
      required this.commonKey,
      Key? key,
      this.isHrRole})
      : super(key: key);

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
  String? hrRatings;
  String? teamLeadsRating;

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
                candidateDetailTile(
                    title: "Name", value: widget.interviewBean.name ?? ""),
                candidateDetailTile(
                    title: "Age", value: widget.interviewBean.age ?? ""),
                candidateDetailTile(
                    title: "DOB", value: widget.interviewBean.dob ?? ""),
                candidateDetailTile(
                    title: "Gender", value: widget.interviewBean.gender ?? ""),
                emailTile(
                    title: "email", value: widget.interviewBean.email ?? ""),
                mobileNumberTile(
                    title: "Contact Number",
                    value: widget.interviewBean.mobileNum ?? ""),
                candidateDetailTile(
                    title: "Department",
                    value: widget.interviewBean.department ?? ""),
                candidateDetailTile(
                    title: "Work Option",
                    value: widget.interviewBean.workPlaceOption ?? "-"),
                candidateDetailTile(
                    title: "Current LPG",
                    value: widget.interviewBean.currentLpg ?? ""),
                candidateDetailTile(
                    title: "Expected LPG",
                    value: widget.interviewBean.expectedLpg ?? ""),
                candidateDetailTile(
                    title: "Notice Period",
                    value: widget.interviewBean.prohibitionPeriod ?? ""),
                candidateDetailTile(
                    title: "Education  ",
                    value: widget.interviewBean.studies ?? ""),
                candidateDetailTile(
                    title: "Tech.Skills",
                    value: widget.interviewBean.skills ?? ""),
                widget.interviewBean.status == "In-Review" ||
                        widget.interviewBean.teamLeadStatus == "In-Review"
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          !widget.isHrRole! &&
                                  widget.interviewBean.practicalReview == null
                              ? textFieldWidget(
                                  controller: _practicalReview,
                                  title: "Practical Review",
                                  hintText: "Enter Practical Review",
                                  keyboardType: TextInputType.text,
                                  height: 50,
                                  width: MediaQuery.of(context).size.width)
                              : Container(),
                          !widget.isHrRole! &&
                                  widget.interviewBean.technicalReview == null
                              ? textFieldWidget(
                                  controller: _technicalReviewController,
                                  title: "Technical Review",
                                  hintText: "Enter Technical Review",
                                  keyboardType: TextInputType.text,
                                  height: 50,
                                  width: MediaQuery.of(context).size.width)
                              : Container(),
                          !widget.isHrRole! &&
                                  widget.interviewBean.practicalReview == null
                              ? ratingBarWidget()
                              : Container(),
                          widget.isHrRole == true &&
                                  widget.interviewBean.hrReview == null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    textFieldWidget(
                                        controller: _hrReviewController,
                                        title: "Hr Review",
                                        hintText: "Enter Hr Review",
                                        keyboardType: TextInputType.text,
                                        height: 20,
                                        width:
                                            MediaQuery.of(context).size.width),
                                    ratingBarWidget(),
                                  ],
                                )
                              : Column(
                                  children: [
                                    candidateDetailTile(
                                        title: "HR Review",
                                        value: widget.interviewBean.hrReview ??
                                            ""),
                                    candidateDetailTile(
                                        title: "Hr-Rating",
                                        value: widget.interviewBean.hrRating ??
                                            ""),
                                  ],
                                ),
                          const SizedBox(height: 20),
                          (widget.isHrRole! &&
                                      widget.interviewBean.hrReview == null) ||
                                  (!widget.isHrRole! &&
                                      widget.interviewBean.practicalReview ==
                                          null)
                              ? Padding(
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
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: Wrap(
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              alignment: WrapAlignment.center,
                                              children: const [
                                                Text("Approve",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                            onPressed: () async {
                                              setState(() {
                                                isApproved = true;
                                              });
                                              if (widget.isHrRole == true
                                                  ? hrValidateForm(
                                                      context: context)
                                                  : teamLeadValidateForm(
                                                      context: context)) {
                                                widget.isHrRole == true
                                                    ? _updateHrInterviewData()
                                                    : _updateTeamLeadInterviewData();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            'Candidate Profile is Updated')));
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            'Please Enter Required Details')));
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
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: Wrap(
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              alignment: WrapAlignment.center,
                                              children: const [
                                                Text("Reject",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ],
                                            ),
                                            onPressed: () async {
                                              setState(() {
                                                isApproved = false;
                                              });
                                              if (widget.isHrRole == true
                                                  ? hrValidateForm(
                                                      context: context)
                                                  : teamLeadValidateForm(
                                                      context: context)) {
                                                widget.isHrRole == true
                                                    ? _updateHrInterviewData()
                                                    : _updateTeamLeadInterviewData();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            'Candidate Profile is Updated')));
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            'Please Enter Required Details')));
                                              }
                                            }),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                        ],
                      )
                    : Column(
                        children: [
                          candidateDetailTile(
                              title: "Technical Review",
                              value:
                                  widget.interviewBean.technicalReview ?? ""),
                          candidateDetailTile(
                              title: "Practical Review",
                              value:
                                  widget.interviewBean.practicalReview ?? ""),
                          candidateDetailTile(
                              title: "Hr-Review",
                              value: widget.interviewBean.hrReview ?? ""),
                          candidateDetailTile(
                              title: "TeamLead Status",
                              value: widget.interviewBean.teamLeadStatus ?? ""),
                          candidateDetailTile(
                              title: "Hr-Status",
                              value: widget.interviewBean.status ?? ""),
                          candidateDetailTile(
                              title: "TeamLead Rating",
                              value: widget.interviewBean.teamLeadRating ?? ""),
                          candidateDetailTile(
                              title: "Hr-Rating",
                              value: widget.interviewBean.hrRating ?? ""),
                        ],
                      ),
              ],
            ),
          ),
        ));
  }

  void _updateHrInterviewData() {
    String? status = widget.isHrRole == true
        ? isApproved == true
            ? "Approved"
            : "Rejected"
        : "In-Review";
    String? hrReview = widget.interviewBean.hrReview == null
        ? _hrReviewController.text
        : widget.interviewBean.hrReview;
    String? hrRating = widget.interviewBean.hrRating == null
        ? hrRatings
        : widget.interviewBean.hrRating;

    Map<String, String> interview = {
      'status': status,
      'hrReview': hrReview!,
      'hrRating': hrRating!
    };

    print("interview${interview}");

    _interviewRef!
        .child(widget.commonKey)
        .update(interview)
        .then((value) => navigateToInterviewListPage(context));
    setState(() {});
    print("widget.commonKey${widget.commonKey}");
    print("interview222${interview}");
  }

  void _updateTeamLeadInterviewData() {
    String? teamLeadStatus = widget.isHrRole == false
        ? isApproved == true
            ? "Approved"
            : "Rejected"
        : "In-Review";
    String? technicalReview = widget.interviewBean.technicalReview == null
        ? _technicalReviewController.text
        : widget.interviewBean.technicalReview;
    String? practicalReview = widget.interviewBean.practicalReview == null
        ? _practicalReview.text
        : widget.interviewBean.practicalReview;
    String? teamLeadRating = widget.interviewBean.teamLeadRating == null
        ? teamLeadsRating
        : widget.interviewBean.teamLeadRating;

    Map<String, String> interview = {
      'technicalReview': technicalReview!,
      'practicalReview': practicalReview!,
      'teamLeadStatus': teamLeadStatus,
      'teamLeadRating': teamLeadRating!
    };

    _interviewRef!
        .child(widget.commonKey)
        .update(interview)
        .then((value) => navigateToInterviewListPage(context));
    setState(() {});
    print("widget.commonKey${widget.commonKey}");
    print("interview222${interview}");
  }

  Widget candidateDetailTile({
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "$title" " " ":",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.indigo.withOpacity(0.7),
                fontWeight: FontWeight.w700,
                fontSize: 15),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: MediaQuery.of(context).size.width - 153,
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

  Widget mobileNumberTile({
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "$title" " " ":",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.indigo.withOpacity(0.7),
                fontWeight: FontWeight.w700,
                fontSize: 15),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: MediaQuery.of(context).size.width - 153,
            child: InkWell(
              onTap: () {
                launchUrl("tel:" + widget.interviewBean.mobileNum!);
              },
              child: Row(
                children: [
                  Text(
                    value,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Color.fromRGBO(72, 164, 216, 1),
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget emailTile({
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "$title" " " ":",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.indigo.withOpacity(0.7),
                fontWeight: FontWeight.w700,
                fontSize: 15),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: MediaQuery.of(context).size.width - 153,
            child: InkWell(
              onTap: () {
                onEmailOpenClicked();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Color.fromRGBO(72, 164, 216, 1),
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                  ),
                  Container(
                    width: 100,
                    height: 0.5,
                    color: Color.fromRGBO(72, 164, 216, 1),
                  ),
                ],
              ),
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
              padding:
                  const EdgeInsets.only(left: 6.0, right: 5.0, bottom: 2.0),
              child: SizedBox(
                width: 280,
                child: Text(
                  title!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w700),
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
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w500),
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
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please Enter Hr-Review")));
      return false;
    }
    if (hrRatings == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please Provide Performance Rating")));
      return false;
    } else {
      return true;
    }
  }

  bool teamLeadValidateForm({required BuildContext context}) {
    if (_practicalReview.text.toString() == "") {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please Enter Practical-Review")));
      return false;
    }
    if (_technicalReviewController.text.toString() == "") {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please Enter Technical-Review")));
      return false;
    }
    if (teamLeadsRating == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please Provide Performance Rating")));
      return false;
    } else {
      return true;
    }
  }

  Widget ratingBarWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Performance Rating",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w700,
                      fontSize: 15),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    widget.isHrRole == true
                        ? (hrRatings ?? "")
                        : (teamLeadsRating ?? ""),
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.indigo.withOpacity(0.7),
                        fontWeight: FontWeight.w800,
                        fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          RatingBar.builder(
            initialRating: 0,
            itemCount: 5,
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return Icon(
                    Icons.sentiment_very_dissatisfied,
                    color: Colors.red,
                  );
                case 1:
                  return Icon(
                    Icons.sentiment_dissatisfied,
                    color: Colors.redAccent,
                  );
                case 2:
                  return Icon(
                    Icons.sentiment_neutral,
                    color: Colors.amber,
                  );
                case 3:
                  return Icon(
                    Icons.sentiment_satisfied,
                    color: Colors.lightGreen,
                  );
                case 4:
                  return Icon(
                    Icons.sentiment_very_satisfied,
                    color: Colors.green,
                  );
              }
              return Icon(
                Icons.sentiment_very_dissatisfied,
                color: Colors.red,
              );
            },
            onRatingUpdate: (rating) {
              setState(() {
                widget.isHrRole == true
                    ? hrRatings = getStatusFromRating(rating)
                    : teamLeadsRating = getStatusFromRating(rating);
              });
              print(hrRatings);
            },
          ),
        ],
      ),
    );
  }

  String? getStatusFromRating(double rating) {
    String? ratings;
    if (rating == 5) {
      ratings = "EXCELLENT";
    } else if (rating == 1) {
      ratings = "BAD";
    } else if (rating == 2) {
      ratings = "POOR";
    } else if (rating == 3) {
      ratings = "GOOD";
    } else if (rating == 4) {
      ratings = "FAIR";
    } else if (rating == 0) {
      ratings = "Not-Provided";
    }
    return ratings;
  }

  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

  static Future<void> sendEmail(
      {required String email, String subject = "", String body = ""}) async {
    String mail = "mailto:$email?subject=$subject&body=${Uri.encodeFull(body)}";
    if (await canLaunch(mail)) {
      await launch(mail);
    } else {
      throw Exception("Unable to open the email");
    }
  }

  void onEmailOpenClicked() async {
    try {
      await sendEmail(
        email: widget.interviewBean.email!,
        subject: "Optional",
      );
    } catch (e) {
      debugPrint("sendEmail failed ${e}");
    }
  }
}

void navigateToInterviewListPage(BuildContext? context) {
  Navigator.push(
      context!,
      MaterialPageRoute(
          builder: (context) => const InterViewerCandidatePage()));
}
