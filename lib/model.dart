class InterviewBean {
  String? name;
  String? email;
  String? studies;
  String? experience;
  String? age;
  String? skills;
  String? prohibitionPeriod;
  String? mobileNum;
  String? gender;
  String? dob;
  String? technicalReview;
  String? hrReview;
  String? expectedLpg;
  String? currentLpg;
  String? department;
  String? practicalReview;
  String? status;
  String? workPlaceOption;

  InterviewBean(
      {this.name,
      this.email,
      this.studies,
      this.experience,
      this.skills,
      this.age,
      this.practicalReview,
      this.dob,
      this.prohibitionPeriod,
      this.mobileNum,
      this.gender,
      this.expectedLpg,
      this.currentLpg,
      this.status,
      this.hrReview,
      this.technicalReview,
      this.department,
      this.workPlaceOption});

  InterviewBean.fromJson(Map<dynamic, dynamic> json) {
    name = json["name"] ?? "";
    email = json["email"] ?? "";
    age = json["age"] ?? "";
    studies = json["studies"] ?? "";
    experience = json["experience"] ?? "";
    technicalReview = json["technicalReview"] ?? "";
    dob = json["dob"] ?? "";
    status = json["status"] ?? "";
    skills = json["skills"] ?? "";
    prohibitionPeriod = json["prohibitionPeriod"] ?? "";
    mobileNum = json["mobileNum"] ?? "";
    hrReview = json["hrReview"] ?? "";
    gender = json["gender"] ?? "";
    expectedLpg = json["expectedLpg"] ?? "";
    department =json["department"]??"";
    practicalReview = json['practicalReview'] ?? "";
    currentLpg = json["currentLpg"] ?? "";
    workPlaceOption = json["workPlaceOption"] ?? "";
  }

  Map toJson() {
    var map = <dynamic, dynamic>{};
    map["name"] = name;
    map["email"] = email;
    map["age"] = age;
    map["dob"] = dob;
    map["status"] = status;
    map["studies"] = studies;
    map["experience"] = experience;
    map["technicalReview"] = technicalReview;
    map["department"]= department;
    map["skills"] = skills;
    map["prohibitionPeriod"] = prohibitionPeriod;
    map["practicalReview"] = practicalReview;
    map["mobileNum"] = mobileNum;
    map["gender"] = gender;
    map["hrReview"] = hrReview;
    map["expectedLpg"] = expectedLpg;
    map["currentLpg"] = currentLpg;
    map["workPlaceOption"] = workPlaceOption;
    return map;
  }
}

