import 'package:equatable/equatable.dart';
import 'package:flutter_template/utilities/parser.dart';

class UserDetails extends Equatable {
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

  @override
  List<Object?> get props => [name, username, avatarUrl, location];

  @override
  String toString() {
    return "UserDetails { username: $username, name: $name, avatarUrl: $avatarUrl, location: $location }";
  }
}
