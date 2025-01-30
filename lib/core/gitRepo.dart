import 'package:github_stars_app/core/apiService.dart';
import 'package:github_stars_app/core/databaseHelper.dart';
import 'package:github_stars_app/model/respositoryModel.dart';

class GithubRepository {
  final NetworkService networkService;
  final DatabaseHelper databaseHelper;

  GithubRepository(this.networkService, this.databaseHelper);

  Future<List<RepositoryModel>> getRepositories() async {
    try {
      final List<RepositoryModel> repos =
          await networkService.fetchRepositories();
      await databaseHelper.insertRepositories(repos);
      return repos;
    } catch (_) {
      return await databaseHelper.getRepositories();
    }
  }
}
