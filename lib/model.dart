class InterviewBean {
  String? key;
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
  String? hrRating;
  String? teamLeadRating;
  String? status;
  String? teamLeadStatus;
  String? workPlaceOption;

  InterviewBean(
      {this.key,
      this.name,
      this.teamLeadRating,
      this.hrRating,
      this.email,
      this.studies,
      this.experience,
      this.skills,
      this.age,
      this.practicalReview,
      this.dob,
      this.teamLeadStatus,
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
    key = json["key"] ?? "";
    email = json["email"] ?? "";
    age = json["age"] ?? "";
    studies = json["studies"] ?? "";
    experience = json["experience"] ?? "";
    technicalReview = json["technicalReview"] ?? "";
    dob = json["dob"] ?? "";
    status = json["status"] ?? "";
    skills = json["skills"] ?? "";
    hrRating = json["hrRating"] ?? "";
    teamLeadRating = json["teamLeadRating"] ?? "";
    prohibitionPeriod = json["prohibitionPeriod"] ?? "";
    mobileNum = json["mobileNum"] ?? "";
    hrReview = json["hrReview"] ?? "";
    gender = json["gender"] ?? "";
    expectedLpg = json["expectedLpg"] ?? "";
    department = json["department"] ?? "";
    practicalReview = json['practicalReview'] ?? "";
    teamLeadStatus = json['teamLeadStatus'] ?? "";
    currentLpg = json["currentLpg"] ?? "";
    workPlaceOption = json["workPlaceOption"] ?? "";
  }

  Map toJson() {
    var map = <dynamic, dynamic>{};
    map["key"] = key;
    map["name"] = name;
    map["email"] = email;
    map["age"] = age;
    map["dob"] = dob;
    map["status"] = status;
    map["studies"] = studies;
    map["experience"] = experience;
    map["technicalReview"] = technicalReview;
    map["department"] = department;
    map["skills"] = skills;
    map["prohibitionPeriod"] = prohibitionPeriod;
    map["practicalReview"] = practicalReview;
    map["hrRating"] = hrRating;
    map["teamLeadRating"] = teamLeadRating;
    map["mobileNum"] = mobileNum;
    map["teamLeadStatus"] = teamLeadStatus;
    map["gender"] = gender;
    map["hrReview"] = hrReview;
    map["expectedLpg"] = expectedLpg;
    map["currentLpg"] = currentLpg;
    map["workPlaceOption"] = workPlaceOption;
    return map;
  }
}
