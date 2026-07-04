class CVData {
  PersonalInfo personalInfo;
  List<Experience> experience;
  List<Education> education;
  List<String> skills;

  CVData({
    required this.personalInfo,
    this.experience = const [],
    this.education = const [],
    this.skills = const [],
  });

  factory CVData.empty() {
    return CVData(
      personalInfo: PersonalInfo.empty(),
      experience: [],
      education: [],
      skills: [],
    );
  }
}

class PersonalInfo {
  String fullName;
  String email;
  String phone;
  String location;
  String linkedin;
  String professionalSummary;

  PersonalInfo({
    this.fullName = '',
    this.email = '',
    this.phone = '',
    this.location = '',
    this.linkedin = '',
    this.professionalSummary = '',
  });

  factory PersonalInfo.empty() => PersonalInfo();
}

class Experience {
  String id;
  String jobTitle;
  String company;
  String location;
  String startDate;
  String endDate;
  String description;

  Experience({
    required this.id,
    this.jobTitle = '',
    this.company = '',
    this.location = '',
    this.startDate = '',
    this.endDate = '',
    this.description = '',
  });
}

class Education {
  String id;
  String degree;
  String institution;
  String location;
  String startDate;
  String endDate;

  Education({
    required this.id,
    this.degree = '',
    this.institution = '',
    this.location = '',
    this.startDate = '',
    this.endDate = '',
  });
}
