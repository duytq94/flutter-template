import 'package:equatable/equatable.dart';
import 'package:flutter_template/utilities/parser.dart';

class Follower extends Equatable {
  const Follower({required this.name, required this.avatarUrl});

  final String name;
  final String avatarUrl;

  @override
  List<Object?> get props => [name, avatarUrl];

  @override
  String toString() {
    return "Follower { name: $name, avatarUrl: $avatarUrl }";
  }

  factory Follower.fromJson(Map<String, dynamic> json) {
    return Follower(
      name: Parser.parseString(json["login"]) ?? "",
      avatarUrl: Parser.parseString(json["avatar_url"]) ?? "",
    );
  }
}
