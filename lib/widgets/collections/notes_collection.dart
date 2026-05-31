import 'package:flutter/material.dart';
import 'package:scout_app/widgets/cards/note_card.dart';
import 'package:scout_app/widgets/default_tip_text.dart';
import 'package:scout_app/constants/note_icons.dart';

class NotesCollection extends StatelessWidget {
  const NotesCollection({super.key});

  // TODO: reemplazar por llamada a Firestore
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 150),
      itemCount: _items.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (_, index) => _items[index],
    );
  }

  List<Widget> get _items => [

    NoteCard(title: 'Regalo para Alex', date: '9 Mayo 2026', icon: NoteIcon.birthday, noteId: 'aabbccddeeff'),
    NoteCard(title: 'Regalo para Alex', date: '9 Mayo 2026', icon: NoteIcon.birthday, noteId: 'aabbccddeeff'),

    DefaultTipText(tip: 'CREA LISTAS DE DESEADOS Y ORGANIZA FÁCILMENTE COMPARACIONES DE PRECIOS'),
  ];
}