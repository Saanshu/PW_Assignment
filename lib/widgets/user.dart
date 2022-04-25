class User {
  User({
    required this.id,
    required this.name,
    required this.subjects,
    required this.qualification,
    required this.profileImage,
  });

  int id;
  String name;
  List<String> subjects;
  List<String> qualification;
  String profileImage;

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        subjects: List<String>.from(json["subjects"].map((x) => x)),
        qualification: List<String>.from(json["qualification"].map((x) => x)),
        profileImage: json["profileImage"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "subjects": List<dynamic>.from(subjects.map((x) => x)),
        "qualification": List<dynamic>.from(qualification.map((x) => x)),
        "profileImage": profileImage,
      };
}
