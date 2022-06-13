import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interviewapp/SiginSignUp/logInPage.dart';
import 'package:interviewapp/candidateCreatePage.dart';
import 'package:interviewapp/candidateReviewPage.dart';
import 'package:interviewapp/interviewScreen/interviewBloc/interview_bloc.dart';
import 'package:interviewapp/interviewScreen/interviewBloc/interview_state.dart';
import 'package:interviewapp/model.dart';
import 'package:interviewapp/repository/databaseRepository.dart';

import 'interviewBloc/interview_event.dart';

class InterViewerCandidatePage extends StatefulWidget {
  const InterViewerCandidatePage({Key? key}) : super(key: key);

  @override
  _InterViewerCandidatePageState createState() => _InterViewerCandidatePageState();
}

class _InterViewerCandidatePageState extends State<InterViewerCandidatePage> {
  List<InterviewBean>? list;
  TextEditingController searchController = TextEditingController();
  DatabaseReference? itemRef;
  List<String>? interviewKey;
  List<InterviewBean> searchResult = [];
  List<InterviewBean> interviewList = [];
  InterviewBloc? _interviewBloc;
  final interviewDao = InterviewDao();
  String dropdownValue = 'Hr';
  List<String> roleItemList = ["Hr", "TeamLead"];
  Map<dynamic, dynamic>? exist;
  bool? isLoading = false;
  int? selectedIndex;

