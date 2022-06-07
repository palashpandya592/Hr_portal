import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interviewapp/SiginSignUp/logInPage.dart';
import 'package:interviewapp/candidateCreatePage.dart';
import 'package:interviewapp/candidateReviewPage.dart';
import 'package:interviewapp/interviewScreen/interviewBloc/interview_bloc.dart';
import 'package:interviewapp/interviewScreen/interviewBloc/interview_state.dart';
import 'package:interviewapp/interviewScreen/reviewerDropDown.dart';
import 'package:interviewapp/model.dart';
import 'package:interviewapp/repository/databaseRepository.dart';

import 'interviewBloc/interview_event.dart';

class InterViewerCandidatePage extends StatefulWidget {
  const InterViewerCandidatePage({Key? key}) : super(key: key);

  @override
  _InterViewerCandidatePageState createState() => _InterViewerCandidatePageState();
}

class _InterViewerCandidatePageState extends State<InterViewerCandidatePage> {
  InterviewBean? interviewList;
  TextEditingController searchcontroller = new TextEditingController();
  DatabaseReference? itemRef;
  String? filter;
  ScrollController? _scrollController;

  InterviewBloc? _interviewBloc;
  var snapshot;
  List<InterviewBean> searchResult = <InterviewBean>[];

  final interviewDao = InterviewDao();

  String dropdownValue = 'Hr';

  Color color1 = HexColor("#ADD8E6");

  List<String> roleItemList = ["Hr", "TeamLead"];

  Map<dynamic, dynamic>? exist;

