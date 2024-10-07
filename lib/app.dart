import 'package:flutter/material.dart';
import 'package:infinitie_list/core/routing/routers.dart';
import 'package:infinitie_list/presentation/posts/view/posts_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
