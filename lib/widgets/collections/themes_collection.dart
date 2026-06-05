import 'package:flutter/material.dart';
import 'package:scout_app/widgets/profile/checkbox_item.dart';

class ThemesCollection extends StatefulWidget {
  const ThemesCollection({super.key});

  @override
  State<ThemesCollection> createState() => _ThemesCollectionState();
}

class _ThemesCollectionState extends State<ThemesCollection> {
  final List<String> _themes = ['Modo oscuro desactivado'];//, 'Modo oscuro activado' FIX
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