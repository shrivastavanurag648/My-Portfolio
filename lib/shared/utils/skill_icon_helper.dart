import 'package:flutter/material.dart';

Widget getSkillIcon(String techName) {
  final lowercaseName = techName.toLowerCase();

  // Handle specific assets based on logo additions
  if (lowercaseName.contains('react')) {
    return Image.asset(
      'assets/icons/react.png',
      height: 40,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => const Icon(Icons.code, color: Color(0xFF61DAFB), size: 40),
    );
  } else if (lowercaseName.contains('node')) {
    return Image.asset(
      'assets/icons/node.png',
      height: 40,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => const Icon(Icons.javascript, color: Color(0xFF339933), size: 40),
    );
  } else if (lowercaseName.contains('mongodb') || lowercaseName.contains('mongo')) {
    return Image.asset(
      'assets/icons/mongodb.png',
      height: 40,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => const Icon(Icons.storage, color: Color(0xFF47A248), size: 40),
    );
  }

  // Fallback to Flutter Icons for standard technologies
  switch (lowercaseName) {
    case 'flutter':
      return const Icon(Icons.flutter_dash, size: 40, color: Colors.blue);
    case 'javascript':
    case 'js':
      return const Icon(Icons.javascript, size: 40, color: Color(0xFFF7DF1E));
    case 'html':
    case 'html5':
      return const Icon(Icons.html, size: 40, color: Color(0xFFE34F26));
    case 'css':
    case 'css3':
      return const Icon(Icons.css, size: 40, color: Color(0xFF1572B6));
    case 'express.js':
    case 'express':
      // Express is often represented by a minimal text or gear icon
      return const Icon(Icons.settings_applications, size: 40, color: Colors.white);
    case 'fastapi':
      return const Icon(Icons.api, size: 40, color: Colors.teal);
    case 'python':
      return const Icon(Icons.data_object, size: 40, color: Colors.yellow);
    case 'c':
    case 'c++':
      return const Icon(Icons.terminal, size: 40, color: Colors.indigo);
    default:
      return const Icon(Icons.code, size: 40, color: Colors.grey);
  }
}
