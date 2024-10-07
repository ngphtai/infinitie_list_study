part of 'post_bloc.dart';

final class PostState extends Equatable {
  const PostState(
      {this.status = PostStatus.initial,
      this.posts = const <Posts>[],
      this.isMax = false});

  final PostStatus status;
  final List<Posts> posts;
  final bool isMax;

  PostState copyWith({
    PostStatus? status,
    List<Posts>? posts,
    bool? isMax,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      isMax: isMax ?? this.isMax,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, posts: $posts, isMax: $isMax}''';
  }

  @override
  List<Object> get props => [status, posts, isMax];
}
