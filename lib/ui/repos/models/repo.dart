import 'package:freezed_annotation/freezed_annotation.dart';

part 'repo.freezed.dart';

part 'repo.g.dart';

@freezed
class Repo with _$Repo {
  const factory Repo({
    @JsonKey(defaultValue: "") required String name,
    @JsonKey(defaultValue: "") required String description,
    @JsonKey(defaultValue: "") required String url,
    @JsonKey(defaultValue: "") required String language,
    @JsonKey(name: "stargazers_count", defaultValue: 0) required int star,
  }) = _Repo;

  factory Repo.fromJson(Map<String, dynamic> json) => _$RepoFromJson(json);
}
