import 'dart:convert';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart'; //
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:infinitie_list/posts/models/posts.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:http/http.dart' as http;

part 'post_event.dart';
part 'post_state.dart';

const throttleDuration = Duration(seconds: 100);
const _limit = 20;

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration),
        mapper); // droppable là một transformer để bỏ qua các event đã bị lọc bởi transformer này
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(const PostState()) {
    on<PostFetched>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onPostFetched(
      PostFetched event, Emitter<PostState> emit) async {
    if (state.isMax) return;

    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts(startIndex: 0);

        return emit(state.copyWith(
            status: PostStatus.success, posts: posts, isMax: false));
      }

      final posts = await _fetchPosts(startIndex: state.posts.length);
      emit(posts.isEmpty
          ? state.copyWith(isMax: true)
          : state.copyWith(
              status: PostStatus.success,
              posts: List.of(state.posts)..addAll(posts),
              isMax: false));
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
      print(_.toString());
    }
  }

  final dio = Dio();

  Future<List<Posts>> _fetchPosts({required int startIndex}) async {
    final response = await dio.get('https://jsonplaceholder.typicode.com/posts',
        queryParameters: {'_start': '$startIndex', '_limit': '$_limit'});

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
    throw Exception("Error fetching posts");
  }
}
