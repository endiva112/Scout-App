import 'package:go_router/go_router.dart';
import 'package:scout_app/screens/notes/notes_screen.dart';
import 'package:scout_app/screens/payments/collaborative_lists_payments/collaborators/info_collaborative_purchase_screen.dart';
import 'package:scout_app/screens/payments/purchased_lists_screen.dart';
import 'package:scout_app/screens/scout/scout_screen.dart';
//import 'oldscreens/home_screen.dart';
import 'oldscreens/sandbox_screen.dart';
import 'oldscreens/auth_test.dart';
import 'screens/lists/shopping_lists_screen.dart';

import 'oldscreens/lists_screen.dart';
import 'oldscreens/list_detail_screen.dart';


final GoRouter router = GoRouter(
  initialLocation: '/lists',
  routes: [
    GoRoute(
      path: '/lists',
      //builder: (context, state) => const HomeScreen(),
      builder: (context, state) => const ShoppingListsScreen(),
    ),
    GoRoute(
      path: '/payments',
      builder: (context, state) => const PurchasedListsScreen(),
    ),
    GoRoute(
      path: '/notes',
      builder: (context, state) => const NotesScreen(),
    ),
    GoRoute(
      path: '/scout',
      builder: (context, state) => const ScoutScreen(),
    ),
    GoRoute(
      path: '/test',
      builder: (context, state) => const InfoCollaborativePurchaseScreen(),
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