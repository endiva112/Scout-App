import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:scout_app/models/app_user.dart';
import 'package:scout_app/widgets/common/bordered_container.dart';
import 'package:scout_app/widgets/buttons/custom_button.dart';
import 'package:scout_app/widgets/profile/custom_profile_setting.dart';
//import 'package:scout_app/widgets/profile/custom_setting.dart';
import 'package:scout_app/widgets/profile/delete_profile_sheet.dart';
import 'package:scout_app/widgets/profile/version_text.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisteredProfileContent extends StatelessWidget {
  final AppUser user;
  final VoidCallback onSignOut;
  final VoidCallback onDeleteAccount;
  final VoidCallback onRefresh;

  const RegisteredProfileContent({
    super.key,
    required this.user,
    required this.onSignOut,
    required this.onDeleteAccount,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImage(context),
            const SizedBox(height: 5),
            _buildHeader(),
            const SizedBox(height: 30),
            _buildProfileSettings(context),
            const SizedBox(height: 30),
            //_buildSubHeader(),
            //const SizedBox(height: 5),
            //_buildSettings(context),
            const SizedBox(height: 30),
            CustomButton(
              label: 'Cerrar sesión',
              fontSize: 18,
              textColor: AppColors.bgPrimary,
              backgroundColor: AppColors.actionPrimary,
              borderColor: AppColors.actionPrimary,
              elevation: 0,
              onPressed: onSignOut,
            ),
            CustomButton(
              label: 'Eliminar perfil',
              fontSize: 18,
              textColor: AppColors.textTerciary,
              backgroundColor: AppColors.bgPrimary,
              borderColor: AppColors.bgPrimary,
              elevation: 0,
              onPressed: () => DeleteProfileSheet.show(
                context,
                onConfirm: onDeleteAccount,
              ),
            ),
            const SizedBox(height: 30),
            const VersionText(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.2,
      height: MediaQuery.sizeOf(context).width * 0.2,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: user.photoUrl != null
          ? Image.network(user.photoUrl!, fit: BoxFit.contain)
          : Image.asset('assets/icons/scout.png', fit: BoxFit.cover),
    );
  }

  Widget _buildHeader() {
    final name = user.alias ?? 'Scout_${user.uid.substring(0, 6).toUpperCase()}';
    return Text(
      name,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
      textAlign: TextAlign.center,
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
  }*/

  Widget _buildProfileSettings(BuildContext context) {
    return BorderedContainer(
      borderWidth: 2,
      borderColor: AppColors.borderAccent,
      backgroundColor: AppColors.bgSecondary,
      elevation: 0,
      child: Column(
        children: [
          const SizedBox(height: 15),
          CustomProfileSetting(
            desciption: 'ID',
            currentValue: user.uid,
          ),
          const SizedBox(height: 10),
          Divider(color: AppColors.bgTerciary, thickness: 2, height: 1),
          const SizedBox(height: 10),
          CustomProfileSetting(
            desciption: 'Alias',
            currentValue: user.alias ?? 'Sin alias',
            onTap: () async {
              await context.push('/profile/alias');
              onRefresh();
            }
          ),
          const SizedBox(height: 10),
          Divider(color: AppColors.bgTerciary, thickness: 2, height: 1),
          const SizedBox(height: 10),
          CustomProfileSetting(
            desciption: 'Correo electrónico',
            currentValue: FirebaseAuth.instance.currentUser?.email ?? 'Sin correo',
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  /*
  Widget _buildSettings(BuildContext context) {
    return BorderedContainer(
      borderWidth: 2,
      borderColor: AppColors.borderAccent,
      backgroundColor: AppColors.bgSecondary,
      elevation: 0,
      child: Column(
        children: [
          const SizedBox(height: 15),
          CustomSetting(text: 'Notificaciones', onTap: () => context.push('/profile/notifications')),
          const SizedBox(height: 10),
          Divider(color: AppColors.bgTerciary, thickness: 2, height: 1),
          const SizedBox(height: 10),
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