import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scout_app/models/app_user.dart';
import 'package:scout_app/repositories/auth_repository.dart';
import 'package:scout_app/repositories/user_repository.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/footers/bottom_navbar.dart';
import 'package:scout_app/widgets/profile/anonympus_profile_content.dart';
import 'package:scout_app/widgets/profile/registered_profile_content.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _authRepository = AuthRepository();
  final _userRepository = UserRepository();

  AppUser? _user;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final firebaseUser = FirebaseAuth.instance.currentUser!;

    if (firebaseUser.isAnonymous) {
      setState(() {
        _user = AppUser(
          uid: firebaseUser.uid,
          createdAt: DateTime.now(),
          isAnonymous: true,
        );
        _loading = false;
      });
      return;
    }

    // Solo va a Firestore si está registrado
    final user = await _userRepository.getUser(firebaseUser.uid);
    if (!mounted) return;
    setState(() {
      _user = user;
      _loading = false;
    });
  }

  Future<void> _onGoogleSignIn() async {
    setState(() => _loading = true);
    try {
      final firebaseUser = await _authRepository.signInWithGoogle();
      if (firebaseUser == null) {
        setState(() => _loading = false);
        return;
      }
      await _userRepository.upgradeToRegistered(firebaseUser.uid);

      // Buscar la foto en los proveedores vinculados
      final photoUrl = firebaseUser.providerData
          .firstWhere(
            (p) => p.providerId == 'google.com',
            orElse: () => firebaseUser.providerData.first,
          )
          .photoURL;

      if (photoUrl != null) {
        await _userRepository.updateProfile(
          firebaseUser.uid,
          photoUrl: photoUrl,
        );
      }

      await _loadUser();
    } catch (e) {
      if (mounted) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al iniciar sesión con Google')),
        );
      }
    }
  }

  Future<void> _onSignOut() async {
    await _authRepository.signOut();
    await _authRepository.signInAnonymously();
    if (!mounted) return;
    await _loadUser();
  }

  Future<void> _onDeleteAccount() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await _userRepository.deleteUser(uid);
    await _authRepository.deleteAccount();
    await _authRepository.signInAnonymously();
    if (!mounted) return;
    await _loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Perfil',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Expanded(child: _buildBody()),
            BottomNavBar(activeIndex: -1),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_user == null) {
      return const Center(child: Text('Error al cargar el perfil'));
    }

    if (_user!.isAnonymous) {
      return AnonympusProfileContent(
        onGoogleSignIn: _onGoogleSignIn,
      );
    }

    return RegisteredProfileContent(
      user: _user!,
      onSignOut: _onSignOut,
      onDeleteAccount: _onDeleteAccount,
      onRefresh: _loadUser,
    );
  }
}