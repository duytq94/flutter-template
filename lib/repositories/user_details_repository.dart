import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_template/services/services.dart';
import 'package:flutter_template/ui/user_details/models/user_details.dart';

abstract class UserDetailsRepository {
  Future<Result> getUserDetails();
}

class UserDetailsRepositoryImpl extends UserDetailsRepository {
  UserDetailsRepositoryImpl(this._baseClient);

  final BaseClient _baseClient;

  @override
  Future<Result> getUserDetails() async {
    try {
      // load from network
      // var res = await _baseClient.get('users/duytq94');

      // load from local file
      var jsonString = await rootBundle.loadString('assets/user_details.json');
      await Future.delayed(const Duration(seconds: 1));
      var res = jsonDecode(jsonString);

      var userDetails = UserDetails.fromJson(res);
      return Success<UserDetails>(userDetails);
    } on AppException catch (appException) {
      return Failure(appException.message);
    } catch (error) {
      return Failure(error.toString());
    }
  }
}
