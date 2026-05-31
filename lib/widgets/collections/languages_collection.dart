import 'package:flutter/material.dart';
import 'package:scout_app/widgets/profile/checkbox_item.dart';

class LanguagesCollection extends StatefulWidget {
  const LanguagesCollection({super.key});

  @override
  State<LanguagesCollection> createState() => _LanguagesCollectionState();
}

class _LanguagesCollectionState extends State<LanguagesCollection> {
  final List<String> _themes = ['Español'];//, 'Inglés', 'Portugués' 
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: _themes.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (_, index) => CheckboxItem(
        label: _themes[index],
        value: _selectedIndex == index,
        onChanged: (_) => setState(() => _selectedIndex = index),
      ),
    );
  }
}