import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart'; //
import 'package:equatable/equatable.dart';
import 'package:infinitie_list/common/enums/status_posts.dart';
import 'package:infinitie_list/data/model/models/posts.dart';
import 'package:infinitie_list/data/model/repositories/post_repository.dart';

import 'package:stream_transform/stream_transform.dart';

part 'post_event.dart';
part 'post_state.dart';

const throttleDuration = Duration(seconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration),
        mapper); // droppable là một transformer để bỏ qua các event đã bị lọc bởi transformer này
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc(this.postRepository) : super(const PostState()) {
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
        final posts = await postRepository.fetchPosts(startIndex: 0);

        return emit(state.copyWith(
            status: PostStatus.success, posts: posts, isMax: false));
      }

      final posts =
          await postRepository.fetchPosts(startIndex: state.posts.length);
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
}
