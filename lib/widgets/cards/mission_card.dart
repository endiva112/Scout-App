import 'package:flutter/material.dart';
import 'package:scout_app/repositories/scout/mission_repository.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/common/bordered_container.dart';
import 'package:scout_app/widgets/buttons/custom_button.dart';
import 'package:scout_app/widgets/common/tool_tip.dart';

class MissionCard extends StatefulWidget {
  final String missionId;
  final String productName;
  final double suggestedPrice;
  final String unit;
  final void Function(String missionId) onCompleted;

  const MissionCard({
    super.key,
    required this.missionId,
    required this.productName,
    required this.suggestedPrice,
    required this.unit,
    required this.onCompleted,
  });

  @override
  State<MissionCard> createState() => _MissionCardState();
}

class _MissionCardState extends State<MissionCard> {
  final _repository = MissionRepository();
  late final TextEditingController _controller;
  bool _editando = false;
  bool _sending = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.suggestedPrice.toStringAsFixed(2),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onCorregir() => setState(() => _editando = true);

  void _onCancelar() {
    setState(() {
      _controller.text = widget.suggestedPrice.toStringAsFixed(2);
      _editando = false;
    });
  }

  Future<void> _onConfirmar() async {
    final price = double.tryParse(_controller.text.replaceAll(',', '.'));
    if (price == null) return;
    setState(() => _sending = true);
    await _repository.respond(widget.missionId, price);
    widget.onCompleted(widget.missionId);
  }

  @override
  Widget build(BuildContext context) {
    return BorderedContainer(
      borderColor: AppColors.actionPrimary,
      borderWidth: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildProductName(),
          _buildPriceRow(context),
          _buildButtons(context),
        ],
      ),
    );
  }

  Widget _buildProductName() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        widget.productName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildPriceRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
              color: AppColors.bgSecondary,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _editando ? AppColors.actionPrimary : Colors.transparent,
                width: 2,
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    readOnly: !_editando,
                    textAlign: TextAlign.end,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textTerciary,
                    ),
                    decoration: const InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '€/${widget.unit}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textTerciary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ToolTip(message: 'Introduce el precio que ves en la etiqueta del producto'),
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    final double buttonWidth = MediaQuery.of(context).size.width * 0.40;

    if (_sending) {
      return const Padding(
        padding: EdgeInsets.all(10),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _editando
            ? [
                SizedBox(
                  width: buttonWidth,
                  child: CustomButton(
                    label: 'Cancelar',
                    onPressed: _onCancelar,
                    backgroundColor: AppColors.bgPrimary,
                    textColor: AppColors.actionPrimary,
                    borderColor: AppColors.actionPrimary,
                  ),
                ),
                SizedBox(
                  width: buttonWidth,
                  child: CustomButton(
                    label: 'Corregido',
                    onPressed: _onConfirmar,
                    backgroundColor: AppColors.contrastSecondary,
                    textColor: AppColors.actionSecondary,
                    borderColor: AppColors.contrastSecondary,
                  ),
                ),
              ]
            : [
                SizedBox(
                  width: buttonWidth,
                  child: CustomButton(
                    label: 'Corregir precio',
                    onPressed: _onCorregir,
                  ),
                ),
                SizedBox(
                  width: buttonWidth,
                  child: CustomButton(
                    label: 'Precio correcto',
                    onPressed: _onConfirmar,
                    backgroundColor: AppColors.contrastSecondary,
                    textColor: AppColors.actionSecondary,
                    borderColor: AppColors.contrastSecondary,
                  ),
                ),
              ],
      ),
    );
  }
}