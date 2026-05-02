import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../data/strings.dart';
import '../state/app_state.dart';
import '../widgets/kids_background.dart';
import '../widgets/language_switcher.dart';
import '../widgets/primary_button.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppStateScope.of(context);
    return Scaffold(
      body: KidsBackground(
        overlayOpacity: 0.55,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerRight,
                  child: LanguageSwitcher(),
                ),
                const Spacer(),
                Image.asset('assets/images/logo.png',
                    width: 180, height: 180),
                const SizedBox(height: 12),
                Text(
                  S.get('app_name'),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  S.get('tagline'),
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    S.get('subtitle'),
                    style: const TextStyle(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Spacer(),
                PrimaryButton(
                  label: S.get('sign_up'),
                  icon: Icons.person_add_alt_1,
                  gradient: AppColors.orangeGradient,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const SignupScreen()));
                  },
                ),
                const SizedBox(height: 12),
                OutlineButtonRound(
                  label: S.get('log_in'),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const LoginScreen()));
                  },
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
