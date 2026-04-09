import 'package:flutter/material.dart';
import 'package:polymorphism/core/constant.dart';
import 'package:polymorphism/core/theme/app_theme.dart';
import 'package:polymorphism/shared/animations/scroll_reveal.dart';
import 'package:polymorphism/shared/utils/skill_icon_helper.dart';
import 'package:polymorphism/shared/widgets/skill_orb.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding(context),
        vertical: AppSpacing.xxxl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScrollReveal(
            child: Text(
              '(Skills.)',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          ScrollReveal(
            delay: const Duration(milliseconds: 200),
            child: Center(
              child: Wrap(
                spacing: 30.0,
                runSpacing: 30.0,
                alignment: WrapAlignment.center,
                children: [
                  SkillOrb(
                    icon: getSkillIcon('React'),
                    label: 'React Native',
                    brandColor: const Color(0xFF61DAFB),
                  ),
                  SkillOrb(
                    icon: getSkillIcon('Node'),
                    label: 'Node.js',
                    brandColor: const Color(0xFF339933),
                  ),
                  SkillOrb(
                    icon: getSkillIcon('Express'),
                    label: 'Express.js',
                    brandColor: Colors.white,
                  ),
                  SkillOrb(
                    icon: getSkillIcon('JavaScript'),
                    label: 'JavaScript',
                    brandColor: const Color(0xFFF7DF1E),
                  ),
                  SkillOrb(
                    icon: getSkillIcon('HTML'),
                    label: 'HTML',
                    brandColor: const Color(0xFFE34F26),
                  ),
                  SkillOrb(
                    icon: getSkillIcon('CSS'),
                    label: 'CSS',
                    brandColor: const Color(0xFF1572B6),
                  ),
                  SkillOrb(
                    icon: getSkillIcon('MongoDB'),
                    label: 'MongoDB',
                    brandColor: const Color(0xFF47A248),
                  ),
                  SkillOrb(
                    icon: getSkillIcon('Flutter'),
                    label: 'Flutter',
                    brandColor: Colors.blue,
                  ),
                  SkillOrb(
                    icon: getSkillIcon('FastAPI'),
                    label: 'FastAPI',
                    brandColor: Colors.teal,
                  ),
                  SkillOrb(
                    icon: getSkillIcon('Python'),
                    label: 'Python',
                    brandColor: Colors.yellow,
                  ),
                  SkillOrb(
                    icon: getSkillIcon('Java'),
                    label: 'Java',
                    brandColor: Colors.red,
                  ),
                  SkillOrb(
                    icon: getSkillIcon('Dart'),
                    label: 'Dart',
                    brandColor: Colors.indigo,
                  ),
                  SkillOrb(
                    icon: getSkillIcon('PHP'),
                    label: 'PHP',
                    brandColor: Colors.brown,
                  ),
                  SkillOrb(
                    icon: getSkillIcon('SQL'),
                    label: 'SQL',
                    brandColor: Colors.blueGrey,
                  ),
                  SkillOrb(
                    icon: getSkillIcon('NoSQL'),
                    label: 'NoSQL',
                    brandColor: Colors.tealAccent,
                  ),
                  SkillOrb(
                    icon: getSkillIcon('GraphQL'),
                    label: 'GraphQL',
                    brandColor: Colors.deepPurpleAccent,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
