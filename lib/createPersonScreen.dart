import 'package:flutter/material.dart';
import 'package:flutter/src/material/radio.dart';
import 'package:interviewapp/InterviewJson.dart';
import 'package:interviewapp/listScreen.dart';

class CreateCandidateScreen extends StatefulWidget {
   List<InterviewBean>? interviewList ;
   ValueChanged<List<InterviewBean>> onChanged;///onchanged
   CreateCandidateScreen({required this.interviewList,required this.onChanged,Key? key}) : super(key: key);

  @override
  _CreateCandidateScreenState createState() => _CreateCandidateScreenState();
}

class _CreateCandidateScreenState extends State<CreateCandidateScreen> {

  int selectedGender = 1;
  int selectedWorkPlace = 1;
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _dobController = TextEditingController();
  final _educationController = TextEditingController();
  final _skillsController = TextEditingController();
  final _currentLpgController = TextEditingController();
  final _expectedLpgController = TextEditingController();
  final _noticePeriodController = TextEditingController();
  final _expirenceController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Registration Screen"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height -130,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    textFieldWidget(
                        title: "Candidate Name",
                        controller: _nameController,
                        hintText: "Enter Candidate Name",
                        keyboardType: TextInputType.text,
                        width: MediaQuery.of(context).size.width),
                    Row(
                      children: [
                        textFieldWidget(
                            title: "Age",
                            controller: _ageController,
                            hintText: "enter Age", keyboardType: TextInputType.number, width: MediaQuery.of(context).size.width / 2 - 20),
                        textFieldWidget(
                            title: "Date of Birth",
                            controller: _dobController,
                            hintText: "Enter Date of Birth",
                            keyboardType: TextInputType.text,
                            width: MediaQuery.of(context).size.width / 2),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text("Gender :",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w700),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,),
                        ),
                        SizedBox(
                          width: 140,
                          child: ListTile(
                            title: Text("Male",
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w500)),
                            leading: Radio(
                              value: 1,
                              groupValue: selectedGender,
                              onChanged: (int? value) {
                                setState(() {
                                  selectedGender = value!;
                                });
                              },
                              activeColor: Colors.blue,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: ListTile(
                            title: Text("Female",
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w500)),
                            leading: Radio(
                              value: 2,
                              groupValue: selectedGender,
                              onChanged: (int? value) {
                                setState(() {
                                  selectedGender = value!;
                                });
                              },
                              activeColor: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    textFieldWidget(
                        title: "Email",
                        controller: _emailController,
                        hintText: "Enter Email",
                        keyboardType: TextInputType.emailAddress,
                        width: MediaQuery.of(context).size.width),
                    textFieldWidget(
                        title: "Contact Number",
                        controller: _contactNumberController,
                        hintText: "Enter Contact Number",
                        keyboardType: TextInputType.text,
                        width: MediaQuery.of(context).size.width),
                    textFieldWidget(
                        title: "Education",
                        controller: _educationController,
                        hintText: "Enter Education Details",
                        keyboardType: TextInputType.text,
                        height: 50,
                        width: MediaQuery.of(context).size.width),
                    textFieldWidget(
                        title: "Technical Skills",
                        controller: _skillsController,
                        hintText: "Enter Technical Skills",
                        keyboardType: TextInputType.text,
                        height: 70,
                        width: MediaQuery.of(context).size.width),
                   /* Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("Work Option :",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w700),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,),
                    ),
                    ListTile(
                      title: Text("Work From Home(WFH)",
                     style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w500)),
                      leading: Radio(
                        value: 1,
                        groupValue: selectedWorkPlace,
                        onChanged: (int? value) {
                          setState(() {
                            selectedWorkPlace = value!;
                          });
                        },
                        activeColor: Colors.blue,
                      ),
                    ),
                    ListTile(
                      title: Text("Work From Office(WFO)",
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w500)),
                      leading: Radio(
                        value: 2,
                        groupValue: selectedWorkPlace,
                        onChanged: (int? value) {
                          setState(() {
                            selectedWorkPlace = value!;
                            print(selectedWorkPlace);
                          });
                        },
                        activeColor: Colors.blue,
                      ),
                    ),*/
                    textFieldWidget(
                        title: "Experience",
                        controller: _expirenceController,
                        hintText: "Enter Experience Details",
                        keyboardType: TextInputType.text,
                        width: MediaQuery.of(context).size.width),
                    Row(
                      children: [
                        textFieldWidget(
                          controller: _currentLpgController,
                            title: "Current LPG", hintText: "enter Current LPG", keyboardType: TextInputType.number, width: MediaQuery.of(context).size.width / 2 - 20),
                        textFieldWidget(
                          controller: _expectedLpgController,
                            title: "Expected LPG",
                            hintText: "Enter Expected LPG",
                            keyboardType: TextInputType.number,
                            width: MediaQuery.of(context).size.width / 2),
                      ],
                    ),
                    textFieldWidget(
                      controller: _noticePeriodController,
                        title: "Notice Period Duration",
                        hintText: "Enter Notice Period",
                        keyboardType: TextInputType.text,
                        width: MediaQuery.of(context).size.width),
                     const SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              height: 40,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: const [
                      Text("Submit", style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  onPressed: ()  {
                    InterviewBean interviewListBean = new InterviewBean();
                      if (_nameController.text.isNotEmpty && _emailController.text.isNotEmpty
                          && _contactNumberController.text.isNotEmpty && _noticePeriodController.text.isNotEmpty) {
                        interviewListBean
                          ..email =_emailController.text
                          ..name = _nameController.text
                          ..gender =selectedGender ==1? "Male":"Female"
                          ..currentLpg =_currentLpgController.text
                          ..expectedLpg =_expectedLpgController.text
                          ..experience = _expirenceController.text
                          ..prohibitionPeriod =_noticePeriodController.text
                          ..studies =_educationController.text
                          ..mobileNum =_contactNumberController.text
                          ..skills =_skillsController.text;
                        widget.interviewList!.add(interviewListBean);
                        widget.interviewList = widget.interviewList!.toSet().toList();
                        widget.onChanged(widget.interviewList!);
                        _showDialog();
                        print(interviewListBean.toJson());
                        print(widget.interviewList!.length);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter Candidate Details..')));
                      }
                  }),
            ),
          ],
        ),
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
                   // _emailOk = EmailValidator.validate(_email);
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

  String? validateEmail(String? value) {
    if (value != null) {
      if (value.length > 5 && value.contains('@') && value.endsWith('.com')) {
        return null;
      }
      return 'Enter a Valid Email Address';
    }}

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
          title: const Icon(Icons.check_circle_outline_rounded, size: 70, color: Colors.green),
          content:const Padding(
            padding:  EdgeInsets.only(left: 10),
            child:  Text("Registered Successfully", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ),
          actions: <Widget>[
            Center(
              child: FlatButton(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                color: Colors.blue,
                textColor: Colors.white,
                child: const Text('Done'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ListScreen()));
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
