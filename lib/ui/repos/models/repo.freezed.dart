// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'repo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Repo _$RepoFromJson(Map<String, dynamic> json) {
  return _Repo.fromJson(json);
}

/// @nodoc
mixin _$Repo {
  @JsonKey(defaultValue: "")
  String get name => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: "")
  String get description => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: "")
  String get url => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: "")
  String get language => throw _privateConstructorUsedError;
  @JsonKey(name: "stargazers_count", defaultValue: 0)
  int get star => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RepoCopyWith<Repo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepoCopyWith<$Res> {
  factory $RepoCopyWith(Repo value, $Res Function(Repo) then) =
      _$RepoCopyWithImpl<$Res, Repo>;
  @useResult
  $Res call(
      {@JsonKey(defaultValue: "") String name,
      @JsonKey(defaultValue: "") String description,
      @JsonKey(defaultValue: "") String url,
      @JsonKey(defaultValue: "") String language,
      @JsonKey(name: "stargazers_count", defaultValue: 0) int star});
}

/// @nodoc
class _$RepoCopyWithImpl<$Res, $Val extends Repo>
    implements $RepoCopyWith<$Res> {
  _$RepoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? url = null,
    Object? language = null,
    Object? star = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      star: null == star
          ? _value.star
          : star // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RepoCopyWith<$Res> implements $RepoCopyWith<$Res> {
  factory _$$_RepoCopyWith(_$_Repo value, $Res Function(_$_Repo) then) =
      __$$_RepoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(defaultValue: "") String name,
      @JsonKey(defaultValue: "") String description,
      @JsonKey(defaultValue: "") String url,
      @JsonKey(defaultValue: "") String language,
      @JsonKey(name: "stargazers_count", defaultValue: 0) int star});
}

/// @nodoc
class __$$_RepoCopyWithImpl<$Res> extends _$RepoCopyWithImpl<$Res, _$_Repo>
    implements _$$_RepoCopyWith<$Res> {
  __$$_RepoCopyWithImpl(_$_Repo _value, $Res Function(_$_Repo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? url = null,
    Object? language = null,
    Object? star = null,
  }) {
    return _then(_$_Repo(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      star: null == star
          ? _value.star
          : star // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Repo implements _Repo {
  const _$_Repo(
      {@JsonKey(defaultValue: "") required this.name,
      @JsonKey(defaultValue: "") required this.description,
      @JsonKey(defaultValue: "") required this.url,
      @JsonKey(defaultValue: "") required this.language,
      @JsonKey(name: "stargazers_count", defaultValue: 0) required this.star});

  factory _$_Repo.fromJson(Map<String, dynamic> json) => _$$_RepoFromJson(json);

  @override
  @JsonKey(defaultValue: "")
  final String name;
  @override
  @JsonKey(defaultValue: "")
  final String description;
  @override
  @JsonKey(defaultValue: "")
  final String url;
  @override
  @JsonKey(defaultValue: "")
  final String language;
  @override
  @JsonKey(name: "stargazers_count", defaultValue: 0)
  final int star;

  @override
  String toString() {
    return 'Repo(name: $name, description: $description, url: $url, language: $language, star: $star)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Repo &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.star, star) || other.star == star));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, description, url, language, star);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RepoCopyWith<_$_Repo> get copyWith =>
      __$$_RepoCopyWithImpl<_$_Repo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RepoToJson(
      this,
    );
  }
}

abstract class _Repo implements Repo {
  const factory _Repo(
      {@JsonKey(defaultValue: "")
          required final String name,
      @JsonKey(defaultValue: "")
          required final String description,
      @JsonKey(defaultValue: "")
          required final String url,
      @JsonKey(defaultValue: "")
          required final String language,
      @JsonKey(name: "stargazers_count", defaultValue: 0)
          required final int star}) = _$_Repo;

  factory _Repo.fromJson(Map<String, dynamic> json) = _$_Repo.fromJson;

  @override
  @JsonKey(defaultValue: "")
  String get name;
  @override
  @JsonKey(defaultValue: "")
  String get description;
  @override
  @JsonKey(defaultValue: "")
  String get url;
  @override
  @JsonKey(defaultValue: "")
  String get language;
  @override
  @JsonKey(name: "stargazers_count", defaultValue: 0)
  int get star;
  @override
  @JsonKey(ignore: true)
  _$$_RepoCopyWith<_$_Repo> get copyWith => throw _privateConstructorUsedError;
}
