import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_template/services/base_client.dart';
import 'package:flutter_template/services/result_model.dart';
import 'package:flutter_template/ui/repos/models/repo.dart';

abstract class RepoRepository {
  Future<Result> getRepos(int page, int perPage);
}

class RepoRepositoryImpl extends RepoRepository {
  RepoRepositoryImpl(this._baseClient);

  final BaseClient _baseClient;

  @override
  Future<Result> getRepos(int page, int perPage) async {
    try {
      // load from network
      // var res = await _baseClient.get('users/duytq94/repos?page=$page&per_page=$perPage');
      // var dataList = res != null && res is List ? res : [];

      // load from local file
      var jsonString = await rootBundle.loadString('assets/repos.json');
      await Future.delayed(const Duration(seconds: 1));
      var dataList = jsonDecode(jsonString);

      var repos = dataList.map<Repo>((model) => Repo.fromJson(model)).toList();
      return Success<List<Repo>>(repos);
    } catch (e) {
      return Failure(e.toString());
    }
  }
}
