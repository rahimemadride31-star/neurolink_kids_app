import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../app_theme.dart';
import '../data/strings.dart';
import '../state/app_state.dart';
import '../widgets/kids_background.dart';
import 'reports_screen.dart';

class ReportsTabScreen extends StatelessWidget {
  const ReportsTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final isDoctor = state.role == UserRole.doctor;

    return Scaffold(
      body: KidsBackground(
        overlayOpacity: 0.62,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(S.get('tab_reports'),
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w900)),
              const SizedBox(height: 4),
              Text(isDoctor
                      ? S.get('recent_medical')
                      : S.get('recent_reports'),
                  style: const TextStyle(color: AppColors.textMuted)),
              const SizedBox(height: 16),
              if (isDoctor) ...[
                if (state.medicalReports.isEmpty)
                  _EmptyState(message: S.get('no_medical_reports'))
                else
                  ...state.medicalReports.map((r) => _MedicalReportCard(
                        patientName: r.patientName,
                        date: r.date,
                        observation: r.observation,
                        diagnosisUpdate: r.diagnosisUpdate,
                        recommendations: r.recommendations,
                      )),
              ] else ...[
                const ReportsList(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String message;
  const _EmptyState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      alignment: Alignment.center,
      child: Column(
        children: [
          const Icon(Icons.event_note, size: 56, color: AppColors.textMuted),
          const SizedBox(height: 8),
          Text(message,
              style: const TextStyle(color: AppColors.textMuted)),
        ],
      ),
    );
  }
}

class _MedicalReportCard extends StatelessWidget {
  final String patientName;
  final DateTime date;
  final String observation;
  final String diagnosisUpdate;
  final String recommendations;

  const _MedicalReportCard({
    required this.patientName,
    required this.date,
    required this.observation,
    required this.diagnosisUpdate,
    required this.recommendations,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(patientName,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w900)),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.accentTeal.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(S.get('role_doctor'),
                    style: const TextStyle(
                        color: AppColors.accentTeal,
                        fontWeight: FontWeight.w800,
                        fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(children: [
            const Icon(Icons.calendar_today_outlined,
                size: 12, color: AppColors.textMuted),
            const SizedBox(width: 4),
            Text(DateFormat('dd/MM/yyyy').format(date),
                style: const TextStyle(
                    fontSize: 12, color: AppColors.textMuted)),
          ]),
          if (observation.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(S.get('medical_observation'),
                style: const TextStyle(
                    fontWeight: FontWeight.w800, fontSize: 13)),
            const SizedBox(height: 4),
            Text(observation,
                style: const TextStyle(
                    color: AppColors.textMuted, fontSize: 13)),
          ],
          if (diagnosisUpdate.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(S.get('diagnosis_update'),
                style: const TextStyle(
                    fontWeight: FontWeight.w800, fontSize: 13)),
            const SizedBox(height: 4),
            Text(diagnosisUpdate,
                style: const TextStyle(
                    color: AppColors.accentPurple, fontSize: 13)),
          ],
          if (recommendations.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(S.get('recommendations'),
                style: const TextStyle(
                    fontWeight: FontWeight.w800, fontSize: 13)),
            const SizedBox(height: 4),
            Text(recommendations,
                style: const TextStyle(
                    color: AppColors.textMuted, fontSize: 13)),
          ],
        ],
      ),
    );
  }
}
