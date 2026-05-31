import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/bordered_container.dart';
import 'package:scout_app/widgets/custom_button.dart';
import 'package:scout_app/widgets/tool_tip.dart';

class MissionCard extends StatefulWidget {
  final String productName;
  final String price;
  final String unit;

  const MissionCard({
    super.key,
    required this.productName,
    required this.price,
    required this.unit,
  });

  @override
  State<MissionCard> createState() => _MissionCardState();
}

class _MissionCardState extends State<MissionCard> {
  late final TextEditingController _controller;
  bool _editando = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.price);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onCorregir() => setState(() => _editando = true);

  void _onCancelar() {
    setState(() {
      _controller.text = widget.price; // revertir al valor original
      _editando = false;
    });
  }

  void _onConfirmar() {
    // TODO: enviar _controller.text al repositorio
    setState(() => _editando = false);
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
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        textAlign: TextAlign.left,
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

          // Campo precio + unidad
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
                    style: TextStyle(
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
                    style: TextStyle(
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
            )
          ),
          SizedBox(
            width: buttonWidth,
            child: CustomButton(
              label: 'Corregido',
              onPressed: _onConfirmar,
              backgroundColor: AppColors.contrastSecondary,
              textColor: AppColors.actionSecondary,
              borderColor: AppColors.contrastSecondary,
            )
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
            )
          )
        ]
      )
    );
  }
}