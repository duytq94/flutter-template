import 'package:flutter_template/services/base_client.dart';
import 'package:flutter_template/services/result_model.dart';
import 'package:flutter_template/ui/followers/models/follower.dart';

abstract class FollowerRepository {
  Future<Result> getFollowers(int page, int perPage);
}

class FollowerRepositoryImpl extends FollowerRepository {
  FollowerRepositoryImpl(this._baseClient);

  final BaseClient _baseClient;

  @override
  Future<Result> getFollowers(int page, int perPage) async {
    try {
      var res = await _baseClient.get('users/duytq94/followers?page=$page&per_page=$perPage');
      var dataList = res != null && res is List ? res : [];
      var followers = dataList.map((model) => Follower.fromJson(model)).toList();
      return Success<List<Follower>>(followers);
    } catch (e) {
      return Failure(e.toString());
    }
  }
}
