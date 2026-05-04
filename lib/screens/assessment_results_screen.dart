import '../data/strings.dart';
import 'package:flutter/material.dart';

import '../app_theme.dart';
import 'assessment_screen.dart';
import 'home_shell.dart';

class AssessmentResultsScreen extends StatelessWidget {
  final Map<AssessmentCategory, int> scores;
  const AssessmentResultsScreen({super.key, required this.scores});

  static const int _maxPerCategory = 40;

  int get _total => scores.values.fold(0, (a, b) => a + b);
  int get _max => scores.length * _maxPerCategory;
  double get _ratio => _max == 0 ? 0 : _total / _max;

  ({String title, String level, LinearGradient gradient}) get _verdict {
    if (_ratio < 0.30) {
      return (
        title: S.get('low_signs'),
        level: S.get('level_0'),
        gradient: const LinearGradient(
          colors: [Color(0xFF34D399), Color(0xFF10B981)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      );
    }
    if (_ratio < 0.50) {
      return (
        title: S.get('mild_signs'),
        level: S.get('level_1'),
        gradient: const LinearGradient(
          colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      );
    }
    if (_ratio < 0.70) {
      return (
        title: S.get('moderate_signs'),
        level: S.get('level_2'),
        gradient: const LinearGradient(
          colors: [Color(0xFFFB923C), Color(0xFFF97316)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      );
    }
    return (
      title: S.get('marked_signs'),
      level: S.get('level_3'),
      gradient: const LinearGradient(
        colors: [Color(0xFFFB7185), Color(0xFFF59E0B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }

  static ({String label, Color color}) levelFor(int score) {
    final r = score / _maxPerCategory;
    if (r < 0.50) return (label: S.get('low_level'), color: const Color(0xFF22C55E));
    if (r < 0.67) return (label: S.get('moderate_level'), color: const Color(0xFFF59E0B));
    return (label: S.get('high_level'), color: const Color(0xFFEF4444));
  }

  @override
  Widget build(BuildContext context) {
    final v = _verdict;
    final entries = scores.entries.toList();
    final top3 = [...entries]..sort((a, b) => b.value.compareTo(a.value));

    return Scaffold(
      backgroundColor: const Color(0xFFFBF8FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          color: Colors.black87,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('📊  ', style: TextStyle(fontSize: 18)),
            Text(
              S.get('assessment_results'),
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEFF1FF), Color(0xFFFFF1F4)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
          children: [
            Center(
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  size: 36,
                  color: Color(0xFFEF4444),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              S.get('evaluation_completed'),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              S.get('estimated_result'),
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textMuted),
            ),
            const SizedBox(height: 18),
            _VerdictCard(
              title: v.title,
              level: v.level,
              gradient: v.gradient,
            ),
            const SizedBox(height: 18),
            _ScoresCard(entries: entries),
            const SizedBox(height: 16),
            _DifficultiesCard(entries: top3.take(3).toList()),
            const SizedBox(height: 16),
            const _DisclaimerCard(),
            const SizedBox(height: 18),
            SizedBox(
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF60A5FA),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const HomeShell()),
                    (_) => false,
                  );
                },
                child: Text(S.get('back_to_dashboard')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VerdictCard extends StatelessWidget {
  final String title;
  final String level;
  final LinearGradient gradient;
  const _VerdictCard({
    required this.title,
    required this.level,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            level,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoresCard extends StatelessWidget {
  final List<MapEntry<AssessmentCategory, int>> entries;
  const _ScoresCard({required this.entries});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.get('category_scores'),
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 12),
          for (final e in entries) ...[
            _CategoryScoreRow(category: e.key, score: e.value),
            const SizedBox(height: 14),
          ],
        ],
      ),
    );
  }
}

class _CategoryScoreRow extends StatelessWidget {
  final AssessmentCategory category;
  final int score;
  const _CategoryScoreRow({required this.category, required this.score});

  @override
  Widget build(BuildContext context) {
    final lvl = AssessmentResultsScreen.levelFor(score);
    final ratio = score / 40;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(category.icon, color: category.color, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                category.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F2937),
                ),
              ),
            ),
            Text(
              '$score/40',
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                color: Color(0xFF1F2937),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: ratio.clamp(0, 1),
                  minHeight: 8,
                  backgroundColor: const Color(0xFFE5E7EB),
                  valueColor: AlwaysStoppedAnimation(lvl.color),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              lvl.label,
              style: TextStyle(
                color: lvl.color,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DifficultiesCard extends StatelessWidget {
  final List<MapEntry<AssessmentCategory, int>> entries;
  const _DifficultiesCard({required this.entries});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.get('main_difficulties'),
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 12),
          for (final e in entries) ...[
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF59E0B),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(e.key.icon, color: e.key.color, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    e.key.title,
                    style: const TextStyle(
                      color: Color(0xFF1F2937),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _DisclaimerCard extends StatelessWidget {
  const _DisclaimerCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7ED),
        border: Border.all(color: const Color(0xFFFCD9A8)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline_rounded, color: Color(0xFFF59E0B)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '⚠ ${S.get('disclaimer_title')}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF92400E),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  S.get('disclaimer_text'),
                  style: const TextStyle(
                    color: Color(0xFF92400E),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
