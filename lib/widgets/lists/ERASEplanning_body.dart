/*
import 'package:flutter/material.dart';
import 'package:scout_app/models/division.dart';
import 'package:scout_app/repositories/shopping_list_repository.dart';
import 'package:scout_app/widgets/buttons/add_group_button.dart';
import 'package:scout_app/widgets/cards/planning_group_card.dart';
import 'package:scout_app/widgets/common/last_modified_text.dart';
import 'package:scout_app/widgets/common/title_text_field.dart';


class PlanningBody extends StatefulWidget {
  final String listId;
  final DateTime updatedAt;
  final TextEditingController titleController;
  final VoidCallback onChanged;

  const PlanningBody({
    super.key,
    required this.listId,
    required this.updatedAt,
    required this.titleController,
    required this.onChanged,
  });

  @override
  State<PlanningBody> createState() => _PlanningBodyState();
}

class _PlanningBodyState extends State<PlanningBody> {
  final _repository = ShoppingListRepository();

  Future<void> _addDivision(int currentCount) async {
    if (widget.listId.isEmpty) return;

    await _repository.createDivision(
      widget.listId,
      Division(
        id: '',
        name: '',
        isDefault: currentCount == 0,
        sortOrder: currentCount,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TitleTextField(titleController: widget.titleController, onChanged: widget.onChanged),
        const SizedBox(height: 10),
        LastModifiedText(updatedAt: widget.updatedAt),
        const SizedBox(height: 10),
        Expanded(child: _buildDivisions()),
      ],
    );
  }

  Widget _buildDivisions() {
    return StreamBuilder<List<Division>>(
      stream: _repository.getDivisions(widget.listId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final divisions = snapshot.data ?? [];

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 100),
          itemCount: divisions.length + 1,
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          itemBuilder: (_, index) {
            if (index == divisions.length) {
              return AddGroupButton(
                onTap: () => _addDivision(divisions.length),
              );
            }
            return PlanningGroupCard(
              division: divisions[index],
              listId: widget.listId,
            );
          },
        );
      },
    );
  }
}*/