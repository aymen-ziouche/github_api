import 'dart:convert';

class Repos {
  Repos(
      {required this.id,
      required this.name,
      required this.svnUrl,
      required this.description});

  int id;
  String name;
  String svnUrl;
  String description;

  factory Repos.fromMap(Map<String, dynamic> json) => Repos(
      id: json["id"],
      name: json["name"],
      svnUrl: json["svn_url"],
      description: json["description"]);
}
