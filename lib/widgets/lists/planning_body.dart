import 'package:flutter/material.dart';
import 'package:scout_app/widgets/cards/planning_group_card.dart';
import 'package:scout_app/widgets/common/last_modified_text.dart';
import 'package:scout_app/widgets/common/title_text_field.dart';


class PlanningBody extends StatelessWidget {
  final DateTime updatedAt;
  final TextEditingController titleController;
  final VoidCallback onChanged;

  const PlanningBody({
    super.key,
    required this.updatedAt,
    required this.titleController,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TitleTextField(titleController: titleController, onChanged: onChanged),
        const SizedBox(height: 10),
        LastModifiedText(updatedAt: updatedAt),
        const SizedBox(height: 10),
        Expanded(child: _buildList())
      ]
    );
  }

  Widget _buildList() {//Sustituir por una coleccion de PlanningGroupCards
    return ListView(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 100),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        PlanningGroupCard(),
        SizedBox(height: 10),
        PlanningGroupCard()
      ]
    );
  }
}