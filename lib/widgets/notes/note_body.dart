import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/bordered_container.dart';

class NoteBody extends StatefulWidget {
  const NoteBody({super.key});

  @override
  State<NoteBody> createState() => _NoteBodyState();
}

class _NoteBodyState extends State<NoteBody> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      child: BorderedContainer(
        borderColor: AppColors.contrastSecondary,
        borderWidth: 2,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: TextFormField(
            focusNode: _focusNode,
            autofocus: false,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            cursorColor: AppColors.textPrimary,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.textPrimary, height: 1.5,),
            decoration: InputDecoration(
              hintText: 'Escribe aquí...',
              hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
              filled: true,
              fillColor: Colors.transparent,
              isDense: true,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            )
          ),
        )
      )
    );
  }
}