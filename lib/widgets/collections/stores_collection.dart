import 'package:flutter/material.dart';
import 'package:scout_app/widgets/scout/store_checkbox_item.dart';

class StoresCollection extends StatefulWidget {
  const StoresCollection({super.key});

  @override
  State<StoresCollection> createState() => _StoresCollectionState();
}

class _StoresCollectionState extends State<StoresCollection> {
  final List<Map<String, dynamic>> _stores = [
    {'label': 'Lidl',      'checked': true},
    {'label': 'Dia',       'checked': true},
    {'label': 'Carrefour', 'checked': false},
    {'label': 'Aldi',      'checked': false},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: _stores.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (_, index) {
        final store = _stores[index];
        return StoreCheckboxItem(
          label: store['label'] as String,
          value: store['checked'] as bool,
          onChanged: (val) => setState(() => _stores[index]['checked'] = val ?? false),
        );
      },
    );
  }
}