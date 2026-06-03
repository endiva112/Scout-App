import 'package:flutter/material.dart';

enum NoteIcon {
  work,
  home,
  school,
  health,
  finance,
  travel,
  food,
  sport,
  music,
  personal,
  birthday,
  note
}

const Map<NoteIcon, IconData> noteIconData = {
  NoteIcon.work:     Icons.work_rounded,
  NoteIcon.home:     Icons.home_rounded,
  NoteIcon.school:   Icons.school_rounded,
  NoteIcon.health:   Icons.favorite_rounded,
  NoteIcon.finance:  Icons.account_balance_rounded,
  NoteIcon.travel:   Icons.flight_rounded,
  NoteIcon.food:     Icons.restaurant_rounded,
  NoteIcon.sport:    Icons.sports_soccer_rounded,
  NoteIcon.music:    Icons.music_note_rounded,
  NoteIcon.personal: Icons.person_rounded,
  NoteIcon.birthday: Icons.cake_rounded,
  NoteIcon.note:     Icons.insert_drive_file_rounded
};

// Icono por defecto para notas nuevas
const NoteIcon defaultNoteIcon = NoteIcon.personal;