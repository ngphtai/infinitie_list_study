part of 'post_bloc.dart'; // đây là 1 phần của file post_bloc giúp chia nhỏ file nhằm dễ quản lý

sealed class PostEvent extends Equatable {
  // sealed hạn chế mở rộng cho lớp tránh lớp được mở rộng ngoài file này
  @override
  List<Object> get props => [];
}

final class PostFetched extends PostEvent {}

// To recap, our PostBloc will be receiving PostEvents and converting them to PostStates. We have defined all of our PostEvents (PostFetched) so next let’s define our PostState.
