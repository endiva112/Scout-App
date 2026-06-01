import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scout_app/models/store.dart';
import 'package:scout_app/repositories/store_repository.dart';
import 'package:scout_app/widgets/scout/store_checkbox_item.dart';

class StoresCollection extends StatefulWidget {
  const StoresCollection({super.key});

  @override
  State<StoresCollection> createState() => _StoresCollectionState();
}

class _StoresCollectionState extends State<StoresCollection> {
  final _storeRepository = StoreRepository();
  List<Store> _stores = [];
  Set<String> _selectedIds = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadStores();
  }

  Future<void> _loadStores() async {
    final stores = await _storeRepository.getAllStores();
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('selected_stores') ?? [];
    if (!mounted) return;
    setState(() {
      _stores = stores;
      _selectedIds = saved.toSet();
      _loading = false;
    });
  }

  Future<void> _onChanged(String storeId, bool selected) async {
    setState(() {
      if (selected) {
        _selectedIds.add(storeId);
      } else {
        _selectedIds.remove(storeId);
      }
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('selected_stores', _selectedIds.toList());
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());

    return ListView.separated(
      shrinkWrap: true,
      itemCount: _stores.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, index) {
        final store = _stores[index];
        return StoreCheckboxItem(
          label: store.name,
          value: _selectedIds.contains(store.id),
          onChanged: (val) => _onChanged(store.id, val ?? false),
        );
      },
    );
  }
}