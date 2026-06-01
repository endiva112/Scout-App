import 'package:go_router/go_router.dart';
import 'package:scout_app/screens/lists/list_details_screen.dart';
import 'package:scout_app/screens/payments/collaborative_lists_payments/collaborative_expenses_screen.dart';
import 'package:scout_app/screens/profile/set_alias_screen.dart';


// Listas
import 'screens/lists/shopping_lists_screen.dart';

// Simples
import 'screens/lists/simple_lists/simple_planning_mode_screen.dart';
import 'screens/lists/simple_lists/simple_shopping_mode_screen.dart';

// Colaborativas
import 'screens/lists/collaborative_lists/collaborative_planning_mode_screen.dart';
import 'screens/lists/collaborative_lists/collaborative_shopping_mode_screen.dart';

// Recurrentes
import 'screens/lists/recurring_lists/recurring_planning_mode_screen.dart';

// Pagos
import 'screens/payments/purchased_lists_screen.dart';

import 'screens/payments/collaborative_lists_payments/collaborators/info_collaborative_purchase_screen.dart';
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


//import 'oldscreens/home_screen.dart';
import 'oldscreens/sandbox_screen.dart';
import 'oldscreens/auth_test.dart';
import 'oldscreens/lists_screen.dart';
import 'oldscreens/old_list_detail_screen.dart';


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
      path: '/lists/simple_lists/shopping',
      builder: (context, state) => const SimpleShoppingModeScreen(),
    ),
    GoRoute(
      path: '/lists/simple_lists/planning',
      builder: (context, state) => const SimplePlanningModeScreen(),
    ),
    GoRoute(
      path: '/lists/simple_lists/notes',
      builder: (context, state) => NoteScreen(
        noteId: state.pathParameters['noteId']!,
        isListNote: true,
      ),
    ),


    // Listas colaborativas
    GoRoute(
      path: '/lists/collaborative_lists/shopping',
      builder: (context, state) => const CollaborativeShoppingModeScreen(),
    ),
    GoRoute(
      path: '/lists/collaborative_lists/planning',
      builder: (context, state) => const CollaborativePlanningModeScreen(),
    ),

    // Listas recurrentes
    GoRoute(
      path: '/lists/recurring_lists/planning',
      builder: (context, state) => const RecurringPlanningModeScreen(),
    ),
    GoRoute(
      path: '/lists/collaborative_lists/expenses',
      builder: (context, state) => const CollaborativeExpensesScreen(),
    ),
    GoRoute(
      path: '/lists/collaborative_lists/notes/:noteId',
      builder: (context, state) => NoteScreen(
        noteId: state.pathParameters['noteId']!,
        isListNote: true,
      ),
    ),
    GoRoute(
      path: '/lists/collaborative_lists/list_details',
      builder: (context, state) => const ListDetailsScreen(),
    ),


    // Pagos
      // Listas colaborativas
    GoRoute(
      path: '/payments/collaborative_lists/balances',
      builder: (context, state) => const CollaborativeBalancesScreen(),
    ),


      // Listas recurrentes
    GoRoute(
      path: '/payments/recurring_lists/expenses',
      builder: (context, state) => const RecurringExpensesScreen(),
    ),

    //Notas
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



    //TODO BORRAR
    GoRoute(
      path: '/test',
            //builder: (context, state) => const HomeScreen(),
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
      builder: (context, state) => OldListDetailScreen(
        listId: state.pathParameters['listId']!,
      ),
    ),
  ],
);