/*import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scout_app/models/note.dart';
import 'package:scout_app/repositories/note_repository.dart';
import 'package:scout_app/constants/note_icons.dart';
import 'package:scout_app/widgets/headers/note_header.dart';
import 'package:scout_app/widgets/notes/note_content.dart';

class ListAnnotationScreen extends StatefulWidget {
  final String? noteId;   //Si viene con id, se edita la nota, si viene sin, se crea una nueva

  const ListAnnotationScreen({
    super.key,
    this.noteId,
  });

  @override
  State<ListAnnotationScreen> createState() => _ListAnnotationScreenState();
}

class _ListAnnotationScreenState extends State<ListAnnotationScreen> {
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
    if (widget.noteId == null) {
      // nota nueva
      setState(() {
        _initialized = true;
      });
      return;
    }

    final note = await _repository.getNote(widget.noteId!); //Esto nunca va a ser nulo
    if (note == null || !mounted) return;
    setState(() {
      _note = Note(
        id: '',
        userId: FirebaseAuth.instance.currentUser!.uid,
        title: '',
        icon: defaultNoteIcon,
        content: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

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
                selectedIcon: _note!.icon,
                onIconChanged: _onIconChanged,
              ),
              Expanded(
                child: NoteContent(
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
}*/