  @override
  void initState() {
    setState(() {
      filter = searchcontroller.text;
    });
    const Center(child: CircularProgressIndicator());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
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
        title: const Text("InterviewList Screen"),
      ),
      body: BlocProvider(
        create: (context) => InterviewBloc(InterviewLoading())..add(GetInterviewList()),
        child: Builder(builder: (BuildContext context) {
          _interviewBloc = BlocProvider.of<InterviewBloc>(context);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.center,
              child: BlocBuilder<InterviewBloc, InterviewState>(builder: (context, state) {
                if (state is InterviewLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is InterViewSuccess) {
                  exist = state.data;
                  return getInterviewList();
                } else if (state is InterViewFailure) {
                  return Text(state.error ?? "Something Went Wrong");
                } else {
                  return Container();
                }
              }),
            ),
          );
        }),
      ),
      floatingActionButton: floatingButton(),
    );
  }

  Widget circularWidget(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  Widget? floatingButton() {
    return SizedBox(
      height: 45,
      width: 50,
      child: FloatingActionButton(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
        backgroundColor: Colors.indigo,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 25,
        ),
        onPressed: () {
          navigateToCreateCandidatePage(context);
        },
      ),
    );
  }

  Widget getInterviewList() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 10, right: 10, bottom: 10),
          child: Container(
            width: 390,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 1),
                  child: SizedBox(
                      width: 35,
                      child: Icon(
                        Icons.search,
                        size: 20,
                        color: Colors.grey,
                      )),
                ),
                SizedBox(
                  width: 285,
                  child: TextField(
                    controller: searchcontroller,
                    decoration: InputDecoration(
                        hintText: "Search By Name...",
                        hintStyle: Theme.of(context).textTheme.caption!.copyWith(color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 1)),
                    onChanged: onSearchTextChanged,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: FirebaseAnimatedList(
            controller: _scrollController,
            query: interviewDao.getInterviewQuery(),
            itemBuilder: (context, snapshot, animation, index) {
              final json = snapshot.value as Map<dynamic, dynamic>;
              final message = InterviewBean.fromJson(json);
              String? interviewKey = snapshot.key;
              return message == null
                  ? Center(child: const Text('No data Available'))
                  : ((searchResult.length != 0 || searchcontroller.text.isNotEmpty) && searchcontroller.text != '')
                      ? searchResult.length == 0
                          ? Center(child: const Text('No data Available'))
                          : Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 3,
                                child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.indigoAccent, width: 1.2),
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
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              CandidateReviewPage(interviewBean: message, commonKey: interviewKey!)));
                                                },
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Review",
                                                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                          color: Colors.indigoAccent.withOpacity(0.9), fontWeight: FontWeight.w600, fontSize: 13),
                                                    ),
                                                    Container(
                                                      width: 38,
                                                      height: 1,
                                                      color: Colors.indigoAccent,
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
                            )
                      : Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 3,
                            child: Container(
                              height: 110,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
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
                                            onTap: () {
                                           message.status =="In-Review" || message.teamLeadStatus =="In-Review"?
                                           showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return StatefulBuilder(builder: (context, setState) {
                                                    return AlertDialog(
                                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(35))),
                                                      title: Center(
                                                          child: const Text(
                                                        "Select Role",
                                                        style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.w600),
                                                      )),
                                                      content: Padding(
                                                        padding: EdgeInsets.fromLTRB(15, 0, 6, 0),
                                                        child: Container(
                                                          width: 300,
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey)),
                                                          child: Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: FormField<dynamic>(
                                                                  builder: (FormFieldState<dynamic> states) {
                                                                    return InputDecorator(
                                                                      decoration: InputDecoration(
                                                                          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                                                                          contentPadding: EdgeInsets.only(left: 10),
                                                                          border: InputBorder.none),
                                                                      child: DropdownButtonHideUnderline(
                                                                          child: DropdownButton<String>(
                                                                        value: dropdownValue,
                                                                        icon: Icon(
                                                                          Icons.keyboard_arrow_down,
                                                                          color: Colors.indigo,
                                                                        ),
                                                                        iconSize: 30,
                                                                        isExpanded: true,
                                                                        onChanged: (String? newValue) {
                                                                          setState(() {
                                                                            dropdownValue = newValue!;
                                                                          });
                                                                          print("dropdownValue${dropdownValue}");
                                                                        },
                                                                        items: roleItemList.map<DropdownMenuItem<String>>((String value) {
                                                                          return DropdownMenuItem<String>(
                                                                            value: value,
                                                                            child: Text(value),
                                                                          );
                                                                        }).toList(),
                                                                        hint: Text("select"),
                                                                      )),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(right: 10.0, left: 0.0),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      actions: <Widget>[
                                                        Center(
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              FlatButton(
                                                                shape:
                                                                    const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                color: Colors.grey,
                                                                textColor: Colors.white,
                                                                child: const Text('Cancel'),
                                                                onPressed: () {
                                                                  Navigator.pop(context);
                                                                },
                                                              ),
                                                              SizedBox(width: 10),
                                                              FlatButton(
                                                                shape:
                                                                    const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                color: Colors.indigo,
                                                                textColor: Colors.white,
                                                                child: const Text('Done'),
                                                                onPressed: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => CandidateReviewPage(
                                                                                interviewBean: message,
                                                                                commonKey: interviewKey!,
                                                                                isHrRole: dropdownValue == "Hr" ? true : false,
                                                                              ))).then((value) => Navigator.pop(context));
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  });
                                                },
                                              ):  Navigator.push(
                                               context,
                                               MaterialPageRoute(
                                                   builder: (context) => CandidateReviewPage(
                                                     interviewBean: message,
                                                     commonKey: interviewKey!,
                                                     isHrRole:false,
                                                   )));
                                            },
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Review",
                                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                      color: Colors.indigoAccent.withOpacity(0.9), fontWeight: FontWeight.w600, fontSize: 13),
                                                ),
                                                Container(
                                                  width: 38,
                                                  height: 1,
                                                  color: Colors.indigoAccent,
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                    const SizedBox(height: 9),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            detailsWidget(title: "Age", value: message.age ?? ""),
                                            detailsWidget(title: "Gender", value: message.gender ?? ""),
                                            detailsWidget(title: "Dep.", value: message.department ?? ""),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            detailsWidget(
                                                title: " Hr status",
                                                value: message.status ?? "In-Review",
                                                color: message.status == "Approved"
                                                    ? Colors.green
                                                    : message.status == "Rejected"
                                                        ? Colors.red
                                                        : Colors.orangeAccent),
                                            detailsWidget(
                                                title: "TL status",
                                                value:  message.teamLeadStatus ?? "In-Review",
                                                color: message.teamLeadStatus == "Approved"
                                                    ? Colors.green
                                                    : message.teamLeadStatus == "Rejected"
                                                    ? Colors.red
                                                    : Colors.orangeAccent)
                                          ],
                                        ),
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
        ),
      ],
    );
  }

  onSearchTextChanged(String text) async {
    searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    setState(() {
      interviewList!.name!.contains(text.trim()) || interviewList!.name!.contains(text.toLowerCase());
      searchResult.add(interviewList!);
      print("searchResult${searchResult.length}");
    });
    /*((userDetail) {
      if (userDetail.name!.contains(text.trim()) ||
          userDetail.name!.toLowerCase().contains(text.toLowerCase()) ||
          userDetail.name!.toLowerCase().contains(text.toLowerCase()) ||
          userDetail.name!.contains(text) ||
          userDetail.name!.contains(text)) searchResult.add(userDetail);
    });*/

    setState(() {});
  }

  Widget detailsWidget({String? title, String? value, Color? color}) {
    return Row(
      children: [
        Text(
          "$title" " " ":",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey.withOpacity(0.9), fontWeight: FontWeight.w600, fontSize: 15),
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
