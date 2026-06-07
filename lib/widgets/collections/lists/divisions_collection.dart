import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scout_app/models/lists/division.dart';
import 'package:scout_app/repositories/lists/shopping_list_repository.dart';
import 'package:scout_app/widgets/cards/division_card.dart';
import 'package:scout_app/widgets/lists/editing_session_provider.dart';

class DivisionsCollection extends StatefulWidget {
  final String listId;

  const DivisionsCollection({super.key, required this.listId});

  @override
  State<DivisionsCollection> createState() => _DivisionsCollectionState();
}

class _DivisionsCollectionState extends State<DivisionsCollection> {
  final _repository = ShoppingListRepository();
  StreamSubscription<List<Division>>? _subscription;
  List<Division> _divisions = [];
  bool _loading = true;
  bool _wasEditing = false;

  @override
  void initState() {
    super.initState();
    _subscribe();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final isEditing = context.watch<EditingSessionProvider>().isEditing;

    if (isEditing && !_wasEditing) {
      // El usuario empezó a editar → cancelamos el stream
      _subscription?.cancel();
      _subscription = null;
    } else if (!isEditing && _wasEditing) {
      // El usuario terminó de editar (el timer disparó y guardó) → reactivamos
      _subscribe();
    }

    _wasEditing = isEditing;
  }

  void _subscribe() {
    _subscription = _repository
        .getDivisions(widget.listId)
        .listen((divisions) {
      if (!mounted) return;
      setState(() {
        _divisions = divisions;
        _loading = false;
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());

    if (_divisions.isEmpty) return const SizedBox.shrink();

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _divisions.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, index) {
        final division = _divisions[index];
        return DivisionCard(
          key: ValueKey(division.id), // key estable por ID
          listId: widget.listId,
          division: division,
          onDelete: () async {
            await _repository.deleteDivision(widget.listId, division.id);
            await _repository.decrementDivisionCount(widget.listId);
          },
        );
      },
    );
  }
}