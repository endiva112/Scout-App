import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Estilos de línea disponibles para StyledDivider
enum DividerLineStyle {
  solid,
  dotted,
  dashed,
  double,
}

class StyledDivider extends StatelessWidget {
  const StyledDivider({
    super.key,
    this.thickness = 1.0,
    this.indent = 0.0,
    this.endIndent = 0.0,
    this.color,
    this.lineStyle = DividerLineStyle.solid,
    this.height = 16.0,
  });

  /// Grosor de la línea en píxeles.
  final double thickness;

  /// Espacio en blanco antes (izquierda) del divisor.
  final double indent;

  /// Espacio en blanco después (derecha) del divisor.
  final double endIndent;

  /// Color de la línea. Por defecto usa el DividerTheme del contexto.
  final Color? color;

  /// Estilo de la línea: solid, dotted, dashed o double.
  final DividerLineStyle lineStyle;

  /// Altura total del widget (espacio vertical que ocupa).
  final double height;

  @override
  Widget build(BuildContext context) {
    final effectiveColor =
        color ?? DividerTheme.of(context).color ?? Theme.of(context).dividerColor;

    return SizedBox(
      height: height,
      child: Center(
        child: Padding(
          padding: EdgeInsetsDirectional.only(start: indent, end: endIndent),
          child: lineStyle == DividerLineStyle.solid
              ? Divider(
                  thickness: thickness,
                  color: effectiveColor,
                  height: thickness,
                )
              : CustomPaint(
                  size: Size(double.infinity, thickness),
                  painter: _StyledLinePainter(
                    color: effectiveColor,
                    thickness: thickness,
                    lineStyle: lineStyle,
                  ),
                ),
        ),
      ),
    );
  }
}

class _StyledLinePainter extends CustomPainter {
  _StyledLinePainter({
    required this.color,
    required this.thickness,
    required this.lineStyle,
  });

  final Color color;
  final double thickness;
  final DividerLineStyle lineStyle;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    final y = size.height / 2;

    switch (lineStyle) {
      case DividerLineStyle.dotted:
        _drawDotted(canvas, size, paint, y);
        break;
      case DividerLineStyle.dashed:
        _drawDashed(canvas, size, paint, y);
        break;
      case DividerLineStyle.double:
        _drawDouble(canvas, size, paint, y);
        break;
      case DividerLineStyle.solid:
        canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
        break;
    }
  }

  void _drawDotted(Canvas canvas, Size size, Paint paint, double y) {
    final dotRadius = thickness / 2;
    final gap = math.max(thickness * 2, 4.0);
    final step = dotRadius * 2 + gap;
    double x = dotRadius;

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    while (x < size.width) {
      canvas.drawCircle(Offset(x, y), dotRadius, fillPaint);
      x += step;
    }
  }

  void _drawDashed(Canvas canvas, Size size, Paint paint, double y) {
    final dashWidth = math.max(thickness * 4, 8.0);
    final gap = math.max(thickness * 2, 4.0);
    final step = dashWidth + gap;
    double x = 0;

    while (x < size.width) {
      final end = math.min(x + dashWidth, size.width);
      canvas.drawLine(Offset(x, y), Offset(end, y), paint);
      x += step;
    }
  }

  void _drawDouble(Canvas canvas, Size size, Paint paint, double y) {
    final offset = thickness + 1.5;
    canvas.drawLine(Offset(0, y - offset), Offset(size.width, y - offset), paint);
    canvas.drawLine(Offset(0, y + offset), Offset(size.width, y + offset), paint);
  }

  @override
  bool shouldRepaint(_StyledLinePainter old) =>
      old.color != color ||
      old.thickness != thickness ||
      old.lineStyle != lineStyle;
}