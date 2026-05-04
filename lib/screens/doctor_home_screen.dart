import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../app_theme.dart';
import '../data/strings.dart';
import '../state/app_state.dart';
import '../widgets/kids_background.dart';
import '../widgets/language_switcher.dart';
import 'add_medical_report_screen.dart';

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final patient = state.activeChild;
    final medReports = state.medicalReports
        .where((r) => r.patientName == patient.name)
        .toList();
    return Scaffold(
      body: KidsBackground(
        overlayOpacity: 0.62,
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
                    backgroundColor: AppColors.accentTeal,
                    child: Text('M',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900)),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(S.get('doctor_greeting'),
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.w900)),
              Text(S.get('track_patients'),
                  style: const TextStyle(color: AppColors.textMuted)),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: state.activeChildIndex,
                    isExpanded: true,
                    items: [
                      for (int i = 0; i < state.children.length; i++)
                        DropdownMenuItem(
                            value: i,
                            child: Text(state.children[i].name)),
                    ],
                    onChanged: (i) {
                      if (i != null) state.setActiveChild(i);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.accentTeal.withOpacity(0.15),
                      AppColors.primary.withOpacity(0.10),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: AppColors.accentTeal.withOpacity(0.4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      const Icon(Icons.person, color: AppColors.primary),
                      const SizedBox(width: 6),
                      Text(S.get('patient_profile'),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w900))
                    ]),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: patient.color,
                          child: Text(patient.initial,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 22)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(patient.name,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900)),
                              Text(
                                  '${S.get('age_label')}: ${patient.age} ${S.get('years_old')}'),
                              Text(
                                  '${S.get('diagnosis_label')}: ${patient.diagnosis}',
                                  style: const TextStyle(
                                      color: AppColors.textMuted)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const AddMedicalReportScreen())),
                child: Container(
                  height: 54,
                  decoration: BoxDecoration(
                    gradient: AppColors.tealGradient,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Center(
                    child: Text('+ ${S.get('add_medical_report')}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800)),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(S.get('recent_medical'),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              if (medReports.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text(S.get('no_medical_reports'),
                        style: const TextStyle(color: AppColors.textMuted)),
                  ),
                )
              else
                ...medReports.map((r) => Container(
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
                          Text(DateFormat('dd/MM/yyyy').format(r.date),
                              style: const TextStyle(
                                  color: AppColors.textMuted, fontSize: 12)),
                          if (r.observation.isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Text('${S.get('medical_observation')}:',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 13)),
                            Text(r.observation,
                                style: const TextStyle(fontSize: 13)),
                          ],
                          if (r.diagnosisUpdate.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text('${S.get('diagnosis_update')}:',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 13)),
                            Text(r.diagnosisUpdate,
                                style: const TextStyle(
                                    color: AppColors.accentPurple,
                                    fontSize: 13)),
                          ],
                          if (r.recommendations.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text('${S.get('recommendations')}:',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 13)),
                            Text(r.recommendations,
                                style: const TextStyle(fontSize: 13)),
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
