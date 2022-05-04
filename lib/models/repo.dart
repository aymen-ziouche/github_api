// import 'dart:convert';

// class Repos {
//   Repos(
//       {required this.id,
//       required this.name,
//       required this.svnUrl,
//       required this.description});

//   int id;
//   String name;
//   String svnUrl;
//   String description;

//   factory Repos.fromMap(Map<String, dynamic> json) => Repos(
//       id: json["id"],
//       name: json["name"],
//       svnUrl: json["svn_url"],
//       description: json["description"]);
// }

// To parse this JSON data, do
//
//     final medias = mediasFromMap(jsonString);

// import 'dart:convert';

// class Repos {
//   Repos({
//     required this.data,
//   });

//   List<Repo> data;

//   factory Repos.fromJson(String str) => Repos.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory Repos.fromMap(Map<String, dynamic> json) => Repos(
//         data: List<Repo>.from(json["data"].map((x) => Repo.fromMap(x))),
//       );

//   Map<String, dynamic> toMap() => {
//         "data": List<dynamic>.from(data.map((x) => x.toMap())),
//       };
// }

// class Repo {
//   Repo({
//     required this.id,
//     required this.name,
//     required this.svnUrl,
//     required this.description,
//   });

//   String id;
//   String name;
//   String svnUrl;
//   String description;

//   factory Repo.fromJson(String str) => Repo.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory Repo.fromMap(Map<String, dynamic> json) => Repo(
//         id: json["id"] ?? "",
//         name: json["name"] ?? "",
//         svnUrl: json["svn_url"] ?? "",
//         description: json["description"] ?? "",
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "name": name,
//         "svn_url": svnUrl,
//         "description": description,
//       };
// }

import 'dart:convert';

List<Repo> repoFromMap(String str) =>
    List<Repo>.from(json.decode(str).map((x) => Repo.fromMap(x)));

String repoToMap(List<Repo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Repo {
  Repo({
    required this.id,
    required this.name,
    this.description,
    required this.svnUrl,
  });

  int id;
  String name;
  dynamic description;
  String svnUrl;

  factory Repo.fromMap(Map<String, dynamic> json) => Repo(
        id: json["id"],
        name: json["name"],
        description: json["description"] ?? "No description available",
        svnUrl: json["svn_url"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "svn_url": svnUrl,
      };
}
