import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scout_app/models/note.dart';
import 'package:scout_app/repositories/note_repository.dart';
import 'package:scout_app/constants/note_icons.dart';
import 'package:scout_app/widgets/headers/note_header.dart';
import 'package:scout_app/widgets/notes/note_content.dart';

class NoteScreen extends StatefulWidget {
  final String? noteId;   //Si viene con id, se edita la nota, si viene sin, se crea una nueva

  const NoteScreen({
    super.key,
    this.noteId,
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
  Timer? _saveTimer;

  @override
  void initState() {
    super.initState();
    _loadNote();
  }

  @override
  void dispose() {
    _saveTimer?.cancel();
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  // Se asegura de guardar la información cuando el usuario sale de la vista
  Future<void> _saveBeforeLeaving() async {
    _saveTimer?.cancel();

    if (_note == null) return;

    final updated = _note!.copyWith(
      title: _titleController.text,
      content: _contentController.text,
    );

    _note = await _repository.saveNote(updated);
  }

  // Metodos para implementar el debounce y no hacer una escritura por cada caracter
  void _scheduleSave() {
    _saveTimer?.cancel();

    _saveTimer = Timer(
      const Duration(seconds: 2),
      _saveNote,
    );
  }

  Future<void> _saveNote() async {
    if (_note == null) return;

    _note = await _repository.saveNote(_note!);
  }

  //Guardar los datos de la nota .cuerpo
  void _onChanged() {
  if (!_initialized || _note == null) return;

  _note = _note!.copyWith(
    title: _titleController.text,
    content: _contentController.text,
  );

  _scheduleSave();
}

  // Guarda la nota al cambiar el icono
  void _onIconChanged(NoteIcon icon) {
    if (_note == null) return;

    setState(() {
      _note = _note!.copyWith(icon: icon);
    });

    _scheduleSave();
  }

  // Método encargardo de cargar el contenido de una nota
  Future<void> _loadNote() async {
    // Nota nueva
    if (widget.noteId == null) {
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
      return;
    }

    // Nota existente
    final note = await _repository.getNote(widget.noteId!);
    //Si la nota no existe (es null) o el usuario abandona la pantalla antes de que firebase responda, salimos del metodo
    if (note == null || !mounted) return;
    //Se reconstruye la UI con los datos de la
    setState(() {
      _note = note;
      _titleController.text = note.title;
      _contentController.text = note.content;
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
                NoteHeader(
                  selectedIcon: _note!.icon,
                  onIconChanged: _onIconChanged,
                  onBeforeReturn: _saveBeforeLeaving,
                ),
                Expanded(
                  child: NoteContent(
                    titleController: _titleController,
                    contentController: _contentController,
                    updatedAt: _note!.updatedAt,
                    onChanged: _onChanged,
                  )
                )
              ]
            )
          )
        )
      )
    );
  }
}