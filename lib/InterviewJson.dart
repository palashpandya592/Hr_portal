class InterviewBean {
  String? name;
  String? email;
  String? studies;
  String? experience;
  String? skills;
  String? prohibitionPeriod;
  String? mobileNum;
  String? gender;
  String? expectedLpg;
  String? currentLpg;
  bool? workPlaceOption;

  InterviewBean(
      {this.name,
      this.email,
      this.studies,
      this.experience,
      this.skills,
      this.prohibitionPeriod,
      this.mobileNum,
      this.gender,
      this.expectedLpg,
      this.currentLpg,
      this.workPlaceOption});

  InterviewBean.fromJson(Map<String, dynamic> json) {
    name = json["name"] != null ? json["name"] : "";
    email = json["email"] != null ? json["email"] : "";
    studies = json["studies"] != null ? json["studies"] : "";
    experience = json["experience"] != null ? json["experience"] : "";
    skills = json["skills"] != null ? json["skills"] : "";
    prohibitionPeriod = json["prohibitionPeriod"] != null ? json["prohibitionPeriod"] : "";
    mobileNum = json["mobileNum"] != null ? json["mobileNum"] : "";
    gender = json["gender"] != null ? json["gender"] : "";
    expectedLpg = json["expectedLpg"] != null ? json["expectedLpg"] : "";
    currentLpg = json["currentLpg"] != null ? json["currentLpg"] : "";
    workPlaceOption = json["workPlaceOption"] != null ? json["workPlaceOption"] : false;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["email"] = email;
    map["studies"] = studies;
    map["experience"] = experience;
    map["skills"] = skills;
    map["prohibitionPeriod"] = prohibitionPeriod;
    map["mobileNum"] = mobileNum;
    map["gender"] = gender;
    map["expectedLpg"] = expectedLpg;
    map["currentLpg"] = currentLpg;
    map["workPlaceOption"] = workPlaceOption;
    return map;
  }
}
