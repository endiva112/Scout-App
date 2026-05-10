//import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'oldscreens/home_screen.dart';
import 'oldscreens/sandbox_screen.dart';
import 'oldscreens/auth_test.dart';
//import 'screens/main_lists.dart';

import 'oldscreens/lists_screen.dart';
import 'oldscreens/list_detail_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      //builder: (context, state) => const MainListScreen(),
    ),
    GoRoute(
      path: '/sandbox',
      builder: (context, state) => const SandboxScreen(),
    ),
    GoRoute(
      path: '/authTest',
      builder: (context, state) => const AuthSandboxScreen(),
    ),

    GoRoute(
      path: '/lists',
      builder: (context, state) => const ListsScreen(),
    ),
    GoRoute(
      path: '/list/:listId',
      builder: (context, state) => ListDetailScreen(
        listId: state.pathParameters['listId']!,
      ),
    ),
  ],
);