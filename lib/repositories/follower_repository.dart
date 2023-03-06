import 'package:flutter_template/config/app_config.dart';
import 'package:flutter_template/followers/models/follower.dart';
import 'package:flutter_template/services/base_client.dart';
import 'package:flutter_template/services/dio_client.dart';

class FollowerRepository {
  FollowerRepository({BaseClient? baseClient}) : _baseClient = baseClient ?? getIt.get<DioApiClient>();

  final BaseClient _baseClient;

  Future<List<Follower>> fetchFollowers(int page, int limit) async {
    var response = await _baseClient.get('https://api.github.com/users/duytq94/followers?page=$page&per_page=$limit');
    var dataList = response != null && response is List ? response : [];
    return dataList.map((model) => Follower.fromJson(model)).toList();
  }
}
