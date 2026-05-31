import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/repositories/note_repository.dart';
import 'package:scout_app/widgets/collections/notes_collection.dart';
import 'package:scout_app/widgets/buttons/floating_create_button.dart';
import 'package:scout_app/widgets/headers/main_header.dart';
import 'package:scout_app/widgets/common/simple_title.dart';
import 'package:scout_app/widgets/footers/bottom_navbar.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final _repository = NoteRepository();

  Future<void> _createNote() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final noteId = await _repository.createNote(userId);
    if (mounted) context.push('/note/$noteId');
  }

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
              MainHeader(),
              Expanded(child: _buildBody(context)),
              BottomNavBar(activeIndex: 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      color: AppColors.bgSecondary,
      child: Stack(
        children: [
          _buildBodyContent(),
          FloatingCreateButton(onTap: _createNote),
        ],
      ),
    );
  }

  Widget _buildBodyContent() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SimpleTitle(title: 'Mis notas'),
        Expanded(child: NotesCollection()),
      ],
    );
  }
}