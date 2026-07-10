import 'package:flutter/material.dart';
import '../widgets/certificates/certificates_section.dart';
import '../widgets/contact/contact_section.dart';
import '../widgets/current_focus/current_focus_section.dart';
import '../widgets/education/education_section.dart';
import '../widgets/experience/experience_section.dart';
import '../widgets/featured_project/featured_project_section.dart';
import '../widgets/hero/hero_section.dart';
import '../widgets/other_projects/other_projects_section.dart';
import '../widgets/quick_snapshot/quick_snapshot_section.dart';
import '../widgets/skills/skills_section.dart';

/// The portfolio's home page — all sections implemented.
///
/// Section order matches PROJECT_CONTEXT.md exactly:
/// 1. Hero                (Prompt 5)
/// 2. Quick Snapshot      (Prompt 6.1)
/// 3. Current Focus       (Prompt 6.2)
/// 4. Skills              (Prompt 6.3)
/// 5. Professional Exp.   (Prompt 6.4)
/// 6. Featured Project    (Prompt 6.5)
/// 7. Other Projects      (Prompt 6.6)
/// 8. Education           (Prompt 6.7)
/// 9. Certifications      (Prompt 6.8)
/// 10. Contact            (Prompt 6.9)
///
/// Resume section lives at /resume (dedicated page via GoRouter).
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        HeroSection(),
        QuickSnapshotSection(),
        CurrentFocusSection(),
        SkillsSection(),
        ExperienceSection(),
        FeaturedProjectSection(),
        OtherProjectsSection(),
        EducationSection(),
        CertificatesSection(),
        ContactSection(),
      ],
    );
  }
}
