import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interviewapp/InterviewJson.dart';
import 'package:interviewapp/SiginSignUp/loginPage.dart';
import 'package:interviewapp/createPersonScreen.dart';
import 'package:interviewapp/database.dart';
import 'package:interviewapp/hrReviewScreen.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<InterviewBean> interviewList = [];
  ScrollController? _scrollController;
  final interviewDao = InterviewDao();
  Color color1 = HexColor("#ADD8E6");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: const Icon(Icons.menu),
        automaticallyImplyLeading: false,
        actions:  [
          Center(child: Padding(
            padding: const EdgeInsets.fromLTRB(0,3,10,3),
            child: InkWell(
              onTap: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: Text("Logout",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white.withOpacity(0.7),
                      fontWeight: FontWeight.w700,fontSize: 13),),
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
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>
            CreateCandidateScreen()));
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
          String? interviewKey =snapshot.key;
          return InkWell(
            onTap: (){
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) =>
                  HrReviewScree(interviewBean: message,
                  commonKey: interviewKey!)));
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 3,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent,width: 1.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 3),
                         Text(message.name ??"", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17,)),
                        const SizedBox(height: 9),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            detailsWidget(
                              title: "Age",
                              value: message.age ??""
                            ),
                            detailsWidget(
                                title: "Gender",
                                value: message.gender ??""
                            ),
                            detailsWidget(
                                title: "status",
                                value: message.status ??"In-Review",
                                color: message.status =="Approved"?Colors.green:message.status =="Rejected"?Colors.red:Colors.orangeAccent

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
            ),
          );
        },
      ),
    );
  }

  Widget detailsWidget({String? title,String? value, Color?color}){
    return Row(
      children: [
        Text(
          "${title}"+" "+":",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.blue.withOpacity(0.7),
              fontWeight: FontWeight.w600,fontSize: 15),
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(width: 8),
        Text(
          value!,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(color:color ?? Colors.black.withOpacity(0.7),
              fontWeight: FontWeight.w500),
          textAlign: TextAlign.start,
          overflow: TextOverflow.clip,
        ),
      ],
    );
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
