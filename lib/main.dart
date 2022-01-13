import 'package:checklist_app/page/auth/login_page.dart';
import 'package:checklist_app/page/auth/register_page.dart';
import 'package:checklist_app/page/todos/all_todos_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

void main() {
  Vx.setPathUrlStrategy();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: navigator,
      routeInformationParser: VxInformationParser(),
    );
  }
}

class MyObs extends VxObserver {
  @override
  void didChangeRoute(Uri route, Page page, String pushOrPop) {
    print("${route.path} - $pushOrPop");
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    print('Pushed a route');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    print('Popped a route');
  }
}

final navigator = VxNavigator(
  notFoundPage: (uri, params) => MaterialPage(
    key: const ValueKey('not-found-page'),
    child: Builder(
      builder: (context) => Scaffold(
        body: Center(
          child: Text('Page ${uri.path} not found'),
        ),
      ),
    ),
  ),
  observers: [MyObs()],
  routes: {
    '/': (uri, params) => const MaterialPage(child: LoginPage()),
    '/register': (uri, params) => const MaterialPage(child: RegisterPage()),
    '/todos/list': (uri, params) => const MaterialPage(child: TodoListPage()),
  },
);
