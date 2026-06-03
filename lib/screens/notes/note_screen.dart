import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/models/note.dart';
import 'package:scout_app/repositories/note_repository.dart';
import 'package:scout_app/constants/note_icons.dart';
import 'package:scout_app/widgets/headers/note_header.dart';
import 'package:scout_app/widgets/notes/note_content.dart';

class NoteScreen extends StatefulWidget {
  final String noteId;
  final bool isListNote;

  const NoteScreen({
    super.key,
    required this.noteId,
    this.isListNote = false,
  });

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final _repository = NoteRepository();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  Note? _note;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _loadNote();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _loadNote() async {
    final note = await _repository.getNote(widget.noteId);
    if (note == null || !mounted) return;
    setState(() {
      _note = note;
      _titleController.text = note.title;
      _contentController.text = note.content;
      _initialized = true;
    });
  }

  void _onChanged() {
    if (!_initialized || _note == null) return;
    final updated = _note!.copyWith(
      title: _titleController.text,
      content: _contentController.text,
    );
    _repository.updateNote(updated);
  }

  void _onIconChanged(NoteIcon icon) {
    if (_note == null) return;
    final updated = _note!.copyWith(icon: icon);
    setState(() => _note = updated);
    _repository.updateNote(updated);
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.bgPrimary,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NoteHeader(
                isListNote: widget.isListNote,
                selectedIcon: _note!.icon,
                onIconChanged: _onIconChanged,
              ),
              Expanded(
                child: NoteContent(
                  isListNote: widget.isListNote,
                  titleController: _titleController,
                  contentController: _contentController,
                  updatedAt: _note!.updatedAt,
                  onChanged: _onChanged,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}