import 'package:github_stars_app/model/respositoryModel.dart';

abstract class GithubState {}

class GithubInitial extends GithubState {}

class GithubLoading extends GithubState {}

class GithubLoaded extends GithubState {
  final List<RepositoryModel> repositories;
  GithubLoaded(this.repositories);
}

class GithubError extends GithubState {
  final String message;
  GithubError(this.message);
}
