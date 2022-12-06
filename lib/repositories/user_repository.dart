import 'package:flutter_template/services/dio_client.dart';
import 'package:flutter_template/services/services.dart';
import 'package:flutter_template/user_details/models/user_details.dart';

class UserRepository {
  UserRepository({BaseClient? baseClient}) : _baseClient = baseClient ?? DioApiClient();

  final BaseClient _baseClient;

  Future<UserDetails> fetchUserDetails() async {
    var response = await _baseClient.get('https://api.github.com/users/duytq94');
    return UserDetails.fromJson(response);
  }
}
