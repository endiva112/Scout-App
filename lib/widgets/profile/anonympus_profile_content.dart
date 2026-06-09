import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
//import 'package:go_router/go_router.dart';
import 'package:scout_app/widgets/common/bordered_container.dart';
//import 'package:scout_app/widgets/profile/custom_setting.dart';
import 'package:scout_app/widgets/profile/version_text.dart';

class AnonympusProfileContent extends StatelessWidget {
  final VoidCallback onGoogleSignIn;

  const AnonympusProfileContent({
    super.key,
    required this.onGoogleSignIn,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildImage(context),
          const SizedBox(height: 5),
          _buildHeader(),
          const SizedBox(height: 5),
          _buildExtraInfo(),
          const SizedBox(height: 5),
          InkWell(
            onTap: onGoogleSignIn,
            child: _buildGoogleLogIn(context),
          ),
          const SizedBox(height: 30),
          //_buildSubHeader(),
          //const SizedBox(height: 5),
          //_buildSettings(context),
          const SizedBox(height: 30),
          const VersionText(),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.2,
      height: MediaQuery.sizeOf(context).width * 0.2,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: Image.asset(
        'assets/icons/scout.png',
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildHeader() {
    return const Text(
      'Inicia sesión',
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildExtraInfo() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 25),
      child: Text(
        'Guarda tus listas en la nube y llevatelas a cualquier dispositivo de manera sencilla',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: AppColors.textPrimary),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildGoogleLogIn(BuildContext context) {
    return BorderedContainer(
      borderWidth: 2,
      borderColor: AppColors.borderAccent,
      backgroundColor: AppColors.bgSecondary,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/google.png',
              height: MediaQuery.sizeOf(context).height * 0.04,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 15),
            const Text(
              'Inicia sesión con Google',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: AppColors.textPrimary),
            ),
          ],
        ),
      ),
    );
  }

  /*
  Widget _buildSubHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'Preferencias',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.textPrimary),
      ),
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
          const SizedBox(height: 15),
          CustomSetting(text: 'Idioma', onTap: () => context.push('/profile/language')),
          const SizedBox(height: 10),
          Divider(color: AppColors.bgTerciary, thickness: 2, height: 1),
          const SizedBox(height: 10),
          CustomSetting(text: 'Modo oscuro', onTap: () => context.push('/profile/theme')),
          const SizedBox(height: 15),
        ],
      ),
    );
  }*/
}