  @override
  void initState() {
    getDataFromFirebaseMethod(interviewKey);
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
                _showDialog();
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
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: BlocProvider(
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
      ),
      floatingActionButton: floatingButton(),
    );
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
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(left: 8, top: 10, right: 1, bottom: 10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Container(
                width: 270,
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
                      width: 200,
                      child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              hintText: "Search By Name...",
                              hintStyle: Theme.of(context).textTheme.caption!.copyWith(color: Colors.grey),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(bottom: 1)),
                          onChanged: onSearchTextChanged),
                    ),
                  ],
                ),
              ),
            ),
            xActionInfo(context),
          ],
        ),
      ),
      isLoading == true
          ? loadingWidget()
          : Expanded(
              child: interviewList.isEmpty && interviewList == null
                  ? noDataWidget()
                  : searchController.text.isEmpty || searchController.text == null
                      ? ListView.builder(
                          itemCount: interviewList.length,
                          itemBuilder: (BuildContext context, int index) {
                            print("heeloooo${interviewList[index].toJson()}");
                            return interviewListTile(bean: interviewList[index]);
                          })
                      : searchResult.isEmpty && searchResult.length == 0
                          ? noDataWidget()
                          : ListView.builder(
                              itemCount: searchResult.length,
                              itemBuilder: (BuildContext context, int index) {
                                return searchResult.isEmpty ? const Text('No data') : interviewListTile(bean: searchResult[index]);
                              }),
            ),

    ]);
  }

  Widget interviewListTile({required InterviewBean bean}) {
    return Padding(
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
                    Text(bean.name ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        )),
                    InkWell(
                        onTap: () {
                          bean.status == "In-Review" || bean.teamLeadStatus == "In-Review"
                              ? showDialog(
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
                                            decoration:
                                                BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey)),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Expanded(
                                                  child: FormField<dynamic>(
                                                    builder: (FormFieldState<dynamic> states) {
                                                      return InputDecorator(
                                                        decoration: const InputDecoration(
                                                            errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                                                            contentPadding: EdgeInsets.only(left: 10),
                                                            border: InputBorder.none),
                                                        child: DropdownButtonHideUnderline(
                                                            child: DropdownButton<String>(
                                                          value: dropdownValue,
                                                          icon: const Icon(
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
                                                const Padding(
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
                                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                  color: Colors.grey,
                                                  textColor: Colors.white,
                                                  child: const Text('Cancel'),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                SizedBox(width: 10),
                                                FlatButton(
                                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                  color: Colors.indigo,
                                                  textColor: Colors.white,
                                                  child: const Text('Done'),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => CandidateReviewPage(
                                                                  interviewBean: bean,
                                                                  commonKey: bean.key ??"",
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
                                )
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CandidateReviewPage(
                                            interviewBean: bean,
                                            commonKey: bean.key ??"",
                                            isHrRole: false,
                                          )));
                        },
                        child: Column(
                          children: [
                            Text(
                              "Review",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.indigoAccent.withOpacity(0.9), fontWeight: FontWeight.w600, fontSize: 13),
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
                        detailsWidget(title: "Age", value: bean.age ?? ""),
                        detailsWidget(title: "Gender", value: bean.gender ?? ""),
                        detailsWidget(title: "Dep.", value: bean.department ?? ""),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        detailsWidget(
                            title: " Hr status",
                            value: bean.status ?? "In-Review",
                            color: bean.status == "Approved"
                                ? Colors.green
                                : bean.status == "Rejected"
                                    ? Colors.red
                                    : Colors.orangeAccent),
                        detailsWidget(
                            title: "TL status",
                            value: bean.teamLeadStatus ?? "In-Review",
                            color: bean.teamLeadStatus == "Approved"
                                ? Colors.green
                                : bean.teamLeadStatus == "Rejected"
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
  }

  Widget noDataWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 80,
          ),
          Container(
              constraints: BoxConstraints.expand(height: 200.0),
              decoration: BoxDecoration(color: Colors.white),
              child: Image.asset(
                "assets/images/no_data.jpg",
                fit: BoxFit.cover,
              )),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "No Data Available",
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.indigo, fontSize: 20),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget loadingWidget() {
    return const Padding(
      padding: EdgeInsets.only(top: 150),
      child: CircularProgressIndicator(),
    );
  }

  Widget xActionInfo(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: PopupMenuButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Colors.white,
            child: Icon(Icons.sort, size: 28),
            itemBuilder: (_) => <PopupMenuItem<String>>[
                  const PopupMenuItem<String>(
                    child: Text("Sort by Department"),
                    value: "SORT_BY_NAME",
                  ),
                  const PopupMenuItem<String>(
                    child: Text("Sort by Status"),
                    value: "SORT_BY_STATUS",
                  ),
                ],
            onSelected: (String index) {
              if (index == "SORT_BY_NAME") {
                CircularProgressIndicator();
                interviewList.sort((a, b) => a.department!.compareTo(b.department!));
                setState(() {});
              } else {
                interviewList.sort((b, a) => a.teamLeadStatus!.compareTo(b.teamLeadStatus!));
                setState(() {});
              }
            }),
      ),
    );
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

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
          title: Center(child: const Text("Logout", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: Colors.indigo),)),
          content: const Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 6, 0),
            child: Text("Would to Like to Logout ?", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
          ),
          actions: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    color: Colors.grey,
                    textColor: Colors.white,
                    child: const Text('No'),
                    onPressed: () {
                     Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 10),
                  FlatButton(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    color: Colors.indigo,
                    textColor: Colors.white,
                    child: const Text('Yes'),
                    onPressed: () {
                      navigateToLogInPage(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void navigateToCreateCandidatePage(BuildContext? context) {
    Navigator.push(context!, MaterialPageRoute(builder: (context) => const CreateCandidateScreen()));
  }

  void navigateToLogInPage(BuildContext? context) {
    Navigator.push(context!, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  void getDataFromFirebaseMethod(List<String>? interviewKey) {
    isLoading = true;
    DatabaseReference _interviewRef = FirebaseDatabase.instance.reference().child("interview");
    _interviewRef.once().then((DataSnapshot dataSnapshot) {
    String newkey = _interviewRef.push().key;
      searchResult.clear();
      interviewList.clear();
      var refKeys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;

      for (var key in refKeys) {
        InterviewBean data = InterviewBean(
          email: values[key]['email'],
          name: values[key]['name'],
          prohibitionPeriod: values[key]['prohibitionPeriod'],
          skills: values[key]['skills'],
          studies: values[key]['studies'],
          gender: values[key]['gender'],
          status: values[key]['status'],
          age: values[key]['age'],
          teamLeadStatus: values[key]['teamLeadStatus'],
          currentLpg: values[key]['currentLpg'],
          expectedLpg: values[key]['expectedLpg'],
          department: values[key]['department'],
          dob: values[key]['dob'],
          experience: values[key]['experience'],
          hrReview: values[key]['hrReview'],
          mobileNum: values[key]['mobileNum'],
          practicalReview: values[key]['practicalReview'],
          technicalReview: values[key]['technicalReview'],
          workPlaceOption: values[key]['workPlaceOption'],
          key: values[key]['key']
        );
        if (data != null) {
          setState(() {
            isLoading = false;
            interviewList.add(data);

            print("333${ dataSnapshot.value.keys}");
            print(newkey);
          });
        }
      }
    });
  }

  onSearchTextChanged(String text) async {
    isLoading == true;
    searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    interviewList.forEach((userDetail) {
      if (userDetail.name!.contains(text.trim()) ||
          userDetail.name!.toLowerCase().contains(text.toLowerCase()) || userDetail.name!.contains(text))
        searchResult.add(userDetail);
    });

    setState(() {});
  }

  }
