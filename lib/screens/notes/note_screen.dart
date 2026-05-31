import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/bordered_container.dart';
import 'package:scout_app/widgets/headers/note_header.dart';


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

            // Componentes de esta página
            children: [
              NoteHeader(isListNote: isListNote),
              Expanded(child: _buildBody(context)),
            ]
          )
        )
      )
    );
  }

  // Cuerpo de la vista
  Widget _buildBody(BuildContext context) {
    return Container(
      color: AppColors.bgSecondary,
      child: Padding(
        padding: const EdgeInsetsGeometry.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            _buildTitle(),
            SizedBox(height: 10),
            _buildLastModifiedText(),
            SizedBox(height: 10),
            Expanded(child: _buildNoteBody())
          ]
        )
      )
    );
  }

  Widget _buildTitle() {
    return TextFormField(
      autofocus: false,
      maxLines: 3,
      minLines: 1,
      cursorColor: AppColors.textPrimary,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: 'Título',
        hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.textSecondary),
        filled: true,
        fillColor: AppColors.bgPrimary,
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
      )
    );
  }

  Widget _buildLastModifiedText() {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 20),
      child: Text(
        '25 Abril 2025',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic), textAlign: TextAlign.start,
      )
    );
  }

  Widget _buildNoteBody() {
    return BorderedContainer(
      borderColor: AppColors.contrastSecondary,
      borderWidth: 2,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          autofocus: false,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          cursorColor: AppColors.textPrimary,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.textPrimary,
            height: 1.5,
          ),
          decoration: InputDecoration(
            hintText: 'Escribe aquí...',
            hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.textSecondary),
            filled: true,
            fillColor: Colors.transparent,
            isDense: true,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}