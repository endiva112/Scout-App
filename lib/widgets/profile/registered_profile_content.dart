import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:scout_app/widgets/bordered_container.dart';
import 'package:scout_app/widgets/custom_button.dart';
import 'package:scout_app/widgets/profile/custom_profile_setting.dart';
import 'package:scout_app/widgets/profile/custom_setting.dart';
import 'package:scout_app/widgets/profile/version_text.dart';

class RegisteredProfileContent extends StatelessWidget {

  const RegisteredProfileContent({super.key,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImage(context),
            SizedBox(height: 5),
            _buildHeader(),
            SizedBox(height: 30),
            _buildProfileSettings(context),
            SizedBox(height: 30),
            _buildSubHeader(),
            SizedBox(height: 5),
            _buildSettings(context),
            SizedBox(height: 30),
            CustomButton(
              label: 'Cerrar sesión', 
              fontSize: 18, 
              textColor: AppColors.bgPrimary, 
              backgroundColor: AppColors.actionPrimary, 
              borderColor: AppColors.actionPrimary, 
              elevation: 0,
              onPressed: () => {}
            ),
            CustomButton(
              label: 'Eliminar perfil', 
              fontSize: 18, 
              textColor: AppColors.textTerciary, 
              backgroundColor: AppColors.bgPrimary, 
              borderColor: AppColors.bgPrimary, 
              elevation: 0,
              onPressed: () => {}
            ),
            SizedBox(height: 30),
            VersionText()
          ]
        )
      )
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
    return Text('Enrique Díaz', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.textPrimary), textAlign: TextAlign.center,);
  }

  Widget _buildSubHeader() {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 20),
      child: Text('Preferencias', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.textPrimary))
    );
  }

    Widget _buildProfileSettings(BuildContext context) {
    return BorderedContainer(
      borderWidth: 2,
      borderColor: AppColors.borderAccent,
      backgroundColor: AppColors.bgSecondary,
      elevation: 0,
      child: Column(
        children: [
          SizedBox(height: 15),
          CustomProfileSetting(desciption: 'ID', currentValue: 'dhjghdsghjdgsj2727'),
          SizedBox(height: 10),
          Divider(color: AppColors.bgTerciary, thickness: 2, height: 1,),
          SizedBox(height: 10),
          CustomProfileSetting(desciption: 'Alias', currentValue: 'Enrique Díaz', onTap: () => context.push('/profile/notifications')), //TODO modificar en un futuro
          SizedBox(height: 10),
          Divider(color: AppColors.bgTerciary, thickness: 2, height: 1,),
          SizedBox(height: 10),
          CustomProfileSetting(desciption: 'Correo electrónico', currentValue: 'micorreodemail@gmail.com', onTap: () => context.push('/profile/notifications')), // modificar en un futuro
          SizedBox(height: 15),
        ],
      )
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
          CustomSetting(text: 'Notificaciones', onTap: () => context.push('/profile/notifications')),
          SizedBox(height: 10),
          Divider(color: AppColors.bgTerciary, thickness: 2, height: 1,),
          SizedBox(height: 10),
          CustomSetting(text: 'Idioma', onTap: () => context.push('/profile/language')),
          SizedBox(height: 10),
          Divider(color: AppColors.bgTerciary, thickness: 2, height: 1,),
          SizedBox(height: 10),
          CustomSetting(text: 'Modo oscuro', onTap: () => context.push('/profile/theme')),
          SizedBox(height: 15),
        ],
      )
    );
  }
}