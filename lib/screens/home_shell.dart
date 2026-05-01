import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../data/strings.dart';
import '../state/app_state.dart';
import 'activities_screen.dart';
import 'doctor_home_screen.dart';
import 'parent_home_screen.dart';
import 'patients_screen.dart';
import 'profile_screen.dart';
import 'progress_screen.dart';
import 'reports_tab_screen.dart';
import 'students_screen.dart';
import 'teacher_home_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);

    Widget homeForRole() {
      switch (state.role) {
        case UserRole.parent:
          return const ParentHomeScreen();
        case UserRole.teacher:
          return const TeacherHomeScreen();
        case UserRole.doctor:
          return const DoctorHomeScreen();
      }
    }

    List<Widget> pagesForRole() {
      switch (state.role) {
        case UserRole.parent:
          return [
            homeForRole(),
            const ActivitiesScreen(),
            const ProgressScreen(),
            const ProfileScreen(),
          ];
        case UserRole.teacher:
          return [
            homeForRole(),
            const StudentsScreen(),
            const ReportsTabScreen(),
            const ProfileScreen(),
          ];
        case UserRole.doctor:
          return [
            homeForRole(),
            const PatientsScreen(),
            const ReportsTabScreen(),
            const ProfileScreen(),
          ];
      }
    }

    List<BottomNavigationBarItem> navItemsForRole() {
      switch (state.role) {
        case UserRole.parent:
          return [
            BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                activeIcon: const Icon(Icons.home_rounded),
                label: S.get('tab_home')),
            BottomNavigationBarItem(
                icon: const Icon(Icons.grid_view_outlined),
                activeIcon: const Icon(Icons.grid_view_rounded),
                label: S.get('tab_activities')),
            BottomNavigationBarItem(
                icon: const Icon(Icons.trending_up_outlined),
                activeIcon: const Icon(Icons.trending_up),
                label: S.get('tab_progress')),
            BottomNavigationBarItem(
                icon: const Icon(Icons.person_outline),
                activeIcon: const Icon(Icons.person),
                label: S.get('tab_profile')),
          ];
        case UserRole.teacher:
          return [
            BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                activeIcon: const Icon(Icons.home_rounded),
                label: S.get('tab_home')),
            BottomNavigationBarItem(
                icon: const Icon(Icons.school_outlined),
                activeIcon: const Icon(Icons.school),
                label: S.get('tab_students')),
            BottomNavigationBarItem(
                icon: const Icon(Icons.description_outlined),
                activeIcon: const Icon(Icons.description),
                label: S.get('tab_reports')),
            BottomNavigationBarItem(
                icon: const Icon(Icons.person_outline),
                activeIcon: const Icon(Icons.person),
                label: S.get('tab_profile')),
          ];
        case UserRole.doctor:
          return [
            BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                activeIcon: const Icon(Icons.home_rounded),
                label: S.get('tab_home')),
            BottomNavigationBarItem(
                icon: const Icon(Icons.medical_services_outlined),
                activeIcon: const Icon(Icons.medical_services),
                label: S.get('tab_patients')),
            BottomNavigationBarItem(
                icon: const Icon(Icons.description_outlined),
                activeIcon: const Icon(Icons.description),
                label: S.get('tab_reports')),
            BottomNavigationBarItem(
                icon: const Icon(Icons.person_outline),
                activeIcon: const Icon(Icons.person),
                label: S.get('tab_profile')),
          ];
      }
    }

    final pages = pagesForRole();

    return Scaffold(
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 14,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: BottomNavigationBar(
            currentIndex: _index,
            onTap: (i) => setState(() => _index = i),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.textMuted,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w800),
            items: navItemsForRole(),
          ),
        ),
      ),
    );
  }
}
