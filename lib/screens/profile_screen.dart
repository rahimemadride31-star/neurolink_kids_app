import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../data/strings.dart';
import '../state/app_state.dart';
import '../widgets/kids_background.dart';
import 'add_child_screen.dart';
import 'welcome_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  String _roleLabel(UserRole r) {
    switch (r) {
      case UserRole.parent:
        return S.get('role_parent');
      case UserRole.teacher:
        return S.get('role_teacher');
      case UserRole.doctor:
        return S.get('role_doctor');
    }
  }

  String _listTitle(UserRole r) {
    switch (r) {
      case UserRole.parent:
        return S.get('my_children');
      case UserRole.teacher:
        return S.get('my_students');
      case UserRole.doctor:
        return S.get('my_patients');
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    return Scaffold(
      body: KidsBackground(
        overlayOpacity: 0.62,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: AppColors.blueGradient,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person,
                          color: AppColors.primary, size: 36),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(state.userName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900)),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(_roleLabel(state.role),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Text(_listTitle(state.role),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              ...state.children.asMap().entries.map((e) {
                final i = e.key;
                final c = e.value;
                final active = state.activeChildIndex == i;
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: active ? AppColors.primary : AppColors.border,
                      width: active ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: c.color,
                        child: Text(c.initial,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(c.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800)),
                            Text(
                                '${c.age} ${S.get('years_old')} • ${c.gender == "Boy" ? S.get('boy') : S.get('girl')}',
                                style: const TextStyle(
                                    color: AppColors.textMuted)),
                            Text(c.diagnosis,
                                style: const TextStyle(
                                    color: AppColors.accentPurple,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12)),
                          ],
                        ),
                      ),
                      if (!active)
                        TextButton(
                            onPressed: () => state.setActiveChild(i),
                            child: Text(S.get('activate'))),
                    ],
                  ),
                );
              }),
              if (state.role == UserRole.parent)
                ListTile(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => const AddChildScreen()),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(color: AppColors.border)),
                  tileColor: Colors.white,
                  leading: const CircleAvatar(
                      backgroundColor: AppColors.primary,
                      child: Icon(Icons.add, color: Colors.white)),
                  title: Text(S.get('add_child'),
                      style: const TextStyle(fontWeight: FontWeight.w800)),
                ),
              const SizedBox(height: 22),
              Text(S.get('preferences'),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w900)),
              const SizedBox(height: 18),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (_) => const WelcomeScreen()),
                    (_) => false,
                  );
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                        color: AppColors.accentRed.withOpacity(0.5))),
                tileColor: Colors.white,
                leading: const Icon(Icons.logout, color: AppColors.accentRed),
                title: Text(S.get('logout'),
                    style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppColors.accentRed)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
