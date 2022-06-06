import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/radio.dart';
import 'package:interviewapp/interviewScreen/interviewCandidateListPage.dart';
import 'package:interviewapp/repository/databaseRepository.dart';

class CreateCandidateScreen extends StatefulWidget {
  const CreateCandidateScreen({Key? key}) : super(key: key);

  @override
  _CreateCandidateScreenState createState() => _CreateCandidateScreenState();
}

class _CreateCandidateScreenState extends State<CreateCandidateScreen> {
  final interviewDao = InterviewDao();
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
  final _departmentController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactNumberController = TextEditingController();

  DatabaseReference? _interviewRef;

  @override
  void initState() {
    _interviewRef = FirebaseDatabase.instance.reference().child('interview');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text("Registration Screen"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    textFieldWidget(
                        maxLines: false,
                        title: "Candidate Name",
                        controller: _nameController,
                        hintText: "Enter Candidate Name",
                        keyboardType: TextInputType.text,
                        width: MediaQuery.of(context).size.width),
                    Row(
                      children: [
                        textFieldWidget(
                            maxLines: false,
                            title: "Age",
                            controller: _ageController,
                            hintText: "enter Age",
                            keyboardType: TextInputType.number,
                            width: MediaQuery.of(context).size.width / 2 - 20),
                        textFieldWidget(
                            maxLines: false,
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
                          child: Text(
                            "Gender :",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w700),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: 140,
                          child: ListTile(
                            title: Text("Male",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w500)),
                            leading: Radio(
                              value: 1,
                              groupValue: selectedGender,
                              onChanged: (int? value) {
                                setState(() {
                                  selectedGender = value!;
                                });
                              },
                              activeColor: Colors.indigo,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: ListTile(
                            title: Text("Female",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w500)),
                            leading: Radio(
                              value: 2,
                              groupValue: selectedGender,
                              onChanged: (int? value) {
                                setState(() {
                                  selectedGender = value!;
                                });
                              },
                              activeColor: Colors.indigo,
                            ),
                          ),
                        ),
                      ],
                    ),
                    textFieldWidget(
                        maxLines: false,
                        title: "Email",
                        controller: _emailController,
                        hintText: "Enter Email",
                        keyboardType: TextInputType.emailAddress,
                        width: MediaQuery.of(context).size.width),
                    textFieldWidget(
                        maxLines: false,
                        title: "Contact Number",
                        controller: _contactNumberController,
                        hintText: "Enter Contact Number",
                        keyboardType: TextInputType.number,
                        width: MediaQuery.of(context).size.width),
                    textFieldWidget(
                        maxLines: true,
                        title: "Education",
                        controller: _educationController,
                        hintText: "Enter Education Details",
                        keyboardType: TextInputType.text,
                        height: 50,
                        width: MediaQuery.of(context).size.width),
                    textFieldWidget(
                        maxLines: true,
                        title: "Technical Skills",
                        controller: _skillsController,
                        hintText: "Enter Technical Skills",
                        keyboardType: TextInputType.text,
                        height: 70,
                        width: MediaQuery.of(context).size.width),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Work Option:",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w700),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: selectedWorkPlace,
                              onChanged: (int? value) {
                                setState(() {
                                  selectedWorkPlace = value!;
                                });
                              },
                              activeColor: Colors.indigo,
                            ),
                            const Text('WorkFromOffice'),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 2,
                              groupValue: selectedWorkPlace,
                              onChanged: (int? value) {
                                setState(() {
                                  selectedWorkPlace = value!;
                                });
                              },
                              activeColor: Colors.indigo,
                            ),
                            const Text('W.F.Home'),
                          ],
                        ),
                      ],
                    ),
                    textFieldWidget(
                        maxLines: false,
                        title: "Experience(months)",
                        controller: _expirenceController,
                        hintText: "Enter Experience Details",
                        keyboardType: TextInputType.text,
                        width: MediaQuery.of(context).size.width),
                    textFieldWidget(
                        maxLines: false,
                        title: "Department",
                        controller: _departmentController,
                        hintText: "Enter Department",
                        keyboardType: TextInputType.text,
                        width: MediaQuery.of(context).size.width),
                    Row(
                      children: [
                        textFieldWidget(
                            maxLines: false,
                            controller: _currentLpgController,
                            title: "Current LPG(L)",
                            hintText: "enter Current LPG",
                            keyboardType: TextInputType.number,
                            width: MediaQuery.of(context).size.width / 2 - 20),
                        textFieldWidget(
                            maxLines: false,
                            controller: _expectedLpgController,
                            title: "Expected LPG(L)",
                            hintText: "Enter Expected LPG",
                            keyboardType: TextInputType.number,
                            width: MediaQuery.of(context).size.width / 2),
                      ],
                    ),
                    textFieldWidget(
                        maxLines: false,
                        controller: _noticePeriodController,
                        title: "Notice Period Duration",
                        hintText: "Enter Notice Period",
                        keyboardType: TextInputType.text,
                        width: MediaQuery.of(context).size.width),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 20,
                        height: 40,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.indigo,
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
                            onPressed: () {
                              if(validateForm(context)){
                                _saveInterviewData();
                                _showDialog();
                              }
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validateForm(BuildContext context) {
    if (_nameController.text.isEmpty && _ageController.text.isEmpty && _dobController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Enter complete Information to Proceed")));
      return false;
    } else if (_emailController.text.isEmpty && _contactNumberController.text.isEmpty && _educationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Enter complete Information to Proceed")));
      return false;
    } else if (_skillsController.text.isEmpty && _expirenceController.text.isEmpty &&_departmentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Enter complete Information to Proceed")));
      return false;
    }else if (_currentLpgController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Enter complete Information to Proceed")));
      return false;
    }else if ( _expectedLpgController.text.isEmpty ) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Enter complete Information to Proceed")));
      return false;
    }else if ( _noticePeriodController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Enter complete Information to Proceed")));
      return false;
    }
    else {
      return true;
    }
  }

  Widget textFieldWidget(
      {TextEditingController? controller,
      TextInputType? keyboardType,
      String? hintText,
      double? width,
      double? height,
      bool? maxLines =false,
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
              padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
              child: SizedBox(
                width: width ?? 200,
                child: TextFormField(
                  maxLines: maxLines ==false ?1:4,
                  controller: controller,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w500),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field Can't be Empty ";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.grey.withOpacity(0.7),
                    ),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(5.0),
                    ), //make the icon also change its color
                  ),
                  onChanged: (val) {
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



  void _saveInterviewData() {
    String? name = _nameController.text;
    String? email = _emailController.text;
    String? prohibitionPeriod = _noticePeriodController.text;
    String? mobileNum = _contactNumberController.text;
    String? age = _ageController.text;
    String? gender = selectedGender == 1 ? "Male" : "Female";
    String? dob = _dobController.text;
    String? currentLpg = _currentLpgController.text;
    String? expectedLpg = _expectedLpgController.text;
    String? skills = _skillsController.text;
    String? studies = _educationController.text;
    String? status = "In-Review";
    String? department = _departmentController.text;
    String? workPlaceOption = selectedWorkPlace == 1 ? " WorkFormOffice" : "WorkFormHome";

    Map<String, String> interview = {
      'name': name,
      'email': email,
      'prohibitionPeriod': prohibitionPeriod,
      'mobileNum': mobileNum,
      'age': age,
      'gender': gender,
      'dob': dob,
      'currentLpg': currentLpg,
      'expectedLpg': expectedLpg,
      'skills': skills,
      'studies': studies,
      'status': status,
      'department':department,
      'workPlaceOption': workPlaceOption,
    };

    _interviewRef!.push().set(interview);
    setState(() {});
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
          title: const Icon(Icons.check_circle_outline_rounded, size: 70, color: Colors.green),
          content: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text("Registered Successfully", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ),
          actions: <Widget>[
            Center(
              child: FlatButton(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                color: Colors.indigo,
                textColor: Colors.white,
                child: const Text('Done'),
                onPressed: () {
                  navigateToInterviewListPage(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }
  void navigateToInterviewListPage(BuildContext? context) {
    Navigator.push(context!, MaterialPageRoute(builder: (context) => const InterViewerCandidatePage()));
  }
}
