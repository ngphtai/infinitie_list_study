import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinitie_list/app.dart';
import 'package:infinitie_list/common/extensions/navigationbar.dart';
import 'package:infinitie_list/core/di/service_locator.dart';
import 'package:infinitie_list/data/model/repositories/post_repository.dart';
import 'package:infinitie_list/presentation/counter/view/counter_page.dart';
import 'package:infinitie_list/presentation/counter/view/counter_view.dart';
import 'package:infinitie_list/presentation/counter/view/root_page.dart';
import 'package:infinitie_list/presentation/posts/view/posts_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAPIKey = GlobalKey<NavigatorState>();
final _shellNavigatorCounterKey = GlobalKey<NavigatorState>();
final PostRepository postRepository = getIt<PostRepository>();
final GoRouter router = GoRouter(
  initialLocation: '/api',
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigatorShell) {
        return ScaffoldWithNavigationCustoms(
          navigatorShell: navigatorShell,
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAPIKey,
          routes: [
            GoRoute(
                name: 'post_page',
                path: '/api',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: PostsPage()),
                routes: const [
                  //input detail product in api
                ])
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCounterKey,
          routes: [
            GoRoute(
                name: "counter",
                path: '/counter',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: RootScreen()),
                routes: [
                  GoRoute(
                    name: 'counter detail',
                    path: 'detail',
                    builder: (context, state) => const CounterScreen(),
                  )
                ])
          ],
        )
      ],
    )
  ],
  errorBuilder: (context, state) => App(),
  // routes: [
  //   GoRoute(
  //     path: '/screen1',
  //     name: 'screen',
  //     builder: (context, state) => const Screen(),
  //   ),
  //   GoRoute(
  //     path: '/listAPI',
  //     name: "api",
  //     builder: (context, state) => const PostsPage(),
  //   ),
  // ],
);
