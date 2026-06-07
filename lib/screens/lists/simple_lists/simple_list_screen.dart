import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:scout_app/models/lists/division.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/models/lists/shopping_list.dart';
import 'package:scout_app/repositories/lists/shopping_list_repository.dart';
import 'package:scout_app/widgets/footers/simple_list_footer.dart';
import 'package:scout_app/widgets/headers/simple_list_header.dart';
import 'package:scout_app/widgets/lists/editing_session_provider.dart';
import 'package:scout_app/widgets/lists/simple_planning_body.dart';

class SimpleListScreen extends StatefulWidget {
  final String? listId;
  final String mode;

  const SimpleListScreen({
    super.key,
    this.listId,
    this.mode = 'planning',
  });

  @override
  State<SimpleListScreen> createState() => _SimpleListScreenState();
}

class _SimpleListScreenState extends State<SimpleListScreen> {
  final _repository = ShoppingListRepository();
  final _titleController = TextEditingController();

  // El provider vive aquí, no en el build, para poder accederlo desde _saveBeforeLeaving
  final _editingSession = EditingSessionProvider();

  ShoppingList? _list;
  bool _initialized = false;
  Timer? _saveTimer;

  @override
  void initState() {
    super.initState();
    _loadList();
  }

  @override
  void dispose() {
    _saveTimer?.cancel();
    _titleController.dispose();
    _editingSession.dispose();
    super.dispose();
  }

  Future<void> _saveBeforeLeaving() async {
    _saveTimer?.cancel();
    if (_list == null) return;

    // 1. Fuerza el guardado inmediato de todos los items pendientes
    await _editingSession.saveNow();

    // 2. Guarda el título de la lista
    await _repository.saveList(_list!.copyWith(title: _titleController.text));
  }

  void _scheduleSave() {
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(seconds: 2), _saveList);
  }

  Future<void> _saveList() async {
    if (_list == null) return;
    final saved = await _repository.saveList(
      _list!.copyWith(title: _titleController.text),
    );
    if (!mounted) return;
    setState(() => _list = saved ?? _list);
  }

  void _onTitleChanged() {
    if (!_initialized || _list == null) return;
    _list = _list!.copyWith(title: _titleController.text);
    _scheduleSave();
  }

  Future<void> _loadList() async {
    if (widget.listId != null) {
      final list = await _repository.getList(widget.listId!);
      if (!mounted) return;
      if (list == null) return;
      setState(() {
        _list = list;
        _titleController.text = list.title;
        _initialized = true;
      });
      return;
    }

    final newList = ShoppingList(
      id: '',
      ownerId: FirebaseAuth.instance.currentUser!.uid,
      type: ListType.simple,
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

    GoRouter.of(context).go('/lists/simple_list/${saved.id}');
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return PopScope(
      // canPop false para interceptar el botón físico de atrás del sistema
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
                SimpleListHeader(onBeforeReturn: _saveBeforeLeaving),
                Expanded(
                  // .value porque el provider ya está instanciado como campo del State
                  child: ChangeNotifierProvider.value(
                    value: _editingSession,
                    child: SimplePlanningBody(
                      listId: _list!.id,
                      titleController: _titleController,
                      updatedAt: _list!.updatedAt,
                      onChanged: _onTitleChanged,
                    ),
                  ),
                ),
                SimpleListFooter(listId: _list!.id, mode: widget.mode),
              ],
            ),
          ),
        ),
      ),
    );
  }
}