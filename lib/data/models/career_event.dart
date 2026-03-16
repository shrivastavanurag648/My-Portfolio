import 'package:flutter/material.dart';

@immutable
class CareerEvent {
  const CareerEvent({
    required this.year,
    required this.title,
    required this.description,
    required this.icon,
    this.company,
    this.location,
  });
  final int year;
  final String title;
  final String description;
  final IconData icon;
  final String? company;
  final String? location;

  static List<CareerEvent> get sampleEvents => [
    const CareerEvent(
      year: 2025,
      title: 'Started Programming with Java',
      description:
          'Began my programming journey learning Java and core programming fundamentals including loops, conditions, and object-oriented programming.',
      icon: Icons.code,
      company: 'Early 2025',
      location: 'Learning Phase',
    ),

    const CareerEvent(
      year: 2025,
      title: 'Exploring Data Structures & Algorithms',
      description:
          'Started studying DSA concepts including recursion, backtracking, and problem solving techniques.',
      icon: Icons.psychology,
      company: 'Mid 2025',
      location: 'Algorithmic Thinking',
    ),

    const CareerEvent(
      year: 2025,
      title: 'Building Programming Projects',
      description:
          'Applied programming knowledge by building Java programs and experimenting with real coding problems.',
      icon: Icons.build,
      company: 'Late 2025',
      location: 'Project Development',
    ),

    CareerEvent(
      year: DateTime.now().year,
      title: 'Continuous Growth & Learning',
      description:
          'Continuously improving programming skills, learning new technologies, and building projects to grow as a software developer.',
      icon: Icons.auto_awesome,
    ),
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CareerEvent &&
          runtimeType == other.runtimeType &&
          year == other.year &&
          title == other.title &&
          description == other.description &&
          icon == other.icon &&
          company == other.company &&
          location == other.location;

  @override
  int get hashCode =>
      year.hashCode ^
      title.hashCode ^
      description.hashCode ^
      icon.hashCode ^
      company.hashCode ^
      location.hashCode;

  @override
  String toString() =>
      'CareerEvent(year: $year, title: $title, company: $company)';
}
