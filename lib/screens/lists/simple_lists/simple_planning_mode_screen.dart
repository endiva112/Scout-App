import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/models/shopping_list.dart';
import 'package:scout_app/models/division.dart';
import 'package:scout_app/repositories/shopping_list_repository.dart';
import 'package:scout_app/widgets/footers/planning_footer.dart';
import 'package:scout_app/widgets/headers/simple_list_header.dart';
import 'package:scout_app/widgets/lists/planning_body.dart';

class SimplePlanningModeScreen extends StatefulWidget {
  final String? listId;

  const SimplePlanningModeScreen({
    super.key,
    this.listId,
  });

  @override
  State<SimplePlanningModeScreen> createState() => _SimplePlanningModeScreenState();
}

class _SimplePlanningModeScreenState extends State<SimplePlanningModeScreen> {
  final _repository = ShoppingListRepository();
  final _titleController = TextEditingController();

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
    super.dispose();
  }

  Future<void> _saveBeforeLeaving() async {
    _saveTimer?.cancel();
    if (_list == null) return;
    final updated = _list!.copyWith(title: _titleController.text);
    await _repository.updateListTitle(updated);
  }

  void _scheduleSave() {
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(seconds: 2), _saveList);
  }

  Future<void> _saveList() async {
    if (_list == null) return;
    final saved = await _repository.updateListTitle(_list!);
    if (mounted) setState(() => _list = saved);
  }

  void _onTitleChanged() {
    if (!_initialized || _list == null) return;
    _list = _list!.copyWith(title: _titleController.text);
    _scheduleSave();
  }

  Future<void> _loadList() async {
    print('🔵 _loadList START, listId: ${widget.listId}');
    // Lista nueva: crear en Firestore inmediatamente
    if (widget.listId == null) {
      print('🔵 Creando lista nueva...');
      final now = DateTime.now();
      final created = await _repository.createList(ShoppingList(
        id: '',
        userId: FirebaseAuth.instance.currentUser!.uid,
        type: ListType.simple,
        status: ListStatus.active,
        title: '',
        updatedAt: now,
        createdAt: now,
        isFavorite: false,
        noteTitle: '',
        noteContent: '',
        noteUpdatedAt: now,
      ));
      print('🟢 Lista creada con id: ${created.id}');

      // Crear división por defecto
      await _repository.createDivision(
        created.id,
        Division(
          id: '',
          name: 'Productos sin tienda',
          isDefault: true,
          sortOrder: 0,
        ),
      );
      print('🟢 División por defecto creada');

      if (!mounted) return;
      setState(() {
        _list = created;
        _initialized = true;
      });
      print('🟢 _initialized = true');
      return;
    }

    // Lista existente
    print('🔵 Cargando lista existente: ${widget.listId}');
    final list = await _repository.getList(widget.listId!);
    print('🟢 Lista cargada: ${list?.id}');
    if (list == null || !mounted) return;
    setState(() {
      _list = list;
      _titleController.text = list.title;
      _initialized = true;
    });
    print('🟢 _initialized = true (existente)');
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return PopScope(
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await _saveBeforeLeaving();
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
                Expanded(child: _buildBody()),
                PlanningFooter(
                  listId: _list!.id,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      color: AppColors.bgSecondary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: PlanningBody(
          listId: _list!.id,
          updatedAt: _list!.updatedAt,
          titleController: _titleController,
          onChanged: _onTitleChanged,
        ),
      ),
    );
  }
}