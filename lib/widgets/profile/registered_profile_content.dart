import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:scout_app/widgets/bordered_container.dart';
import 'package:scout_app/widgets/profile/custom_setting.dart';
import 'package:scout_app/widgets/profile/version_text.dart';

class RegisteredProfileContent extends StatelessWidget {

  const RegisteredProfileContent({super.key,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildImage(context),
          SizedBox(height: 5),
          _buildHeader(),
          SizedBox(height: 5),
          _buildExtraInfo(),
          SizedBox(height: 5),
          InkWell(
            onTap: () => context.push('/payments/recurring_lists/expenses'),  //TODO reemplazar por lógica de log in con correo electronico
            child: _buildGoogleLogIn(context)
          ),
          SizedBox(height: 30),
          _buildSubHeader(),
          SizedBox(height: 5),
          _buildSettings(context),
          SizedBox(height: 30),
          VersionText()
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.2,
      height: MediaQuery.sizeOf(context).width * 0.2,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Image.network(
        'https://picsum.photos/seed/390/600',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildHeader() {
    return Text('Inicia sesión', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.textPrimary), textAlign: TextAlign.center,);
  }

  Widget _buildExtraInfo() {
    return Padding(
      padding: const EdgeInsetsGeometry.fromLTRB(20, 10, 20, 25),
      child: Text('Guarda tus listas en la nube y llevatelas a cualquier dispositivo de manera sencilla', 
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: AppColors.textPrimary), textAlign: TextAlign.center,
      )
    );
  }

  Widget _buildGoogleLogIn(BuildContext context) {
    return BorderedContainer(
      borderWidth: 2,
      borderColor: AppColors.borderAccent,
      backgroundColor: AppColors.bgSecondary,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsetsGeometry.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/google.png', height: MediaQuery.sizeOf(context).height * 0.04, fit: BoxFit.cover),
            SizedBox(width: 40),
            Text('Inicia sesión con Google', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: AppColors.textPrimary))
          ]
        )
      )
    );
  }

  Widget _buildSubHeader() {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 20),
      child: Text('Preferencias', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.textPrimary))
    );
  }

  Widget _buildSettings(BuildContext context) {
    return BorderedContainer(
      borderWidth: 2,
      borderColor: AppColors.borderAccent,
      backgroundColor: AppColors.bgSecondary,
      elevation: 0,
      child: Column(
        children: [
          SizedBox(height: 15),
          CustomSetting(text: 'Idioma'),
          SizedBox(height: 10),
          Divider(color: AppColors.bgTerciary, thickness: 2, height: 1,),
          SizedBox(height: 10),
          CustomSetting(text: 'Modo oscuro'),
          SizedBox(height: 15),
        ],
      )
    );
  }
}