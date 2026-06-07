import 'package:go_router/go_router.dart';
import 'package:scout_app/screens/profile/set_alias_screen.dart';

// Listas
import 'screens/lists/shopping_lists_screen.dart';
import 'package:scout_app/screens/lists/list_annotation_screen.dart';

// Simples
import 'package:scout_app/screens/lists/simple_lists/simple_list_screen.dart';

// Colaborativas
import 'package:scout_app/screens/lists/collaborative_lists/collaborative_list_screen.dart';

// Recurrentes
// Recortada del PMV

// Pagos
import 'screens/payments/purchased_lists_screen.dart';
import 'screens/payments/collaborative_lists_payments/collaborative_balances_screen.dart';

import 'screens/payments/recurring_lists_payments/recurring_expenses_screen.dart';

// Notas
import 'screens/notes/notes_screen.dart';
import 'screens/notes/note_screen.dart';

// Scout
import 'screens/scout/scout_screen.dart';
import 'screens/scout/scout_missions_screen.dart';
import 'screens/scout/scout_options_screen.dart';

// Perfil
import 'screens/profile/profile_screen.dart';
import 'package:scout_app/screens/profile/set_notifications_screen.dart';
import 'package:scout_app/screens/profile/set_language_screen.dart';
import 'package:scout_app/screens/profile/set_theme_screen.dart';



final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    // Los 4 principales
    GoRoute(
      path: '/',
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


    // Perfil
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/profile/notifications',
      builder: (context, state) => const SetNotificationsScreen(),
    ),
    GoRoute(
      path: '/profile/language',
      builder: (context, state) => const SetLanguageScreen(),
    ),
    GoRoute(
      path: '/profile/theme',
      builder: (context, state) => const SetThemeScreen(),
    ),
    GoRoute(
      path: '/profile/alias',
      builder: (context, state) => const SetAliasScreen(),
    ),


    // Listas simples
    GoRoute(
      path: '/lists/simple_list',
      builder: (context, state) => const SimpleListScreen(),
    ),
    GoRoute(
      path: '/lists/simple_list/:listId',
      builder: (context, state) => SimpleListScreen(
        listId: state.pathParameters['listId']!,
        mode: state.uri.queryParameters['mode'] ?? 'planning',
      ),
    ),
    GoRoute(
      path: '/lists/simple_list/:listId/annotation',
      builder: (context, state) => ListAnnotationScreen(
        listId: state.pathParameters['listId']!,
      ),
    ),

    // Listas colaborativas
    GoRoute(
      path: '/lists/collaborative_list',
      builder: (context, state) => const CollaborativeListScreen(),
    ),
    GoRoute(
      path: '/lists/collaborative_list/:listId',
      builder: (context, state) {
        final listId = state.pathParameters['listId']!;
        final mode = state.uri.queryParameters['mode'] ?? 'planning';
        return CollaborativeListScreen(listId: listId, mode: mode);
      },
    ),


    // Pagos
      // Listas colaborativas
    GoRoute(
      path: '/payments/collaborative_list/balances',
      builder: (context, state) => const CollaborativeBalancesScreen(),
    ),


      // Listas recurrentes
    GoRoute(
      path: '/payments/recurring_lists/expenses',
      builder: (context, state) => const RecurringExpensesScreen(),
    ),

    //Notas
    GoRoute(
      path: '/note',
      builder: (context, state) => NoteScreen(),
    ),
    GoRoute(
      path: '/note/:noteId',
      builder: (context, state) => NoteScreen(
        noteId: state.pathParameters['noteId']!,
      ),
    ),

    // Scout
    GoRoute(
      path: '/scout/options',
      builder: (context, state) => const ScoutOptionsScreen(),
    ),
    GoRoute(
      path: '/scout/missions/:storeId',
      builder: (context, state) => ScoutMissionsScreen(
        storeId: state.pathParameters['storeId']!,
      ),
    ),
  ],
);