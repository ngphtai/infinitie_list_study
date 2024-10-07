import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinitie_list/core/di/service_locator.dart';
import 'package:infinitie_list/core/utils/home_drawer.dart';
import 'package:infinitie_list/data/model/repositories/post_repository.dart';
import 'package:infinitie_list/presentation/posts/bloc/post_bloc.dart';
import 'package:infinitie_list/core/routing/routers.dart';
import 'package:infinitie_list/presentation/posts/widget/post_list.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    print("Screen has been print");
    final PostRepository postRepository = getIt<PostRepository>();
    return MaterialApp.router(
        routerConfig: router,
        builder: (context, state) => SafeArea(
              child: Scaffold(
                appBar: AppBar(title: const Text("Get API example")),
                body: BlocProvider(
                    create: (context) => PostBloc(postRepository),
                    child: const PostList()),
              ),
            ));
  }
}
