import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

class MainHeader extends StatefulWidget {
  const MainHeader({super.key});

  @override
  State<MainHeader> createState() => _MainHeaderState();
}

class _MainHeaderState extends State<MainHeader> {
  String? _alias;
  String? _photoUrl;
  bool _isAnonymous = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final firebaseUser = FirebaseAuth.instance.currentUser!;

    if (firebaseUser.isAnonymous) {
      setState(() => _isAnonymous = true);
      return;
    }

    // Solo va a Firestore si está registrado
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .get();

    if (!mounted) return;
    setState(() {
      _isAnonymous = false;
      _alias = doc.data()?['alias'] as String?;
      _photoUrl = doc.data()?['photoUrl'] as String?;
    });
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = FirebaseAuth.instance.currentUser!;

    final userName = _isAnonymous
        ? 'Scout_${firebaseUser.uid.substring(0, 6).toUpperCase()}'
        : (_alias ?? 'Scout_${firebaseUser.uid.substring(0, 6).toUpperCase()}');

    final photoUrl = _isAnonymous || _photoUrl == null
        ? 'https://picsum.photos/seed/758/600'
        : _photoUrl!;

    return Container(
      constraints: const BoxConstraints(minHeight: 70),
      color: AppColors.bgPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGreetingMessage(),
              Text(
                userName,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => context.go('/profile'),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(
                  photoUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildGreetingMessage() {
  final hour = DateTime.now().hour;
  String message;
  if (hour < 12) {
    message = 'Buenos días!';
  } else if (hour < 20) {
    message = 'Buenas tardes!';
  } else {
    message = 'Buenas noches!';
  }
  return Text(message, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400));
}