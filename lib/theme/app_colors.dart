import 'package:flutter/material.dart';

// Capa privada — valores hex puros, nadie los usa directamente
class _Primitives {
  static const white        = Color(0xFFFFFFFF);
  static const grey50       = Color(0xFFF1F4F8);

  static const orange500    = Color(0xFFEE8B60);

  //textos
  static const darkgrey     = Color(0xFF14181B);

  static const yellow500  = Color(0xFFFEAD28);
  static const magenta500 = Color(0xFFFE4370);
  static const cyan500    = Color(0xFF0588FE);
  static const green500   = Color(0xFF000000); // reemplaza con tu hex
  static const red500     = Color(0xFF000000); // reemplaza con tu hex
  static const black      = Color(0xFF1A1A1A);
  static const grey400    = Color(0xFF888888);
}

// Capa pública — roles semánticos
class AppColors {
  AppColors._(); // evita instanciación accidental

  // Fondos
  static const bgPrimary   = _Primitives.white;
  static const bgSecondary = _Primitives.grey50;

  // Tipos de lista
  static const listTypeSimple        = _Primitives.yellow500;
  static const listTypeCollaborative = _Primitives.magenta500;
  static const listTypeRecurring     = _Primitives.cyan500;

  // Acción principal
  static const actionPrimary = _Primitives.orange500;

  // Texto
  static const textPrimary   = _Primitives.black;
  static const textSecondary = _Primitives.darkgrey;
  static const textTerciary = _Primitives.grey400;

  // Monetario
  static const amountPositive = _Primitives.green500;
  static const amountNegative = _Primitives.red500;

  // Bordes
  static const borderAccent = _Primitives.yellow500;
}