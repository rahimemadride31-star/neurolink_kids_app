import '../data/strings.dart';
import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../models/child.dart';
import '../state/app_state.dart';
import '../widgets/kids_background.dart';
import '../widgets/primary_button.dart';
import 'assessment_screen.dart';

class AddChildScreen extends StatefulWidget {
  const AddChildScreen({super.key});

  @override
  State<AddChildScreen> createState() => _AddChildScreenState();
}

class _AddChildScreenState extends State<AddChildScreen> {
  final _name = TextEditingController();
  final _age = TextEditingController();
  final _school = TextEditingController();
  String _gender = 'Boy';
  String _diagnosis = 'Not diagnosed';
  bool _startedSchool = true;

  List<String> get _diagnoses => [
    S.get('autism'),
    S.get('adhd'),
    S.get('speech_delay'),
    S.get('learning_difficulty'),
    S.get('not_diagnosed'),
  ];

  @override
  void dispose() {
    _name.dispose();
    _age.dispose();
    _school.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.get('add_a_child')),
      ),
      body: KidsBackground(
        overlayOpacity: 0.60,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Label(S.get('child_name')),
              TextField(
                controller: _name,
                decoration: InputDecoration(
                  hintText: S.get('example_name'),
                  prefixIcon: Icon(Icons.child_care),
                ),
              ),
              const SizedBox(height: 14),
              _Label(S.get('age_label')),
              TextField(
                controller: _age,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: S.get('example_age'),
                  prefixIcon: Icon(Icons.cake_outlined),
                ),
              ),
              const SizedBox(height: 14),
              _Label(S.get('gender_label')),
              Row(
                children: [
                  _Pill(
                    label: S.get('boy'),
                    selected: _gender == 'Boy',
                    onTap: () => setState(() => _gender = 'Boy'),
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 10),
                  _Pill(
                    label: S.get('girl'),
                    selected: _gender == 'Girl',
                    onTap: () => setState(() => _gender = 'Girl'),
                    color: AppColors.accentPink,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _Label(S.get('school_name')),
              TextField(
                controller: _school,
                decoration: InputDecoration(
                  hintText: S.get('school_name'),
                  prefixIcon: Icon(Icons.school_outlined),
                ),
              ),
              const SizedBox(height: 14),
              _Label(S.get('diagnosis_type')),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _diagnoses
                    .map((d) => _Pill(
                          label: d,
                          selected: _diagnosis == d,
                          onTap: () => setState(() => _diagnosis = d),
                          color: AppColors.accentPurple,
                        ))
                    .toList(),
              ),
              const SizedBox(height: 14),
              _Label(S.get('started_school')),
              Row(
                children: [
                  _Pill(
                    label: S.get('yes'),
                    selected: _startedSchool,
                    onTap: () => setState(() => _startedSchool = true),
                    color: AppColors.accentGreen,
                  ),
                  const SizedBox(width: 10),
                  _Pill(
                    label: S.get('no'),
                    selected: !_startedSchool,
                    onTap: () => setState(() => _startedSchool = false),
                    color: AppColors.accentRed,
                  ),
                ],
              ),
              const SizedBox(height: 26),
              PrimaryButton(
                label: S.get('continue_assessment'),
                icon: Icons.arrow_forward,
                gradient: AppColors.blueGradient,
                onPressed: _save,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  void _save() {
    if (_name.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.get('enter_child_name'))),
      );
      return;
    }
    final state = AppStateScope.of(context);
    state.addChild(ChildProfile(
      name: _name.text.trim(),
      age: int.tryParse(_age.text) ?? 6,
      gender: _gender,
      school: _school.text,
      diagnosis: _diagnosis,
      startedSchool: _startedSchool,
      color: _gender == 'Girl' ? AppColors.accentPink : AppColors.primary,
    ));
    state.setActiveChild(state.children.length - 1);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => const AssessmentScreen(),
    ));
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 6, top: 4),
        child: Text(text,
            style: const TextStyle(
                fontWeight: FontWeight.w800, color: AppColors.textDark)),
      );
}

class _Pill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color color;
  const _Pill({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? color : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? color : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : AppColors.textDark,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
