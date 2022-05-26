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
  String? feedback;
  String? hrReview;
  String? expectedLpg;
  String? currentLpg;
  String? status;
  String? workPlaceOption;

  InterviewBean(
      {this.name,
      this.email,
      this.studies,
      this.experience,
      this.skills,
      this.age,
      this.dob,
      this.prohibitionPeriod,
      this.mobileNum,
      this.gender,
      this.expectedLpg,
      this.currentLpg,
      this.status,
      this.hrReview,
      this.feedback,
      this.workPlaceOption});

  InterviewBean.fromJson(Map<dynamic, dynamic> json) {
    name = json["name"] ?? "";
    email = json["email"] ?? "";
    age = json["age"] ?? "";
    studies = json["studies"] ?? "";
    experience = json["experience"] ?? "";
    feedback = json["feedback"] ?? "";
    dob = json["dob"] ?? "";
    status = json["status"] ?? "";
    skills = json["skills"] ?? "";
    prohibitionPeriod = json["prohibitionPeriod"] ?? "";
    mobileNum = json["mobileNum"] ?? "";
    hrReview = json["hrReview"] ?? "";
    gender = json["gender"] ?? "";
    expectedLpg = json["expectedLpg"] ?? "";
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
    map["feedback"] = feedback;
    map["skills"] = skills;
    map["prohibitionPeriod"] = prohibitionPeriod;
    map["mobileNum"] = mobileNum;
    map["gender"] = gender;
    map["hrReview"] = hrReview;
    map["expectedLpg"] = expectedLpg;
    map["currentLpg"] = currentLpg;
    map["workPlaceOption"] = workPlaceOption;
    return map;
  }
}
