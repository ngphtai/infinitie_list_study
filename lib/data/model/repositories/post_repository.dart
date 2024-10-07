import 'package:infinitie_list/data/model/models/posts.dart';

abstract class PostRepository {
  Future<List<Posts>> fetchPosts({required int startIndex});
}
