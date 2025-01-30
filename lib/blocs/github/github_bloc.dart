import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_stars_app/core/gitRepo.dart';

import 'github_event.dart';
import 'github_state.dart';

class GithubBloc extends Bloc<GithubEvent, GithubState> {
  final GithubRepository repository;

  GithubBloc(this.repository) : super(GithubInitial()) {
    on<FetchRepositories>(_onFetchRepositories);
  }

  Future<void> _onFetchRepositories(
      FetchRepositories event, Emitter<GithubState> emit) async {
    emit(GithubLoading());
    try {
      final repositories = await repository.getRepositories();
      emit(GithubLoaded(repositories));
    } catch (e) {
      emit(GithubError(e.toString()));
    }
  }
}
