import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../data/strings.dart';
import '../state/app_state.dart';
import '../widgets/kids_background.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    return Scaffold(
      body: KidsBackground(
        overlayOpacity: 0.62,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.get('my_students'),
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w900)),
                const SizedBox(height: 4),
                Text(S.get('manage_students'),
                    style: const TextStyle(color: AppColors.textMuted)),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.separated(
                    itemCount: state.children.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) {
                      final c = state.children[i];
                      final reports = state.reports
                          .where((r) => r.childName == c.name)
                          .toList();
                      final recentPerf = reports.isNotEmpty
                          ? reports.first.performance
                          : '-';
                      return GestureDetector(
                        onTap: () => state.setActiveChild(i),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: state.activeChildIndex == i
                                  ? AppColors.accentOrange
                                  : AppColors.border,
                              width: state.activeChildIndex == i ? 1.5 : 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: c.color,
                                child: Text(c.initial,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 20)),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(c.name,
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w800)),
                                    const SizedBox(height: 4),
                                    Text(
                                        '${c.age} ${S.get('years_old')} • ${c.school}',
                                        style: const TextStyle(
                                            color: AppColors.textMuted,
                                            fontSize: 13)),
                                    const SizedBox(height: 2),
                                    Text(c.diagnosis,
                                        style: const TextStyle(
                                            color: AppColors.accentPurple,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12)),
                                    const SizedBox(height: 2),
                                    Text(
                                        '${S.get('reports_stat')}: ${reports.length} • ${S.get('performance_label')}: $recentPerf',
                                        style: const TextStyle(
                                            color: AppColors.textMuted,
                                            fontSize: 11)),
                                  ],
                                ),
                              ),
                              const Icon(Icons.chevron_right,
                                  color: AppColors.textMuted),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
