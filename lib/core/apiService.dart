import 'package:dio/dio.dart';
import 'package:github_stars_app/model/respositoryModel.dart';

class NetworkService {
  final dio = Dio();

  Future<List<RepositoryModel>> fetchRepositories() async {
    try {
      final response = await dio.get(
        "https://api.github.com/search/repositories?q=created:>2022-04-29&sort=stars&order=desc",
      );

      print("Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("Fetching repositories...");
        final List<dynamic> items =
            response.data['items']; // No need to decode again
        return items.map((repo) => RepositoryModel.fromJson(repo)).toList();
      } else {
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
      throw Exception("Failed to load data: $e");
    }
  }
}
