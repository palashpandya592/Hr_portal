
import 'package:flutter/material.dart';

class CreateCandidateScreen extends StatefulWidget {
  const CreateCandidateScreen({Key? key}) : super(key: key);

  @override
  _CreateCandidateScreenState createState() => _CreateCandidateScreenState();
}

class _CreateCandidateScreenState extends State<CreateCandidateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Screen"),
      ),
      body: Column(
        children: [
          Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Candidate Details',style:
            Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.blue.withOpacity(0.7), fontWeight: FontWeight.w600),),
          )),
          textFieldWidget(
              title: "Candidate Name",
              hintText: "Enter Candidate Name",
              keyboardType: TextInputType.number,
              width: 300),
          textFieldWidget(
              title: "Age",
              hintText: "enter Age",
              keyboardType: TextInputType.number,
              width: 300),
          textFieldWidget(
              title: "Date of Birth",
              hintText: "Enter Date of Birth",
              keyboardType: TextInputType.number,
              width: 300),
          textFieldWidget(
              title: "Education",
              hintText: "Enter Education Details",
              keyboardType: TextInputType.number,
              width: 300),
          textFieldWidget(
              title: "Experience",
              hintText: "Enter Experience Details",
              keyboardType: TextInputType.number,
              width: 300),
        ],
      ),
    );
  }
  Widget textFieldWidget(
      {TextEditingController? controller,
        TextInputType? keyboardType, String? hintText, double? width, String? title,
        String? imageUrl,bool? isMandatory =false}) {
    return Padding(
      padding:const EdgeInsets.all( 5),
      child: Container(
        width: width ?? 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 5.0, bottom: 2.0),
              child: Container(
                width:280,
                child: Text(title!,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w600),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.fromLTRB(2, 0.0, 2, 0.0),
              child: Container(
                width: width ?? 100,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey.withOpacity(0.6)),
                ),
                child: TextField(
                  controller: controller,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: Theme.of(context).textTheme.caption!.copyWith(color: Colors.grey.withOpacity(0.7),),
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
