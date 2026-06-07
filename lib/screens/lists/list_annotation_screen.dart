import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:scout_app/repositories/lists/shopping_list_repository.dart';
import 'package:scout_app/widgets/headers/return_header.dart';
import 'package:scout_app/widgets/lists/annotation_content.dart';

class ListAnnotationScreen extends StatefulWidget {
  final String listId;

  const ListAnnotationScreen({
    super.key,
    required this.listId,
  });

  @override
  State<ListAnnotationScreen> createState() => _ListAnnotationScreenState();
}

class _ListAnnotationScreenState extends State<ListAnnotationScreen> {
  final _repository = ShoppingListRepository();
  final _contentController = TextEditingController();
  Timer? _saveTimer;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _loadAnnotation();
  }

  @override
  void dispose() {
    _saveTimer?.cancel();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _loadAnnotation() async {
    final list = await _repository.getList(widget.listId);
    if (!mounted || list == null) return;
    setState(() {
      _contentController.text = list.annotation;
      _initialized = true;
    });
  }

  Future<void> _saveBeforeLeaving() async {
    _saveTimer?.cancel();
    await _repository.saveAnnotation(
      widget.listId,
      _contentController.text,
    );
  }

  void _scheduleSave() {
    _saveTimer?.cancel();
    _saveTimer = Timer(
      const Duration(seconds: 2),
      () => _repository.saveAnnotation(
        widget.listId,
        _contentController.text,
      ),
    );
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
        if (context.mounted) context.pop();
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
                ReturnHeader(onBeforeReturn: _saveBeforeLeaving),
                Expanded(
                  child: AnnotationContent(
                    contentController: _contentController,
                    onChanged: _scheduleSave,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}