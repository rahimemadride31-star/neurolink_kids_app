import '../data/strings.dart';
import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../widgets/kids_background.dart';
import 'assessment_results_screen.dart';

class AssessmentCategory {
  final String titleKey;
  final IconData icon;
  final Color color;
  final List<String> questionKeys;
  const AssessmentCategory({
    required this.titleKey,
    required this.icon,
    required this.color,
    required this.questionKeys,
  });
  String get title => S.get(titleKey);
  List<String> get questions => questionKeys.map(S.get).toList();
}

const assessmentCategories = <AssessmentCategory>[
  AssessmentCategory(
    titleKey: 'social_communication',
    icon: Icons.groups_2_rounded,
    color: Color(0xFF22C55E),
    questionKeys: [
      'q_eye_contact',
      'q_respond_name',
      'q_express_needs',
      'q_initiate_convo',
      'q_simple_instructions',
      'q_imitate_gestures',
      'q_share_interests',
      'q_complete_sentences',
      'q_understand_humor',
      'q_cooperative_play',
    ],
  ),
  AssessmentCategory(
    titleKey: 'behaviors_routines',
    icon: Icons.chat_bubble_rounded,
    color: Color(0xFF3B82F6),
    questionKeys: [
      'q_insist_routines',
      'q_react_changes',
      'q_repetitive_movements',
      'q_align_toys',
      'q_restricted_interests',
      'q_refuse_new_activities',
      'q_anxious_unexpected',
      'q_repeat_phrases',
      'q_stare_moving',
      'q_react_interruptions',
    ],
  ),
  AssessmentCategory(
    titleKey: 'sensory_sensitivity',
    icon: Icons.headphones,
    color: Color(0xFF334155),
    questionKeys: [
      'q_cover_ears',
      'q_refuse_clothes',
      'q_avoid_lights',
      'q_seek_pressure',
      'q_food_texture',
      'q_noisy_environments',
      'q_smell_objects',
      'q_spin_without_dizzy',
      'q_avoid_physical_contact',
      'q_low_pain_sensitivity',
    ],
  ),
  AssessmentCategory(
    titleKey: 'emotional_regulation',
    icon: Icons.favorite_rounded,
    color: Color(0xFFEC4899),
    questionKeys: [
      'q_express_emotions',
      'q_identify_others_emotions',
      'q_calm_after_crisis',
      'q_seek_comfort',
      'q_show_empathy',
      'q_react_frustration',
      'q_tolerate_losing',
      'q_imaginative_play',
      'q_understand_social_rules',
      'q_prefer_alone',
    ],
  ),
  AssessmentCategory(
    titleKey: 'daily_life_development',
    icon: Icons.auto_awesome,
    color: Color(0xFF22C55E),
    questionKeys: [
      'q_eat_independently',
      'q_dress_alone',
      'q_stable_sleep',
      'q_difficulty_concentrate',
      'q_learn_new_skills',
      'q_finish_tasks',
      'q_multi_step_instructions',
      'q_manage_transitions',
      'q_fine_motor_delay',
      'q_gross_motor_delay',
    ],
  ),
];

List<(String, Color)> _getAnswers() => [
  ('0 - ${S.get('never')}', AppColors.accentGreen),
  ('1 - ${S.get('rarely')}', const Color(0xFF60A5FA)),
  ('2 - ${S.get('sometimes')}', const Color(0xFFFBBF24)),
  ('3 - ${S.get('often')}', const Color(0xFFFB923C)),
  ('4 - ${S.get('always')}', AppColors.accentRed),
];

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  int _index = 0;
  final Map<int, int> _responses = {};

  int get _total =>
      assessmentCategories.fold(0, (sum, c) => sum + c.questionKeys.length);

  ({AssessmentCategory cat, int qInCat}) _locate(int globalIndex) {
    int remaining = globalIndex;
    for (final c in assessmentCategories) {
      if (remaining < c.questionKeys.length) {
        return (cat: c, qInCat: remaining);
      }
      remaining -= c.questionKeys.length;
    }
    return (cat: assessmentCategories.last, qInCat: assessmentCategories.last.questionKeys.length - 1);
  }

  void _select(int answerIdx) {
    setState(() {
      _responses[_index] = answerIdx;
    });
    Future.delayed(const Duration(milliseconds: 220), () {
      if (!mounted) return;
      if (_index < _total - 1) {
        setState(() => _index++);
      } else {
        _finish();
      }
    });
  }

  void _finish() {
    final perCategory = <AssessmentCategory, int>{};
    int globalIndex = 0;
    for (final c in assessmentCategories) {
      int s = 0;
      for (int i = 0; i < c.questionKeys.length; i++) {
        s += _responses[globalIndex] ?? 0;
        globalIndex++;
      }
      perCategory[c] = s;
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => AssessmentResultsScreen(scores: perCategory),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = _locate(_index);
    final cat = loc.cat;
    final selected = _responses[_index];
    final answers = _getAnswers();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () {
            if (_index > 0) {
              setState(() => _index--);
            } else {
              Navigator.of(context).maybePop();
            }
          },
        ),
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('📋 ',
                    style: TextStyle(fontSize: 18)),
                Text(S.get('evaluation_test'),
                    style: const TextStyle(fontWeight: FontWeight.w800)),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              '${S.get('question_label')} ${_index + 1} / $_total',
              style:
                  const TextStyle(fontSize: 13, color: AppColors.textMuted),
            ),
          ],
        ),
        toolbarHeight: 64,
      ),
      body: KidsBackground(
        overlayOpacity: 0.62,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: (_index + 1) / _total,
                minHeight: 6,
                backgroundColor: AppColors.border,
                valueColor: const AlwaysStoppedAnimation(AppColors.accentTeal),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(cat.icon,
                              size: 18, color: AppColors.primary),
                          const SizedBox(width: 8),
                          Text(cat.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${S.get('question_label')} ${loc.qInCat + 1} / ${cat.questionKeys.length}',
                      style: const TextStyle(color: AppColors.textMuted),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Text(
                        cat.questions[loc.qInCat],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          height: 1.35,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(S.get('response_mode'),
                        style: const TextStyle(color: AppColors.textMuted)),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _Legend('0 =', S.get('never')),
                        _Legend('1 =', S.get('rarely')),
                        _Legend('2 =', S.get('sometimes')),
                        _Legend('3 =', S.get('often')),
                        _Legend('4 =', S.get('always')),
                      ],
                    ),
                    const SizedBox(height: 14),
                    ...List.generate(answers.length, (i) {
                      final (label, color) = answers[i];
                      final isSel = selected == i;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          decoration: BoxDecoration(
                            gradient: isSel
                                ? LinearGradient(colors: [
                                    color.withOpacity(0.85),
                                    color,
                                  ])
                                : null,
                            color: isSel ? null : Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: isSel ? color : AppColors.border,
                            ),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(18),
                              onTap: () => _select(i),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 18),
                                child: Center(
                                  child: Text(
                                    label,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: isSel
                                          ? Colors.white
                                          : AppColors.textDark,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 6,
                runSpacing: 6,
                children: List.generate(_total, (i) {
                  final answered = _responses.containsKey(i);
                  final current = i == _index;
                  return Container(
                    width: current ? 14 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: current
                          ? AppColors.primary
                          : answered
                              ? AppColors.accentTeal
                              : AppColors.border,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final String num;
  final String text;
  const _Legend(this.num, this.text);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(num,
            style: const TextStyle(
                fontWeight: FontWeight.w800, fontSize: 12)),
        Text(text,
            style:
                const TextStyle(color: AppColors.textMuted, fontSize: 11)),
      ],
    );
  }
}
