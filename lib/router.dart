//import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/home_screen.dart';
import 'screens/sandbox_screen.dart';
import 'screens/auth_test.dart';
//import 'screens/main_lists.dart';

import 'screens/lists_screen.dart';
import 'screens/list_detail_screen.dart';

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