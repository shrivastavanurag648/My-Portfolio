import 'package:flutter/material.dart';

Widget getSkillIcon(String techName) {
  final lowercaseName = techName.toLowerCase();

  // --- FRONTEND & MOBILE ---
  if (lowercaseName.contains('react')) {
    return Image.asset(
      'icons/react.png',
      height: 40,
      fit: BoxFit.contain,
      errorBuilder:
          (context, error, stackTrace) =>
              const Icon(Icons.code, color: Color(0xFF61DAFB), size: 40),
    );
  } else if (lowercaseName.contains('javascript') || lowercaseName == 'js') {
    return Image.asset(
      'icons/javascript.png',
      height: 40,
      fit: BoxFit.contain,
      errorBuilder:
          (context, error, stackTrace) =>
              const Icon(Icons.javascript, color: Color(0xFFF7DF1E), size: 40),
    );
  } else if (lowercaseName.contains('html')) {
    return Image.asset(
      'icons/html.png',
      height: 40,
      fit: BoxFit.contain,
      errorBuilder:
          (context, error, stackTrace) =>
              const Icon(Icons.html, color: Color(0xFFE34F26), size: 40),
    );
  } else if (lowercaseName.contains('css')) {
    return Image.asset(
      'icons/css.png',
      height: 40,
      fit: BoxFit.contain,
      errorBuilder:
          (context, error, stackTrace) =>
              const Icon(Icons.css, color: Color(0xFF1572B6), size: 40),
    );
  } else if (lowercaseName.contains('flutter')) {
    return Image.asset(
      'icons/flutter.png',
      height: 40,
      fit: BoxFit.contain,
      errorBuilder:
          (context, error, stackTrace) =>
              const Icon(Icons.flutter_dash, color: Colors.blue, size: 40),
    );
  }
  // --- BACKEND & RUNTIMES ---
  else if (lowercaseName.contains('node')) {
    return Image.asset(
      'icons/node.png',
      height: 40,
      fit: BoxFit.contain,
      errorBuilder:
          (context, error, stackTrace) =>
              const Icon(Icons.javascript, color: Color(0xFF339933), size: 40),
    );
  } else if (lowercaseName.contains('express')) {
    return Image.asset(
      'icons/express.png',
      height: 40,
      fit: BoxFit.contain,
      errorBuilder:
          (context, error, stackTrace) => const Icon(
            Icons.settings_applications,
            color: Colors.white,
            size: 40,
          ),
    );
  } else if (lowercaseName.contains('fastapi')) {
    return Image.asset(
      'icons/fastapi.png',
      height: 40,
      fit: BoxFit.contain,
      errorBuilder:
          (context, error, stackTrace) =>
              const Icon(Icons.api, color: Colors.teal, size: 40),
    );
  }
  // --- DATABASES ---
  else if (lowercaseName.contains('mongodb') ||
      lowercaseName.contains('mongo')) {
    return Image.asset(
      'icons/mongodb.png',
      height: 40,
      fit: BoxFit.contain,
      errorBuilder:
          (context, error, stackTrace) =>
              const Icon(Icons.storage, color: Color(0xFF47A248), size: 40),
    );
  } else if (lowercaseName.contains('nosql')) {
    return Image.asset(
      'icons/nosql.png',
      height: 40,
      fit: BoxFit.contain,
      errorBuilder:
          (context, error, stackTrace) =>
              const Icon(Icons.dns, color: Colors.tealAccent, size: 40),
    );
  } else if (lowercaseName.contains('graphql')) {
    return Image.asset(
      'icons/graphql.png',
      height: 40,
      fit: BoxFit.contain,
      errorBuilder:
          (context, error, stackTrace) =>
              const Icon(Icons.hub, color: Colors.deepPurpleAccent, size: 40),
    );
  } else if (lowercaseName.contains('sql')) {
    return Image.asset(
      'icons/sql.png',
      height: 40,
      fit: BoxFit.contain,
      errorBuilder:
          (context, error, stackTrace) =>
              const Icon(Icons.storage, color: Colors.blueGrey, size: 40),
    );
  }

  // --- PROGRAMMING LANGUAGES (Exact matches / Switches) ---
  switch (lowercaseName) {
    case 'python':
      return Image.asset(
        'icons/python.png',
        height: 40,
        fit: BoxFit.contain,
        errorBuilder:
            (context, error, stackTrace) =>
                const Icon(Icons.data_object, size: 40, color: Colors.yellow),
      );
    case 'c':
    case 'c++':
      return const Icon(Icons.terminal, size: 40, color: Colors.indigo);
    case 'java':
      return Image.asset(
        'icons/java.png',
        height: 40,
        fit: BoxFit.contain,
        errorBuilder:
            (context, error, stackTrace) =>
                const Icon(Icons.coffee, size: 40, color: Colors.red),
      );
    case 'dart':
      return Image.asset(
        'icons/dart.png',
        height: 40,
        fit: BoxFit.contain,
        errorBuilder:
            (context, error, stackTrace) =>
                const Icon(Icons.code, size: 40, color: Colors.indigo),
      );
    case 'php':
      return Image.asset(
        'icons/php.png',
        height: 40,
        fit: BoxFit.contain,
        errorBuilder:
            (context, error, stackTrace) =>
                const Icon(Icons.language, size: 40, color: Colors.brown),
      );
    default:
      // Ultimate fallback for anything not explicitly defined
      return const Icon(Icons.code, size: 40, color: Colors.grey);
  }
}
