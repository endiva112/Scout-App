import 'package:flutter/material.dart';

// Capa privada — valores hex puros, nadie los usa directamente
class _Primitives {
  //fondos
  static const white          = Color(0xFFFFFFFF);
  static const grey50         = Color(0xFFF1F4F8);

  //acción principal
  static const orange500      = Color(0xFFEE8B60);

  //textos
  static const black          = Color(0xFF14181B);
  static const darkgrey       = Color(0xFF14181B);
  static const grey           = Color(0xFF57636C);

  //eliminar
  static const yellow500  = Color(0xFFFEAD28);
  static const magenta500 = Color(0xFFFE4370);
  static const cyan500    = Color(0xFF0588FE);
  static const green500   = Color.fromARGB(255, 67, 230, 34);
  static const red500     = Color.fromARGB(255, 219, 20, 20);
  
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

  // Textos
  static const textPrimary   = _Primitives.black;
  static const textSecondary = _Primitives.darkgrey;
  static const textTerciary = _Primitives.grey;

  // Monetario
  static const amountPositive = _Primitives.green500;
  static const amountNegative = _Primitives.red500;

  // Bordes
  static const borderAccent = _Primitives.yellow500;
}