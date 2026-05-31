import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/common/bordered_container.dart';

class NoteBody extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onChanged;

  const NoteBody({
    super.key,
    required this.controller,
    required this.onChanged,
  });

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
            controller: widget.controller,
            onChanged: (_) => widget.onChanged(),
            focusNode: _focusNode,
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
            decoration: const InputDecoration(
              hintText: 'Escribe aquí...',
              hintStyle: TextStyle(
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
            ),
          ),
        ),
      ),
    );
  }
}