import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:scout_app/models/lists/division.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/models/lists/shopping_list.dart';
import 'package:scout_app/repositories/lists/shopping_list_repository.dart';
import 'package:scout_app/widgets/footers/collaborative_list_footer.dart';
import 'package:scout_app/widgets/headers/collaborative_list_header.dart';
import 'package:scout_app/widgets/lists/collaborative_planning_body.dart';
import 'package:scout_app/widgets/lists/collaborative_shopping_body.dart';
import 'package:scout_app/widgets/lists/editing_session_provider.dart';

class CollaborativeListScreen extends StatefulWidget {
  final String? listId;
  final String mode;

  const CollaborativeListScreen({
    super.key,
    this.listId,
    this.mode = 'planning',
  });

  @override
  State<CollaborativeListScreen> createState() => _CollaborativeListScreenState();
}

class _CollaborativeListScreenState extends State<CollaborativeListScreen> {
  final _repository = ShoppingListRepository();
  final _editingSession = EditingSessionProvider();

  ShoppingList? _list;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _loadList();
  }

  @override
  void dispose() {
    _editingSession.dispose();
    super.dispose();
  }

  Future<void> _saveBeforeLeaving() async {
    await _editingSession.saveNow();
  }

  Future<void> _loadList() async {
    if (widget.listId != null) {
      final list = await _repository.getList(widget.listId!);
      if (!mounted) return;
      if (list == null) return;
      setState(() {
        _list = list;
        _initialized = true;
      });
      return;
    }

    final newList = ShoppingList(
      id: '',
      ownerId: FirebaseAuth.instance.currentUser!.uid,
      type: ListType.collaborative,
      status: ListStatus.shopping,
      title: '',
      collaborators: const [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final saved = await _repository.saveList(newList);
    if (!mounted) return;
    if (saved == null) return;

    await _repository.saveDivision(
      saved.id,
      const Division(id: '', name: 'Sin tienda asignada'),
    );

    await _repository.incrementDivisionCount(saved.id);
    if (!mounted) return;

    GoRouter.of(context).go('/lists/collaborative_list/${saved.id}');
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await _saveBeforeLeaving();
        if (context.mounted) context.go('/');
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.bgPrimary,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CollaborativeListHeader(
                  onBeforeReturn: _saveBeforeLeaving,
                  listId: _list!.id,
                ),
                Expanded(
                  child: ChangeNotifierProvider.value(
                    value: _editingSession,
                    child: widget.mode == 'shopping'
                        ? CollaborativeShoppingBody(
                            listId: _list!.id,
                            updatedAt: _list!.updatedAt,
                          )
                        : CollaborativePlanningBody(
                            listId: _list!.id,
                            updatedAt: _list!.updatedAt,
                          ),
                  ),
                ),
                CollaborativeListFooter(
                  onBeforeReturn: _saveBeforeLeaving,
                  listId: _list!.id,
                  mode: widget.mode,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}