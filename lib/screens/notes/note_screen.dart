import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/headers/note_header.dart';
import 'package:scout_app/widgets/notes/note_content.dart';

class NoteScreen extends StatelessWidget {
  final bool isListNote;

  const NoteScreen({super.key, this.isListNote = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.bgPrimary,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NoteHeader(isListNote: isListNote),
              Expanded(
                child: NoteContent(isListNote: isListNote),
              ),
            ],
          ),
        ),
      ),
    );
  }
}