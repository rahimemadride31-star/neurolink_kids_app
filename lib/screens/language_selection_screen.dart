import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../data/strings.dart';
import '../state/app_state.dart';
import '../widgets/kids_background.dart';
import '../widgets/primary_button.dart';
import 'welcome_screen.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    return Scaffold(
      body: KidsBackground(
        overlayOpacity: 0.55,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
            child: Column(
              children: [
                Image.asset('assets/images/logo.png',
                    width: 140, height: 140),
                const SizedBox(height: 16),
                const Text(
                  'NeuroLink Kids',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Choisissez votre langue',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Text(
                  'اختر لغتك',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 32),
                _LanguageCard(
                  label: 'English',
                  flag: '🇬🇧',
                  selected: state.language == AppLanguage.en,
                  onTap: () {
                    state.setLanguage(AppLanguage.en);
                    S.setLanguage(AppLanguage.en);
                  },
                ),
                const SizedBox(height: 14),
                _LanguageCard(
                  label: 'Français',
                  flag: '🇫🇷',
                  selected: state.language == AppLanguage.fr,
                  onTap: () {
                    state.setLanguage(AppLanguage.fr);
                    S.setLanguage(AppLanguage.fr);
                  },
                ),
                const SizedBox(height: 14),
                _LanguageCard(
                  label: 'العربية',
                  flag: '🇸🇦',
                  selected: state.language == AppLanguage.ar,
                  onTap: () {
                    state.setLanguage(AppLanguage.ar);
                    S.setLanguage(AppLanguage.ar);
                  },
                ),
                const Spacer(),
                PrimaryButton(
                  label: S.get('continue_btn'),
                  icon: Icons.arrow_forward,
                  gradient: AppColors.orangeGradient,
                  onPressed: () {
                    S.setLanguage(state.language);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (_) => const WelcomeScreen()),
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LanguageCard extends StatelessWidget {
  final String label;
  final String flag;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageCard({
    required this.label,
    required this.flag,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          gradient: selected ? AppColors.blueGradient : null,
          color: selected ? null : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? Colors.transparent : AppColors.border,
            width: 1.5,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: selected ? Colors.white : AppColors.textDark,
                ),
              ),
            ),
            if (selected)
              const Icon(Icons.check_circle, color: Colors.white, size: 28),
          ],
        ),
      ),
    );
  }
}
