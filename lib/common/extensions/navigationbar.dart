import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavigationCustoms extends StatelessWidget {
  const ScaffoldWithNavigationCustoms({Key? key, required this.navigatorShell})
      : super(key: key);

  final StatefulNavigationShell navigatorShell;

  void _onBranch(int index) {
    navigatorShell.goBranch(
      index,
      initialLocation: index == navigatorShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigatorShell,
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.api_outlined), label: "GetAPI"),
          NavigationDestination(icon: Icon(Icons.circle), label: "Counter"),
        ],
        onDestinationSelected: _onBranch,
      ),
    );
  }
}
