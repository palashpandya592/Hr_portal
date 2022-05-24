import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interviewapp/InterviewJson.dart';
import 'package:interviewapp/createPersonScreen.dart';
import 'package:interviewapp/hrReviewScreen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<InterviewBean> interviewList = [];
  var colors = [
    Colors.limeAccent.withOpacity(0.3),
    Colors.lightBlueAccent.withOpacity(0.6),
    Colors.lightGreenAccent.withOpacity(0.5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("InterViewList Screen"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, position) {
              return InkWell(
                onTap: (){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const HrReviewScree()));
                },
                child: Card(
                  // color: colors[position % colors.length],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 3),
                          const Text("Person Name", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
                          const SizedBox(height: 9),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Age:21", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                              Text("Gender: F", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                              Text("graducation: B.tech ", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
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
            itemCount: interviewList.length),
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
        print("1111111111");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>
            CreateCandidateScreen(interviewList: interviewList,
            onChanged: (interviewList){
              print(interviewList[0].name);
              },)));
      },
    );
  }
}
