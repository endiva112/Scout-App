import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/models/lists/shopping_list.dart';
import 'package:scout_app/repositories/lists/shopping_list_repository.dart';
import 'package:scout_app/widgets/footers/simple_list_footer.dart';
import 'package:scout_app/widgets/headers/simple_list_header.dart';
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
    await _repository.saveList(updated);
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
    if (widget.listId == null) {
      setState(() {
        _list = ShoppingList(
          id: '',
          ownerId: FirebaseAuth.instance.currentUser!.uid,
          type: ListType.simple,
          status: ListStatus.shopping,
          title: '',
          collaborators: const [],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        _initialized = true;
      });
      return;
    }

    final list = await _repository.getList(widget.listId!);
    if (!mounted || list == null) return;

    setState(() {
      _list = list;
      _titleController.text = list.title;
      _initialized = true;
    });
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
                Expanded(
                  child: SimplePlanningBody(
                    listId: _list!.id,
                    titleController: _titleController,
                    updatedAt: _list!.updatedAt,
                    onChanged: _onTitleChanged,
                  )
                ),
                SimpleListFooter(listId: _list!.id, mode: widget.mode)
              ],
            ),
          ),
        ),
      ),
    );
  }
}