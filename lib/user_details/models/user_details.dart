import 'package:flutter_template/utilities/parser.dart';

class UserDetails {
  const UserDetails({
    required this.username,
    required this.name,
    required this.avatarUrl,
    required this.location,
  });

  final String username;
  final String name;
  final String avatarUrl;
  final String location;

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      username: Parser.parseString(json["login"]) ?? "",
      name: Parser.parseString(json["name"]) ?? "",
      avatarUrl: Parser.parseString(json["avatar_url"]) ?? "",
      location: Parser.parseString(json["location"]) ?? "",
    );
  }
}
