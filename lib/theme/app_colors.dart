import 'package:flutter/material.dart';

// Capa privada — valores hex puros, nadie los usa directamente
class _Primitives {
  // Fondos
  static const white          = Color(0xFFFFFFFF);
  static const grey50         = Color(0xFFF1F4F8);
  static const lightgrey      = Color(0xFFE0E3E7);

  // Acción principal
  static const orange500      = Color(0xFFEE8B60);
  static const darkOrange = Color(0xFFD67A31);

  // Acción secundaria
  static const specialDarkGreen = Color(0xFF4E7566);
  static const specialGreen = Color(0xFF7CD2B9);

  // Textos
  static const black          = Color(0xFF14181B);
  static const darkgrey       = Color(0xFF14181B);
  static const grey           = Color(0xFF57636C);

  // Colores de las listas
  static const yellow500      = Color(0xFFFEAD28);
  static const magenta500     = Color(0xFFFE4370);
  static const cyan500        = Color(0xFF0588FE);

  // Resultados
  static const green          = Color(0xFF60D394);
  static const red            = Color(0xFFEE6055);

  // Bordes
  static const golden         = Color(0x4DEE8B60);
}

// Capa pública — roles semánticos
class AppColors {
  AppColors._(); // evita instanciación accidental

  // Fondos
  static const bgPrimary   = _Primitives.white;
  static const bgSecondary = _Primitives.grey50;
  static const bgTerciary  = _Primitives.lightgrey;

  // Tipos de lista
  static const listTypeSimple        = _Primitives.cyan500;
  static const listTypeCollaborative = _Primitives.magenta500;
  static const listTypeRecurring     = _Primitives.yellow500;

  // Acción principal
  static const actionPrimary = _Primitives.orange500;
  static const contrastPrimary = _Primitives.darkOrange;

  // Acción secundaria
  static const actionSecondary = _Primitives.specialDarkGreen;
  static const contrastSecondary = _Primitives.specialGreen;

  // Textos
  static const textPrimary   = _Primitives.black;
  static const textSecondary = _Primitives.darkgrey;
  static const textTerciary = _Primitives.grey;

  // Resultados
  static const positive = _Primitives.green;
  static const negative = _Primitives.red;

  // Bordes
  static const borderAccent = _Primitives.golden;
}