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
  bool? workPlaceOption;

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
    name = json["name"] != null ? json["name"] : "";
    email = json["email"] != null ? json["email"] : "";
    age = json["age"] != null ? json["age"] : "";
    studies = json["studies"] != null ? json["studies"] : "";
    experience = json["experience"] != null ? json["experience"] : "";
    feedback = json["feedback"] != null ? json["feedback"] : "";
    dob = json["dob"] != null ? json["dob"] : "";
    status = json["status"] != null ? json["status"] : "";
    skills = json["skills"] != null ? json["skills"] : "";
    prohibitionPeriod = json["prohibitionPeriod"] != null ? json["prohibitionPeriod"] : "";
    mobileNum = json["mobileNum"] != null ? json["mobileNum"] : "";
    hrReview = json["hrReview"] != null ? json["hrReview"] : "";
    gender = json["gender"] != null ? json["gender"] : "";
    expectedLpg = json["expectedLpg"] != null ? json["expectedLpg"] : "";
    currentLpg = json["currentLpg"] != null ? json["currentLpg"] : "";
    workPlaceOption = json["workPlaceOption"] != null ? json["workPlaceOption"] : false;
  }

  Map<dynamic, dynamic> toJson() {
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
