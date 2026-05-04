import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../app_theme.dart';
import '../data/strings.dart';
import '../state/app_state.dart';
import '../widgets/kids_background.dart';
import '../widgets/language_switcher.dart';
import 'add_report_screen.dart';
import 'reports_screen.dart';

class TeacherHomeScreen extends StatelessWidget {
  const TeacherHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    return Scaffold(
      body: KidsBackground(
        overlayOpacity: 0.60,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  Image.asset('assets/images/logo.png',
                      width: 44, height: 44),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(S.get('app_name'),
                        style: const TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 16)),
                  ),
                  const LanguageSwitcher(),
                  const SizedBox(width: 8),
                  const CircleAvatar(
                    backgroundColor: AppColors.accentOrange,
                    child: Text('E',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900)),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(S.get('teacher_greeting'),
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.w900)),
              Text(S.get('manage_students'),
                  style: const TextStyle(color: AppColors.textMuted)),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: AppColors.blueGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      const Icon(Icons.bar_chart, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(S.get('class_overview'),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w900)),
                    ]),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _Mini(label: S.get('avg_task'), value: '78%'),
                        _Mini(label: S.get('avg_score'), value: '82%'),
                        _Mini(
                            label: S.get('students_label'),
                            value: '${state.children.length}'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Text(S.get('student_performance'),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w900)),
              const SizedBox(height: 10),
              ...state.children.map((c) => _StudentCard(name: c.name, color: c.color)),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const AddReportScreen())),
                child: Container(
                  height: 54,
                  decoration: BoxDecoration(
                    gradient: AppColors.orangeGradient,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Center(
                    child: Text('+ ${S.get('add_report')}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800)),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(S.get('recent_reports'),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              const ReportsList(),
              const SizedBox(height: 18),
              Text(S.get('medical_reports'),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              if (state.medicalReports.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text(S.get('no_medical_reports'),
                        style: const TextStyle(color: AppColors.textMuted)),
                  ),
                )
              else
                ...state.medicalReports.map((r) => Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Expanded(
                              child: Text(r.patientName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800)),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.accentTeal.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(S.get('role_doctor'),
                                  style: const TextStyle(
                                      color: AppColors.accentTeal,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11)),
                            ),
                          ]),
                          const SizedBox(height: 4),
                          Text(DateFormat('dd/MM/yyyy').format(r.date),
                              style: const TextStyle(
                                  color: AppColors.textMuted, fontSize: 12)),
                          if (r.observation.isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Text(r.observation,
                                style: const TextStyle(fontSize: 13)),
                          ],
                          if (r.diagnosisUpdate.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(r.diagnosisUpdate,
                                style: const TextStyle(
                                    color: AppColors.accentPurple,
                                    fontSize: 12)),
                          ],
                        ],
                      ),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}

class _Mini extends StatelessWidget {
  final String label;
  final String value;
  const _Mini({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w900)),
          Text(label,
              style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }
}

class _StudentCard extends StatelessWidget {
  final String name;
  final Color color;
  const _StudentCard({required this.name, required this.color});

  Widget _bar(String label, double v, Color c) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 64,
            child: Text(label, style: const TextStyle(fontSize: 12)),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: v,
                minHeight: 8,
                backgroundColor: AppColors.border,
                valueColor: AlwaysStoppedAnimation(c),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text('${(v * 100).round()}%',
              style: const TextStyle(
                  fontWeight: FontWeight.w800, fontSize: 12)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: color,
                child: Text(name[0],
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w800)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.accentGreen.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('${S.get('level')} 2',
                    style: TextStyle(
                        color: AppColors.accentGreen,
                        fontWeight: FontWeight.w800,
                        fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _bar(S.get('reading'), 0.78, AppColors.accentGreen),
          _bar(S.get('writing'), 0.65, AppColors.primary),
          _bar(S.get('math'), 0.72, AppColors.accentPurple),
          _bar(S.get('social'), 0.84, AppColors.accentOrange),
        ],
      ),
    );
  }
}
