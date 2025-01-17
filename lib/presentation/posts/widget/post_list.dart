import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinitie_list/common/enums/status_posts.dart';
import 'package:infinitie_list/core/di/service_locator.dart';
import 'package:infinitie_list/shared/bottom_loader.dart';
import 'package:infinitie_list/data/model/repositories/post_repository.dart';

import 'package:infinitie_list/presentation/posts/bloc/post_bloc.dart';
import 'package:infinitie_list/presentation/posts/widget/post_list_item.dart';
import 'package:infinitie_list/shared/search.dart';

class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  State<StatefulWidget> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener((_onScroll));
  }

  @override
  Widget build(BuildContext context) {
    final PostRepository postRepository = getIt<PostRepository>();
    return SingleChildScrollView(
      child: Column(children: [
        const Search(),
        BlocBuilder<PostBloc, PostState>(
            bloc: PostBloc(postRepository)..add(PostFetched()),
            builder: (context, state) {
              switch (state.status) {
                case PostStatus.failure:
                  return const Center(
                      child: Text("Failed to fetch data from API"));
                case PostStatus.success:
                  if (state.posts.isEmpty) {
                    return const Center(child: Text("No post in here"));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return index >= state.posts.length
                          ? const BottomLoader()
                          : PostListItem(post: state.posts[index]);
                    },
                    itemCount: state.isMax
                        ? state.posts.length
                        : state.posts.length + 1,
                    controller: _scrollController,
                  );
                case PostStatus.initial:
                  return const Center(child: CircularProgressIndicator());
              }
            }),
      ]),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<PostBloc>().add(PostFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll) / 0.9;
  }
}
