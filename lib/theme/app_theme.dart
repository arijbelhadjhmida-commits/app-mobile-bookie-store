import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const Color ink = Color(0xFF1C1917);
  static const Color inkLight = Color(0xFF292524);
  static const Color gold = Color(0xFFD4A853);
  static const Color goldLight = Color(0xFFF5D78E);
  static const Color cream = Color(0xFFFAF7F2);
  static const Color creamDark = Color(0xFFF0E9DF);
  static const Color sage = Color(0xFF6B8F71);
  static const Color terracotta = Color(0xFFB5563A);
  static const Color muted = Color(0xFF78716C);
  static const Color mutedLight = Color(0xFFA8A29E);

  // Gradients
  static const LinearGradient inkGradient = LinearGradient(
    colors: [Color(0xFF1C1917), Color(0xFF3B2F2F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFD4A853), Color(0xFFF5D78E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Text styles
  static const TextStyle displayLarge = TextStyle(
    fontFamily: 'Georgia',
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: ink,
    letterSpacing: -0.5,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: 'Georgia',
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: ink,
  );

  static const TextStyle titleLarge = TextStyle(
    fontFamily: 'Georgia',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: ink,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 15,
    color: ink,
    height: 1.6,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: muted,
    letterSpacing: 0.3,
  );

  // Shadows
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: const Color(0xFF1C1917).withOpacity(0.08),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> elevatedShadow = [
    BoxShadow(
      color: const Color(0xFF1C1917).withOpacity(0.15),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];

  // Border radius
  static final BorderRadius cardRadius = BorderRadius.circular(20);
  static final BorderRadius buttonRadius = BorderRadius.circular(14);
  static final BorderRadius chipRadius = BorderRadius.circular(24);

  // Category emoji map
  static const Map<String, String> categoryEmoji = {
    'Tous': '✨',
    'Développement personnel': '🌱',
    'Productivité': '⚡',
    'Finance': '💰',
    'Roman': '📖',
    'Psychologie': '🧠',
    'Science & Tech': '🔬',
    'Histoire': '🏛️',
    'Philosophie': '💭',
    'Biographie': '👤',
    'Jeunesse': '🌟',
  };

  static String emojiFor(String category) => categoryEmoji[category] ?? '📚';
}
