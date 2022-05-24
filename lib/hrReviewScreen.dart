
import 'package:flutter/material.dart';

class HrReviewScree extends StatefulWidget {
  const HrReviewScree({Key? key}) : super(key: key);

  @override
  _HrReviewScreeState createState() => _HrReviewScreeState();
}

class _HrReviewScreeState extends State<HrReviewScree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HR-Interview Review Screen"),
      ),
      body: Padding(
      padding: const EdgeInsets.only(left: 7),
      child: Column(
        children: [
          candidateDetailTile(title: "Name",value: "Pranitha Sandupatla"),
          candidateDetailTile(title: "Age",value: "23"),
          candidateDetailTile(title: "DOB",value: "20-7-1999"),
          candidateDetailTile(title: "Gender",value: "Female"),
          candidateDetailTile(title: "email",value: "Pranitha@gmail.com"),
          candidateDetailTile(title: "Contact Number",value: "9982472356"),
          candidateDetailTile(title: "Work Option",value: "Work From Home(WFH)"),
          candidateDetailTile(title: "Current LPG",value: "2.5L"),
          candidateDetailTile(title: "Expected LPG",value: "4.5L"),
          candidateDetailTile(title: "Notice Period",value: "15 Days"),
          candidateDetailTile(title: "Education  ",value: "B.tech(Teegala KrishnaReddy College of Pharmacy"),
          candidateDetailTile(title: "Tech.Skills",value: "Java,Flutter,Dart,swagger,postman,jira,github,Blocs,RiverPod ,Firebase"),
          textFieldWidget(
              title: "Interview feedback",
              hintText: "Enter Interview feedback",
              keyboardType: TextInputType.text,
              height: 65,
              width: MediaQuery.of(context).size.width),
          textFieldWidget(
              title: "Hr Review",
              hintText: "Enter Hr Review",
              keyboardType: TextInputType.text,
              height: 55,
              width: MediaQuery.of(context).size.width),
          const SizedBox(height: 20),
          Row(
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
                    }),
              ),
              const SizedBox(width: 20,),
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
                    }),
              ),
            ],
          ),
        ],
      ),
      )
    );
  }

  Widget candidateDetailTile({required String title,required String value}){
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "${title}"+" "+":",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.blue.withOpacity(0.7),
                fontWeight: FontWeight.w700,fontSize: 15),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: MediaQuery.of(context).size.width -130,
            child:  Text(
              value,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.w500),
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
      child: Container(
        width: width ?? 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6.0, right: 5.0, bottom: 2.0),
              child: Container(
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
              padding: EdgeInsets.fromLTRB(2, 0.0, 2, 0.0),
              child: Container(
                width: width ?? 100,
                height: height ?? 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey.withOpacity(0.6)),
                ),
                child: TextField(
                  maxLines: 100,
                  controller: controller,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.grey.withOpacity(0.7),
                    ),
                    contentPadding: EdgeInsets.only(left: 10, bottom: 10),
                    border: InputBorder.none,
                  ),
                  onChanged: (val) {
                    print(controller!.text.toString());
                    setState(() {});
                  },
                  keyboardType: keyboardType,
                  textInputAction: TextInputAction.next,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
