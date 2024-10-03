import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:infinitie_list/posts/bloc/post_bloc.dart';
import 'package:infinitie_list/posts/view/post_list.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => PostBloc(), child: const PostList()),
    );
  }
}
