import 'package:flutter/material.dart';
import 'package:scout_app/models/lists/shopping_list.dart';
import 'package:scout_app/repositories/lists/shopping_list_repository.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/buttons/custom_button.dart';
import 'package:scout_app/widgets/collections/lists/collaborators_collection.dart';
import 'package:scout_app/widgets/common/custom_bottom_sheet.dart';
import 'package:scout_app/widgets/common/title_text_field.dart';
import 'package:scout_app/widgets/headers/return_header.dart';

class ListDetailsScreen extends StatefulWidget {
  final String listId;

  const ListDetailsScreen({super.key, required this.listId});

  @override
  State<ListDetailsScreen> createState() => _ListDetailsScreenState();
}

class _ListDetailsScreenState extends State<ListDetailsScreen> {
  final _repository = ShoppingListRepository();
  final _titleController = TextEditingController();

  ShoppingList? _list;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadList();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _loadList() async {
    final list = await _repository.getList(widget.listId);
    if (!mounted) return;
    setState(() {
      _list = list;
      _titleController.text = list?.title ?? '';
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ReturnHeader(),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _list == null
                      ? const Center(child: Text('Lista no encontrada'))
                      : _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      color: AppColors.bgSecondary,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Título',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          TitleTextField(
            titleController: _titleController,
            onChanged: () {},
          ),
          const SizedBox(height: 20),
          const Text(
            'Colaboradores',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: ListView(
              children: [
                CollaboratorsCollection(
                  ownerId: _list!.ownerId,
                  collaboratorIds: _list!.collaborators,
                  onRemoveTap: (collaboratorId, displayName) => {
                    _showDeleteCollabSheet(context, collaboratorId, displayName)
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 40, 40, 20),
            child: CustomButton(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              label: 'Agregar colaborador',
              onPressed: () {},//TODO
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteCollabSheet(BuildContext context, String collaboratorId, String displayName) {
    CustomBottomSheet.show(
      context,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),

          Text(
            '¿Eliminar a $displayName?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 24),

          // BOTÓN DE ELIMINAR
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              label: 'SÍ, ELIMINAR',
              onPressed: () async {
                Navigator.pop(context);
                _repository.removeCollaborator(widget.listId, collaboratorId);
                await _loadList(); // recarga la pantalla con los datos frescos
              },
              backgroundColor: AppColors.bgPrimary,
              textColor: AppColors.actionPrimary,
              borderColor: AppColors.bgPrimary,
              borderRadius: 12,
              elevation: 2,
            ),
          ),

          const SizedBox(height: 12),

          // BOTÓN CANCELAR
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              label: 'CANCELAR',
              onPressed: () {
                Navigator.pop(context);
              },
              backgroundColor: AppColors.actionPrimary,
              textColor: AppColors.bgPrimary,
              borderColor: AppColors.actionPrimary,
              borderRadius: 12,
              elevation: 0,
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}