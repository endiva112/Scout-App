import 'package:go_router/go_router.dart';

// Listas
import 'screens/lists/shopping_lists_screen.dart';

// Simples
import 'package:scout_app/screens/lists/simple_lists/simple_planning_mode_screen.dart';
import 'package:scout_app/screens/lists/simple_lists/simple_shopping_mode_screen.dart';

// Colaborativas
import 'package:scout_app/screens/lists/collaborative_lists/collaborative_planning_mode_screen.dart';
import 'package:scout_app/screens/lists/collaborative_lists/collaborative_shopping_mode_screen.dart';

// Recurrentes
import 'package:scout_app/screens/lists/recurring_lists/recurring_planning_mode_screen.dart';

// Pagos
import 'screens/payments/purchased_lists_screen.dart';
import 'screens/payments/collaborative_lists_payments/collaborators/info_collaborative_purchase_screen.dart';

// Notas
import 'screens/notes/notes_screen.dart';

// Scout
import 'screens/scout/scout_screen.dart';

// Perfil
import 'screens/profile/unregistered_profile_screen.dart';



//import 'oldscreens/home_screen.dart';
import 'oldscreens/sandbox_screen.dart';
import 'oldscreens/auth_test.dart';
import 'oldscreens/lists_screen.dart';
import 'oldscreens/list_detail_screen.dart';


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
      builder: (context, state) => const UnregisteredProfileScreen(),
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
      builder: (context, state) => ListDetailScreen(
        listId: state.pathParameters['listId']!,
      ),
    ),
  ],
);