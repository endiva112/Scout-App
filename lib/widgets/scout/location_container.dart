import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';

class LocationContainer extends StatefulWidget {
  const LocationContainer({super.key});

  @override
  State<LocationContainer> createState() => _LocationContainerState();
}

class _LocationContainerState extends State<LocationContainer> {
  final _paisController   = TextEditingController(text: 'País');
  final _regionController = TextEditingController(text: 'Región');
  final _ciudadController = TextEditingController(text: 'Ciudad');

  @override
  void dispose() {
    _paisController.dispose();
    _regionController.dispose();
    _ciudadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildField(_paisController,   'País'),
        const SizedBox(height: 10),
        _buildField(_regionController, 'Región'),
        const SizedBox(height: 10),
        _buildField(_ciudadController, 'Ciudad'),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _onSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.contrastSecondary,
            foregroundColor: AppColors.actionSecondary,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          child: const Text(
            'GUARDAR UBICACIÓN',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }

  Widget _buildField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      style: TextStyle(color: AppColors.textPrimary, fontSize: 16),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.textTerciary),
        filled: true,
        fillColor: AppColors.bgPrimary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  void _onSave() {
    // TODO: persistir ubicación
    FocusScope.of(context).unfocus();
  }
}