import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _educationController = TextEditingController();
  final _skillsController = TextEditingController();
  final _currentLpgController = TextEditingController();
  final _expectedLpgController = TextEditingController();
  final _noticePeriodController = TextEditingController();
  final _expirenceController = TextEditingController();
  final _departmentController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactNumberController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  var dateController = TextEditingController();

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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    numericTextFieldWidget(
                        title: "Age",
                        controller: _ageController,
                        hintText: "enter Age",
                        keyboardType: TextInputType.number,
                        width: MediaQuery.of(context).size.width),
                    textDatePickerWidget(
                        context: context,
                        width: MediaQuery.of(context).size.width),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Gender :",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Colors.black.withOpacity(0.7),
                                    fontWeight: FontWeight.w700),
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
                                    .copyWith(
                                        color: Colors.black.withOpacity(0.7),
                                        fontWeight: FontWeight.w500)),
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
                                    .copyWith(
                                        color: Colors.black.withOpacity(0.7),
                                        fontWeight: FontWeight.w500)),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 6.0, right: 5.0, bottom: 2.0),
                          child: SizedBox(
                            width: 280,
                            child: Text(
                              "Email Id",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w700),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            style: Theme.of(context).textTheme.bodyText2,
                            maxLines: 1,
                            controller: _emailController,
                            textAlign: TextAlign.left,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.length > 4 &&
                                  value.contains('@') &&
                                  value.endsWith('.com')) {
                                return null;
                              } else {
                                return 'Enter Valid EmailId';
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'EmailId',
                              border: const OutlineInputBorder(),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 1.5),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 6.0, right: 5.0, bottom: 2.0),
                          child: SizedBox(
                            width: 280,
                            child: Text(
                              "Contact Number",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w700),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            style: Theme.of(context).textTheme.bodyText2,
                            maxLines: 1,
                            controller: _contactNumberController,
                            textAlign: TextAlign.left,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9]+')),
                            ],
                            validator: (value) {
                              String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                              RegExp regExp = RegExp(pattern);
                              if (value!.length != 10) {
                                return 'Please enter valid mobile number';
                              } else if (!regExp.hasMatch(value)) {
                                return 'Please enter valid mobile number';
                              } else
                                return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Contact Number',
                              border: const OutlineInputBorder(),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 1.5),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(5.0),
                              ), //make the icon also change its color
                            ),
                          ),
                        ),
                      ],
                    ),
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Colors.black.withOpacity(0.7),
                                    fontWeight: FontWeight.w700),
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
                    numericTextFieldWidget(
                        title: "Experience(months)",
                        controller: _expirenceController,
                        hintText: "Enter Experience Details",
                        keyboardType: TextInputType.number,
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
                        numericTextFieldWidget(
                            controller: _currentLpgController,
                            title: "Current LPG(L)",
                            hintText: "enter Current LPG",
                            keyboardType: TextInputType.number,
                            width: MediaQuery.of(context).size.width / 2 - 20),
                        numericTextFieldWidget(
                            controller: _expectedLpgController,
                            title: "Expected LPG(L)",
                            hintText: "Enter Expected LPG",
                            keyboardType: TextInputType.number,
                            width: MediaQuery.of(context).size.width / 2),
                      ],
                    ),
                    numericTextFieldWidget(
                        controller: _noticePeriodController,
                        title: "Notice Period Duration(days)",
                        hintText: "Enter Notice Period",
                        keyboardType: TextInputType.number,
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
                                Text("Submit",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                              ],
                            ),
                            onPressed: () {
                              if (validateForm(context)) {
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

  Widget textFieldWidget(
      {TextEditingController? controller,
      TextInputType? keyboardType,
      String? hintText,
      double? width,
      double? height,
      bool? isEmail = false,
      bool isMandatory = false,
      bool? isNumeric = false,
      bool? maxLines = false,
      String? title,
      String? imageUrl}) {
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
              padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
              child: SizedBox(
                width: width ?? 200,
                child: TextFormField(
                  maxLines: maxLines == false ? 1 : 4,
                  controller: controller,
                  inputFormatters: <TextInputFormatter>[
                    isNumeric == true
                        ? FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                        : FilteringTextInputFormatter.singleLineFormatter,
                  ],
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w500),
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate != null
            ? DateTime.parse("${selectedDate.toLocal()}".split(' ')[0])
            : DateTime.now(),
        firstDate: DateTime(1980, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  bool validateForm(BuildContext context) {
    if (_nameController.text.isEmpty && _ageController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please Enter Name")));
      return false;
    } else if (_ageController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please Enter Age")));
      return false;
    } else if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please Enter EmailId")));
      return false;
    } else if (_contactNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please Enter  ContactNumber")));
      return false;
    } else if (_skillsController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please Enter Skills")));
      return false;
    } else if (_educationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please Enter Educational Details")));
      return false;
    } else if (_expirenceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please Enter Experience")));
      return false;
    } else if (_departmentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please Enter Department Details")));
      return false;
    } else if (_currentLpgController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please Enter Current LPG")));
      return false;
    } else if (_expectedLpgController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please Enter Excepted LPG")));
      return false;
    } else if (_noticePeriodController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please Enter NoticePeriod Duration")));
      return false;
    } else {
      return true;
    }
  }

  Widget textDatePickerWidget(
      {TextEditingController? controller,
      TextInputType? keyboardType,
      BuildContext? context,
      String? hintText,
      double? width,
      double? height,
      bool? isEmail = false,
      bool isMandatory = false,
      bool? isNumeric = false,
      bool? maxLines = false,
      String? title,
      String? imageUrl}) {
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
                  "Date Of Birth",
                  style: Theme.of(context!).textTheme.bodyText1!.copyWith(
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w700),
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
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w500),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  showCursor: false,
                  onTap: () {
                    _selectDate(context);
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 10),
                    hintText: selectedDate != null
                        ? "${selectedDate.toLocal()}".split(' ')[0]
                        : "Select Date",
                    hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.black.withOpacity(0.7),
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
                    ),
                    suffixIcon: const Icon(Icons.calendar_today_sharp,
                        color: Colors.black,
                        size: 17), //make the icon also change its color
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

  Widget numericTextFieldWidget(
      {TextEditingController? controller,
      TextInputType? keyboardType,
      String? title,
      String? hintText,
      double? width,
      double? height}) {
    return SizedBox(
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
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextFormField(
              style: Theme.of(context).textTheme.bodyText2,
              maxLines: 1,
              controller: controller,
              textAlign: TextAlign.left,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp('[0-9.]+')),
              ],
              validator: (value) {
                RegExp regExp = RegExp(r'[0-9]');
                if (value!.isEmpty) {
                  return 'Please enter valid number';
                } else
                  return null;
              },
              decoration: InputDecoration(
                hintText: hintText,
                border: const OutlineInputBorder(),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 1.5),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(5.0),
                ), //make the icon also change its color
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveInterviewData() {
    String? key = _interviewRef!.push().key;
    String? name = _nameController.text;
    String? email = _emailController.text;
    String? prohibitionPeriod = _noticePeriodController.text;
    String? mobileNum = _contactNumberController.text;
    String? age = _ageController.text;
    String? gender = selectedGender == 1 ? "Male" : "Female";
    String? dob = "${selectedDate.toLocal()}".split(' ')[0];
    String? currentLpg = _currentLpgController.text;
    String? expectedLpg = _expectedLpgController.text;
    String? skills = _skillsController.text;
    String? studies = _educationController.text;
    String? status = "In-Review";
    String? teamLeadStatus = "In-Review";
    String? department = _departmentController.text;
    String? workPlaceOption =
        selectedWorkPlace == 1 ? " WorkFormOffice" : "WorkFormHome";

    Map<String, String> interview = {
      'key': key,
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
      'teamLeadStatus': teamLeadStatus,
      'department': department,
      'workPlaceOption': workPlaceOption,
    };
    _interviewRef!.child(key).set(interview);

    print("Posted INTERVIEW DATA${interview}");
    setState(() {});
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          title: const Icon(Icons.check_circle_outline_rounded,
              size: 70, color: Colors.green),
          content: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text("Registered Successfully",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ),
          actions: <Widget>[
            Center(
              child: FlatButton(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
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
    Navigator.push(
        context!,
        MaterialPageRoute(
            builder: (context) => const InterViewerCandidatePage()));
  }
}
