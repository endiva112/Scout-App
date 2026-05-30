import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/collections/notes_collection.dart';
import 'package:scout_app/widgets/default_tip_text.dart';
import 'package:scout_app/widgets/buttons/floating_create_button.dart';

import 'package:scout_app/widgets/headers/main_header.dart';
import 'package:scout_app/widgets/simple_title.dart';
import 'package:scout_app/widgets/footers/bottom_navbar.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

    @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.bgPrimary,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            // Componentes de esta página
            children: [
              MainHeader(),
              
              //TODO
              Expanded(child: _buildBody(context)),

              BottomNavBar(activeIndex: 2)
            ]
          )
        )
      )
    );
  }

  // Cuerpo de la vista
  Widget _buildBody(BuildContext context) {
    return Container(
      color: AppColors.bgSecondary,
      child: Stack(
        children: [
          //Listado de listas de la compra
          _buildBodyContent(),

          //Botón de creación de lista
          FloatingCreateButton()
        ]
      )
    );
  }

  // Cuerpo del listado de notas
  Widget _buildBodyContent() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SimpleTitle(title: 'Mis notas'),
        Expanded(child: NotesCollection())
      ]
    );
  }
}