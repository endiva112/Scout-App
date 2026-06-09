import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/common/bordered_container.dart';

class CollaboratorsCollection extends StatelessWidget {
  final String ownerId;
  final List<String> collaboratorIds;
  final void Function(String collaboratorId, String displayName)? onRemoveTap;

  const CollaboratorsCollection({
    super.key,
    required this.ownerId,
    required this.collaboratorIds,
    this.onRemoveTap,
  });

  @override
  Widget build(BuildContext context) {
    final allIds = [ownerId, ...collaboratorIds.where((id) => id != ownerId)];

    return BorderedContainer(
      backgroundColor: AppColors.bgPrimary,
      borderWidth: 2,
      borderColor: AppColors.borderAccent,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: allIds.length,
        separatorBuilder: (_, __) => const Divider(height: 1, thickness: 1),
        itemBuilder: (context, index) {
          final uid = allIds[index];
          return _CollaboratorTile(
            uid: uid,
            isOwner: uid == ownerId,
            onRemoveTap: onRemoveTap,
          );
        },
      ),
    );
  }
}

class _CollaboratorTile extends StatefulWidget {
  final String uid;
  final bool isOwner;
  final void Function(String collaboratorId, String displayName)? onRemoveTap;

  const _CollaboratorTile({
    required this.uid,
    required this.isOwner,
    this.onRemoveTap,
  });

  @override
  State<_CollaboratorTile> createState() => _CollaboratorTileState();
}

class _CollaboratorTileState extends State<_CollaboratorTile> {
  String? _displayName;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _loadDisplayName();
  }

  Future<void> _loadDisplayName() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .get();

    if (!mounted) return;

    final alias = doc.data()?['alias'] as String?;
    setState(() {
      _displayName = alias?.isNotEmpty == true
          ? alias
          : 'Scout_${widget.uid.substring(0, 6).toUpperCase()}';
      _loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: _loaded
          ? Text(
              _displayName!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14),
            )
          : const SizedBox(
              height: 12,
              width: 80,
              child: LinearProgressIndicator(),
            ),
      trailing: widget.isOwner
          ? const Text(
              'PROPIETARIO',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            )
          : IconButton(
              icon: const Icon(Icons.close, size: 20),
              onPressed: () => widget.onRemoveTap?.call(
                widget.uid,
                _displayName ?? widget.uid,
              ),
            ),
    );
  }
}