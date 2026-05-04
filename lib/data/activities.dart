import 'package:flutter/material.dart';

import 'strings.dart';

enum ActivityKind {
  colors,
  numbers,
  alphabet,
  animals,
  family,
  drawing,
  memory,
  sorting,
  emotions,
  routine,
  relaxation,
  communication,
}

class ActivityItem {
  final String titleKey;
  final String subtitleKey;
  final IconData icon;
  final Color iconColor;
  final Gradient iconGradient;
  final ActivityKind kind;
  const ActivityItem({
    required this.titleKey,
    required this.subtitleKey,
    required this.icon,
    required this.iconColor,
    required this.iconGradient,
    required this.kind,
  });

  String get title => S.get(titleKey);
  String get subtitle => S.get(subtitleKey);
}

const _gPink = LinearGradient(
  colors: [Color(0xFFFB7185), Color(0xFFF59E0B)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const _gTeal = LinearGradient(
  colors: [Color(0xFF2DD4BF), Color(0xFF14B8A6)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const _gAmber = LinearGradient(
  colors: [Color(0xFFFBBF24), Color(0xFFF97316)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const _gMagenta = LinearGradient(
  colors: [Color(0xFFEC4899), Color(0xFFA855F7)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const _gOrange = LinearGradient(
  colors: [Color(0xFFFB923C), Color(0xFFF97316)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const _gPurple = LinearGradient(
  colors: [Color(0xFF818CF8), Color(0xFFA855F7)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const _gGreen = LinearGradient(
  colors: [Color(0xFF34D399), Color(0xFF10B981)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const _gMint = LinearGradient(
  colors: [Color(0xFF34D399), Color(0xFF60A5FA)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const _gRose = LinearGradient(
  colors: [Color(0xFFFB7185), Color(0xFFF472B6)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const _gCyan = LinearGradient(
  colors: [Color(0xFF38BDF8), Color(0xFF60A5FA)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const _gSunset = LinearGradient(
  colors: [Color(0xFFFB7185), Color(0xFFFB923C)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const activities = <ActivityItem>[
  ActivityItem(
    titleKey: 'colors_learning',
    subtitleKey: 'colors_subtitle',
    icon: Icons.palette_rounded,
    iconColor: Colors.white,
    iconGradient: _gPink,
    kind: ActivityKind.colors,
  ),
  ActivityItem(
    titleKey: 'numbers_learning',
    subtitleKey: 'numbers_subtitle',
    icon: Icons.tag_rounded,
    iconColor: Colors.white,
    iconGradient: _gCyan,
    kind: ActivityKind.numbers,
  ),
  ActivityItem(
    titleKey: 'alphabet_learning',
    subtitleKey: 'alphabet_subtitle',
    icon: Icons.text_fields_rounded,
    iconColor: Colors.white,
    iconGradient: _gTeal,
    kind: ActivityKind.alphabet,
  ),
  ActivityItem(
    titleKey: 'animals_learning',
    subtitleKey: 'animals_subtitle',
    icon: Icons.pets_rounded,
    iconColor: Colors.white,
    iconGradient: _gAmber,
    kind: ActivityKind.animals,
  ),
  ActivityItem(
    titleKey: 'family_learning',
    subtitleKey: 'family_subtitle',
    icon: Icons.group_rounded,
    iconColor: Colors.white,
    iconGradient: _gMagenta,
    kind: ActivityKind.family,
  ),
  ActivityItem(
    titleKey: 'drawing_activity',
    subtitleKey: 'drawing_subtitle',
    icon: Icons.brush_rounded,
    iconColor: Colors.white,
    iconGradient: _gOrange,
    kind: ActivityKind.drawing,
  ),
  ActivityItem(
    titleKey: 'memory_cards',
    subtitleKey: 'memory_subtitle',
    icon: Icons.psychology_rounded,
    iconColor: Colors.white,
    iconGradient: _gPurple,
    kind: ActivityKind.memory,
  ),
  ActivityItem(
    titleKey: 'sorting_game',
    subtitleKey: 'sorting_subtitle',
    icon: Icons.dashboard_rounded,
    iconColor: Colors.white,
    iconGradient: _gMint,
    kind: ActivityKind.sorting,
  ),
  ActivityItem(
    titleKey: 'emotions_title',
    subtitleKey: 'emotions_subtitle',
    icon: Icons.favorite_rounded,
    iconColor: Colors.white,
    iconGradient: _gRose,
    kind: ActivityKind.emotions,
  ),
  ActivityItem(
    titleKey: 'routine_title',
    subtitleKey: 'routine_subtitle',
    icon: Icons.calendar_month_rounded,
    iconColor: Colors.white,
    iconGradient: _gCyan,
    kind: ActivityKind.routine,
  ),
  ActivityItem(
    titleKey: 'relaxation_title',
    subtitleKey: 'relaxation_subtitle',
    icon: Icons.spa_rounded,
    iconColor: Colors.white,
    iconGradient: _gGreen,
    kind: ActivityKind.relaxation,
  ),
  ActivityItem(
    titleKey: 'communication_title',
    subtitleKey: 'communication_subtitle',
    icon: Icons.chat_rounded,
    iconColor: Colors.white,
    iconGradient: _gSunset,
    kind: ActivityKind.communication,
  ),
];

class VideoItem {
  final String titleKey;
  final String tagKey;
  final String duration;
  final IconData icon;
  final Gradient gradient;
  const VideoItem({
    required this.titleKey,
    required this.tagKey,
    required this.duration,
    required this.icon,
    required this.gradient,
  });

  String get title => S.get(titleKey);
  String get tag => S.get(tagKey);
}

const videos = <VideoItem>[
  VideoItem(
    titleKey: 'video_hand_washing',
    tagKey: 'video_daily_life',
    duration: '4 min',
    icon: Icons.wash_rounded,
    gradient: LinearGradient(
      colors: [Color(0xFF60A5FA), Color(0xFF22D3EE)],
    ),
  ),
  VideoItem(
    titleKey: 'video_greeting',
    tagKey: 'video_social',
    duration: '3 min',
    icon: Icons.handshake_rounded,
    gradient: LinearGradient(
      colors: [Color(0xFFEC4899), Color(0xFFF59E0B)],
    ),
  ),
  VideoItem(
    titleKey: 'video_counting',
    tagKey: 'video_cognitive',
    duration: '5 min',
    icon: Icons.calculate_rounded,
    gradient: LinearGradient(
      colors: [Color(0xFF8B5CF6), Color(0xFF22D3EE)],
    ),
  ),
];
