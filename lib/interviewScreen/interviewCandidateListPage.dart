import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interviewapp/SiginSignUp/logInPage.dart';
import 'package:interviewapp/candidateCreatePage.dart';
import 'package:interviewapp/candidateReviewPage.dart';
import 'package:interviewapp/model.dart';
import 'package:interviewapp/repository/databaseRepository.dart';

class InterViewerCandidatePage extends StatefulWidget {
  const InterViewerCandidatePage({Key? key}) : super(key: key);

  @override
  _InterViewerCandidatePageState createState() => _InterViewerCandidatePageState();
}

class _InterViewerCandidatePageState extends State<InterViewerCandidatePage> {
  List<InterviewBean> interviewList = [];

  ScrollController? _scrollController;

  final interviewDao = InterviewDao();

  Color color1 = HexColor("#ADD8E6");

  @override
  void initState() {
     const Center(child: CircularProgressIndicator());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: const Icon(Icons.menu),
        automaticallyImplyLeading: false,
        actions: [
          Center(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 3, 10, 3),
            child: InkWell(
              onTap: () {
                navigateToLogInPage(context);
              },
              child: Text(
                "Logout",
                style:
                    Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white.withOpacity(0.7), fontWeight: FontWeight.w700, fontSize: 13),
              ),
            ),
          )),
        ],
        title: const Text("InterViewList Screen"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: _getInterviewList(),
      ),
      floatingActionButton: floatingButton(),
    );
  }

  Widget? floatingButton() {
    return FloatingActionButton(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      backgroundColor: Colors.blue,
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 25,
      ),
      onPressed: () {
        navigateToCreateCandidatePage(context);
      },
    );
  }

  Widget _getInterviewList() {
    return Expanded(
      child: FirebaseAnimatedList(
        controller: _scrollController,
        query: interviewDao.getInterviewQuery(),
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          final message = InterviewBean.fromJson(json);
          String? interviewKey = snapshot.key;
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 3,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 1.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(message.name ?? "",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                              )),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                  candidateReviewPage(interviewBean: message, commonKey: interviewKey!)));
                            },
                              child: Column(
                                children: [
                                  Text("Review",
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                        color: Colors.blueAccent.withOpacity(0.9), fontWeight: FontWeight.w600, fontSize: 13),
                                  ),
                                  Container(
                                    width: 38,
                                    height: 1,
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              )),
                        ],
                      ),
                      const SizedBox(height: 9),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          detailsWidget(title: "Age", value: message.age ?? ""),
                          detailsWidget(title: "Gender", value: message.gender ?? ""),
                          detailsWidget(
                              title: "status",
                              value: message.status ?? "In-Review",
                              color: message.status == "Approved"
                                  ? Colors.green
                                  : message.status == "Rejected"
                                      ? Colors.red
                                      : Colors.orangeAccent),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget detailsWidget({String? title, String? value, Color? color}) {
    return Row(
      children: [
        Text(
          "$title" " " ":",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.grey.withOpacity(0.9), fontWeight: FontWeight.w600, fontSize: 15),
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(width: 8),
        Text(
          value!,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(color: color ?? Colors.black.withOpacity(0.7), fontWeight: FontWeight.w500),
          textAlign: TextAlign.start,
          overflow: TextOverflow.clip,
        ),
      ],
    );
  }

  void navigateToCreateCandidatePage(BuildContext? context) {
    Navigator.push(context!, MaterialPageRoute(builder: (context) => const CreateCandidateScreen()));
  }

  void navigateToLogInPage(BuildContext? context) {
    Navigator.push(context!, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
