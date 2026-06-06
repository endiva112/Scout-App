/*
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

  print('💾 SAVE LIST');

  final updated = await _repository.saveList(
    _list!.copyWith(title: _titleController.text),
  );

  if (!mounted) return;

  setState(() {
    _list = updated ?? _list;
  });
}

  void _onTitleChanged() {
    if (!_initialized || _list == null) return;
    _list = _list!.copyWith(title: _titleController.text);
    _scheduleSave();
  }

  Future<void> _loadList() async {
    print('🟡 LOAD LIST START');

    if (widget.listId == null) {
      print('🆕 NEW LIST DRAFT');

      setState(() {
        _list = ShoppingList(
          id: '',
          userId: FirebaseAuth.instance.currentUser!.uid,
          ownerId: FirebaseAuth.instance.currentUser!.uid,
          members: [FirebaseAuth.instance.currentUser!.uid],
          type: ListType.simple,
          status: ListStatus.active,
          title: '',
          updatedAt: DateTime.now(),
          createdAt: DateTime.now(),
          isFavorite: false,
          noteTitle: '',
          noteContent: '',
          noteUpdatedAt: DateTime.now(),
        );

        _initialized = true;
      });

      return;
    }

    print('📥 LOADING EXISTING LIST');

    final list = await _repository.getList(widget.listId!);

    if (!mounted || list == null) return;

    setState(() {
      _list = list;
      _titleController.text = list.title;
      _initialized = true;
    });

    print('🟢 LIST LOADED');
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
}*/