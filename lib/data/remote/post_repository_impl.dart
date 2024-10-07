import 'package:infinitie_list/common/constants/app_constants.dart';
import 'package:infinitie_list/data/model/models/posts.dart';
import 'package:infinitie_list/data/model/repositories/post_repository.dart';
import 'package:dio/dio.dart';

class PostRepositoryImpl extends PostRepository {
  PostRepositoryImpl();
  final dio = Dio();
  @override
  Future<List<Posts>> fetchPosts({required int startIndex}) async {
    print(
        "gone post repository impl with cac bien chinh la ${AppConstants.api} va $startIndex va ${AppConstants.limit}");
    // final response = await dio.get('${AppConstants.api}/post',
    //     queryParameters: {
    //       '_start': '$startIndex',
    //       '_limit': '${AppConstants.limit}'
    //     });
    final response = await dio.get(
        '${AppConstants.api}/posts?_start=$startIndex&_limit=${AppConstants.limit}');
    // print("${response.realUri} and ${response.data}");
    if (response.statusCode == 200) {
      final body = response.data as List;
      return body.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        return Posts(
          id: map['id'] as int,
          title: map['title'] as String,
          body: map['body'] as String,
        );
      }).toList();
    }
    throw (e) {
      print("error to fetch API: ${e.toString()}");
    };
  }
}
