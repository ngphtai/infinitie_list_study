import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:infinitie_list/data/model/repositories/post_repository.dart';
import 'package:infinitie_list/data/remote/post_repository_impl.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<Dio>(() => Dio());

  getIt.registerLazySingleton<PostRepository>(() => PostRepositoryImpl());
}
