import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../data/strings.dart';
import '../state/app_state.dart';
import '../widgets/kids_background.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final child = state.activeChild;
    final reportsForChild =
        state.reports.where((r) => r.childName == child.name).toList();
    final excellent = reportsForChild
        .where((r) => r.performance == 'Excellent')
        .length;
    final good =
        reportsForChild.where((r) => r.performance == 'Good').length;
    final avg =
        reportsForChild.where((r) => r.performance == 'Average').length;
    final poor =
        reportsForChild.where((r) => r.performance == 'Poor').length;
    final total = reportsForChild.length.clamp(1, 9999);

    return Scaffold(
      body: KidsBackground(
        overlayOpacity: 0.62,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(S.get('progress_title'),
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w900)),
              const SizedBox(height: 4),
              Text("${S.get('tracking_progress')} ${child.name}",
                  style:
                      const TextStyle(color: AppColors.textMuted)),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                      child: _StatCard(
                          label: S.get('activities_stat'),
                          value: '24',
                          icon: Icons.bolt,
                          gradient: AppColors.orangeGradient)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _StatCard(
                          label: S.get('videos_stat'),
                          value: '8',
                          icon: Icons.play_circle,
                          gradient: AppColors.purpleGradient)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                      child: _StatCard(
                          label: S.get('reports_stat'),
                          value: '${reportsForChild.length}',
                          icon: Icons.description,
                          gradient: AppColors.blueGradient)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _StatCard(
                          label: S.get('score_stat'),
                          value:
                              '${(((excellent * 4 + good * 3 + avg * 2 + poor * 1) / (total * 4)) * 100).round()}%',
                          icon: Icons.star,
                          gradient: AppColors.tealGradient)),
                ],
              ),
              const SizedBox(height: 22),
              Text(S.get('performance_by_cat'),
                  style:
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
              const SizedBox(height: 12),
              _Bar(
                  label: S.get('excellent'),
                  value: excellent / total,
                  color: AppColors.accentGreen),
              _Bar(
                  label: S.get('good'),
                  value: good / total,
                  color: AppColors.primary),
              _Bar(
                  label: S.get('average'),
                  value: avg / total,
                  color: AppColors.accentOrange),
              _Bar(
                  label: S.get('poor'),
                  value: poor / total,
                  color: AppColors.accentRed),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Gradient gradient;
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.gradient,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(height: 10),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w900)),
          Text(label,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  const _Bar(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(label,
                    style: const TextStyle(fontWeight: FontWeight.w700)),
              ),
              Text('${(value * 100).round()}%',
                  style: TextStyle(
                      color: color, fontWeight: FontWeight.w800)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: value,
              backgroundColor: AppColors.border,
              color: color,
              minHeight: 10,
            ),
          ),
        ],
      ),
    );
  }
}
