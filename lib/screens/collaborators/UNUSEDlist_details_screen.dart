import 'package:flutter/material.dart';

class ListDetailsScreen extends StatefulWidget {
  const ListDetailsScreen({super.key});

  static const String routeName = 'agregar-colaborador';
  static const String routePath = '/agregarColaborador';

  @override
  State<ListDetailsScreen> createState() => _ListDetailsScreenState();
}

class _ListDetailsScreenState extends State<ListDetailsScreen> {
  final _titleController = TextEditingController(text: 'Compras de la semana');

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(),
            Expanded(
              child: Container(
                color: const Color(0xFFF1F4F8),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),
                    const _SectionLabel('Título'),
                    _TitleField(controller: _titleController),
                    const SizedBox(height: 10),
                    const _SectionLabel('Colaboradores'),
                    const SizedBox(height: 5),
                    const Expanded(child: _CollaboratorList()),
                    const SizedBox(height: 5),
                    _AddButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Header ───────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      constraints: const BoxConstraints(minHeight: 70),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: const [
          Icon(Icons.arrow_back, size: 40, color: Colors.black),
          SizedBox(width: 20),
          Text(
            'Editar lista',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}

// ── Section label ─────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, fontFamily: 'Inter'),
    );
  }
}

// ── Title text field ──────────────────────────────────────────────────────────

class _TitleField extends StatelessWidget {
  const _TitleField({required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(12),
    );

    return TextFormField(
      controller: controller,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'Inter',
      ),
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Colors.white,
        hintText: 'TextField',
        enabledBorder: border,
        focusedBorder: border,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

// ── Collaborator list ─────────────────────────────────────────────────────────

class _CollaboratorList extends StatelessWidget {
  const _CollaboratorList();

  // accent3 in FlutterFlow default theme is typically a light grey border color
  //static const Color _accent = Color(0xFFE0E3E7);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 40),
      children: [
        // Owner row (top rounded)
        _CollabTile(
          name: 'Enrique (Yo)',
          trailing: const _OwnerBadge(),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          topBorder: true,
        ),
        // Collaborator with long name
        _CollabTile(
          name: 'Michael el del nombre tan largo que da miedo, '
              'a ver como se comporta esto',
          trailing: const _RemoveIcon(),
        ),
        // Pending invitations row
        _CollabTile(
          leading: const Text(
            '2',
            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Inter'),
          ),
          name: 'invitaciones pendiente...',
          trailing: const _RemoveIcon(),
        ),
        // Last collaborator (bottom rounded)
        _CollabTile(
          name: 'User0874A',
          trailing: const _RemoveIcon(),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          bottomBorder: true,
        ),
        const SizedBox(height: 8),
        // Standalone bordered card (duplicate owner — as designed)
        _StandaloneOwnerCard(),
      ],
    );
  }
}

// ── Generic collaborator tile ─────────────────────────────────────────────────

class _CollabTile extends StatelessWidget {
  const _CollabTile({
    this.leading,
    required this.name,
    required this.trailing,
    this.borderRadius = BorderRadius.zero,
    this.topBorder = false,
    this.bottomBorder = false,
  });

  final Widget? leading;
  final String name;
  final Widget trailing;
  final BorderRadius borderRadius;
  final bool topBorder;
  final bool bottomBorder;

  static const Color _accent = Color(0xFFE0E3E7);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: _accent, borderRadius: borderRadius),
      padding: EdgeInsets.fromLTRB(
        2,
        topBorder ? 2 : 0,
        2,
        bottomBorder ? 2 : 0,
      ),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            if (leading != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: leading!,
              ),
            ],
            Expanded(
              child: Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontFamily: 'Inter'),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}

// ── Standalone owner card (bordered) ─────────────────────────────────────────

class _StandaloneOwnerCard extends StatelessWidget {
  static const Color _accent = Color(0xFFE0E3E7);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _accent, width: 2),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: const [
          Expanded(
            child: Text(
              'Enrique (Yo)',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontFamily: 'Inter'),
            ),
          ),
          _OwnerBadge(),
        ],
      ),
    );
  }
}

// ── Small reusable widgets ────────────────────────────────────────────────────

class _OwnerBadge extends StatelessWidget {
  const _OwnerBadge();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        'PROPIETARIO',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: Color(0xFF57636C),
          fontFamily: 'Inter',
        ),
      ),
    );
  }
}

class _RemoveIcon extends StatelessWidget {
  const _RemoveIcon();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Icon(Icons.close_rounded, color: Colors.black),
    );
  }
}

// ── Add collaborator button ───────────────────────────────────────────────────

class _AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFEE8B60),
            padding: const EdgeInsets.all(16),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Color(0xFFEE8B60)),
            ),
          ),
          child: const Text(
            'Agregar colaborador',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ),
    );
  }
}