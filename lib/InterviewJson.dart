class InterviewBean {
  String? name;
  String? email;
  String? studies;
  String? experience;
  String? prohibitionPeriod;
  String? mobileNum;
  String? gender;
  bool? workplace;
  String? lpg;
  bool? isPrimaryAddress;

  InterviewBean(
      {this.name,
        this.email,
        this.studies,
        this.experience,
        this.prohibitionPeriod,
        this.mobileNum,
        this.gender,
        this.workplace,
        this.lpg,
        this.isPrimaryAddress});

  InterviewBean.fromJson(Map<String, dynamic> json) {
    name = json["addressLine1"] != null ? json["addressLine1"] : "";
    email = json["addressLine2"] != null ? json["addressLine2"] : "";
    studies = json["addressLine3"] != null ? json["addressLine3"] : "";
    experience = json["city"] != null ? json["city"] : "";
    prohibitionPeriod = json["state"] != null ? json["state"] : "";
    mobileNum = json["pin"] != null ? json["pin"] : "";
    gender = json["country"] != null ? json["country"] : "";
    workplace = json["district"] != null ? json["district"] : "";
    lpg = json["geoPoint"] != null ? json["geoPoint"] : "";
    isPrimaryAddress = json["isPrimaryAddress"] != null ? json["isPrimaryAddress"] : false;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["addressLine1"] = name;
    map["addressLine2"] = email;
    map["addressLine3"] = studies;
    map["city"] = experience;
    map["state"] = prohibitionPeriod;
    map["pin"] = mobileNum;
    map["country"] = gender;
    map["district"] = workplace;
    map["geoPoint"] = lpg;
    map["isPrimaryAddress"] = isPrimaryAddress;
    return map;
  }
}