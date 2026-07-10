import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_radius.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/utils/responsive_utils.dart';
import '../../../../../data/profile.dart';
import '../../../../../data/models/profile_model.dart';
import '../../../../../data/models/social_model.dart';
import '../../../../../data/providers/data_providers.dart';
import '../../../../../shared/widgets/badges/open_to_work_badge.dart';
import '../../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../../shared/widgets/common/async_value_widget.dart';
import '../../../../../shared/widgets/section/section_container.dart';
import '../../../../../services/analytics_service.dart';
import '../../../../../services/link_launcher.dart';
import '../../../../../shared/widgets/section/section_header.dart';
import '../../../../../shared/widgets/typography/app_text.dart';

/// Contact section — the final section on the home page.
///
/// Layout:
/// - Desktop: left info panel (40%) / right form (60%)
/// - Mobile/Tablet: info panel stacked above form
///
/// Contains:
/// - [_ContactInfoPanel]: availability badge, direct contact rows
/// - [_ContactForm]: name, email, subject, message with validation
///
/// Form state is managed with [TextEditingController]s and a
/// [GlobalKey<FormState>] — no extra state management needed.
/// The submit handler is a stub; email delivery is wired later.
///
/// Source data: [profileProvider] + [primarySocialsProvider].
class ContactSection extends ConsumerWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);
    final socialsAsync = ref.watch(primarySocialsProvider);

    return SectionContainer(
      id: 'contact',
      child: AsyncValueWidget<ProfileModel>(
        value: profileAsync,
        data: (profile) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              eyebrow: 'Let\'s Talk',
              title: AppStrings.sectionContact,
              subtitle: 'Open to remote opportunities, collaborations, and '
                  'interesting Flutter projects.',
            ),
            const SizedBox(height: AppSpacing.xxl),
            _ContactLayout(
              profile: profile,
              socialsAsync: socialsAsync,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Responsive layout switcher
// ---------------------------------------------------------------------------

class _ContactLayout extends StatelessWidget {
  const _ContactLayout({
    required this.profile,
    required this.socialsAsync,
  });

  final ProfileModel profile;
  final AsyncValue<List<SocialModel>> socialsAsync;

  @override
  Widget build(BuildContext context) {
    final isDesktop = deviceTypeOf(context).isDesktop;

    final infoPanel = _ContactInfoPanel(
      profile: profile,
      socialsAsync: socialsAsync,
    );
    const form = _ContactForm();

    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 4, child: infoPanel),
          const SizedBox(width: AppSpacing.xxl),
          const Expanded(flex: 6, child: form),
        ],
      );
    }

    return Column(
      children: [
        infoPanel,
        const SizedBox(height: AppSpacing.xxl),
        form,
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Left info panel
// ---------------------------------------------------------------------------

class _ContactInfoPanel extends StatelessWidget {
  const _ContactInfoPanel({
    required this.profile,
    required this.socialsAsync,
  });

  final ProfileModel profile;
  final AsyncValue<List<SocialModel>> socialsAsync;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Availability card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: isDark ? 0.10 : 0.07),
            borderRadius: AppRadius.mdBorderRadius,
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.22),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const OpenToWorkBadge(),
              const SizedBox(height: AppSpacing.md),
              AppText.titleMd(profile.availability),
              const SizedBox(height: AppSpacing.sm),
              AppText.muted(
                'Based in ${profile.locationLine}, ${profile.country}. '
                'Available for remote roles worldwide.',
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.xl),

        const AppText.label(AppStrings.orReachVia),
        const SizedBox(height: AppSpacing.md),

        // Social / direct contact rows
        AsyncValueWidget<List<SocialModel>>(
          value: socialsAsync,
          loading: const SizedBox(height: 140),
          data: (socials) => Column(
            children: socials.map((s) => _SocialContactRow(social: s)).toList(),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Single direct-contact row
// ---------------------------------------------------------------------------

class _SocialContactRow extends StatefulWidget {
  const _SocialContactRow({required this.social});
  final SocialModel social;

  @override
  State<_SocialContactRow> createState() => _SocialContactRowState();
}

class _SocialContactRowState extends State<_SocialContactRow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: () {
            AnalyticsService.trackContactClick(
              platform: widget.social.platform.displayName,
              url: widget.social.url,
            );
            LinkLauncher.open(context, widget.social.url);
          },
          child: Semantics(
            button: true,
            label:
                '${widget.social.platform.displayName}: ${widget.social.label}',
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 140),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: _isHovered
                    ? AppColors.primary.withValues(alpha: isDark ? 0.08 : 0.05)
                    : Colors.transparent,
                borderRadius: AppRadius.smBorderRadius,
                border: Border.all(
                  color: _isHovered
                      ? AppColors.primary.withValues(alpha: 0.22)
                      : cs.outlineVariant,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  // Icon container
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 140),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: _isHovered
                          ? AppColors.primary
                              .withValues(alpha: isDark ? 0.18 : 0.12)
                          : cs.surfaceContainerHighest,
                      borderRadius: AppRadius.smBorderRadius,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      _iconFor(widget.social.platform),
                      size: 18,
                      color:
                          _isHovered ? AppColors.primary : cs.onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(width: AppSpacing.md),

                  // Platform + label
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.labelSmall(
                          widget.social.platform.displayName.toUpperCase(),
                          color: _isHovered
                              ? AppColors.primary
                              : cs.onSurfaceVariant,
                        ),
                        AppText.bodySmall(
                          widget.social.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          color: _isHovered ? AppColors.primary : cs.onSurface,
                        ),
                      ],
                    ),
                  ),

                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                    color: _isHovered ? AppColors.primary : cs.outlineVariant,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _iconFor(SocialPlatform p) => switch (p) {
        SocialPlatform.email => Icons.mail_outline_rounded,
        SocialPlatform.whatsapp => Icons.chat_bubble_outline_rounded,
        SocialPlatform.linkedin => Icons.link_rounded,
        SocialPlatform.github => Icons.code_rounded,
        SocialPlatform.twitter => Icons.alternate_email_rounded,
        SocialPlatform.website => Icons.language_rounded,
      };
}

// ---------------------------------------------------------------------------
// Contact form
// ---------------------------------------------------------------------------

class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _subjectCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();
  bool _isSubmitting = false;
  bool _submitted = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _subjectCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);

    final subject = Uri.encodeComponent(_subjectCtrl.text.trim());
    final body = Uri.encodeComponent(
      'Name: ${_nameCtrl.text.trim()}\n'
      'Email: ${_emailCtrl.text.trim()}\n\n'
      '${_messageCtrl.text.trim()}',
    );
    final mailto = 'mailto:${profileData.email}?subject=$subject&body=$body';

    final launched = await LinkLauncher.open(context, mailto);
    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
      _submitted = launched;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cs = Theme.of(context).colorScheme;
    final formPadding = responsiveValue<double>(
      context,
      mobile: AppSpacing.md,
      tablet: AppSpacing.lg,
      desktop: AppSpacing.xl,
    );

    return Container(
      padding: EdgeInsets.all(formPadding),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurfaceCard : AppColors.lightSurfaceCard,
        borderRadius: AppRadius.lgBorderRadius,
        border: Border.all(color: cs.outlineVariant, width: 1),
      ),
      child: _submitted
          ? const _SuccessMessage()
          : Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText.titleLg(AppStrings.sendAMessage),
                  const SizedBox(height: AppSpacing.xl),

                  // Name + email — side by side on desktop
                  _ResponsiveRow(
                    left: _AppFormField(
                      controller: _nameCtrl,
                      label: AppStrings.yourName,
                      hint: 'John Smith',
                      textInputAction: TextInputAction.next,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? AppStrings.validationNameRequired
                          : null,
                    ),
                    right: _AppFormField(
                      controller: _emailCtrl,
                      label: AppStrings.yourEmail,
                      hint: 'john@example.com',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return AppStrings.validationEmailRequired;
                        }
                        final re = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,}$');
                        if (!re.hasMatch(v.trim())) {
                          return AppStrings.validationEmailInvalid;
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  _AppFormField(
                    controller: _subjectCtrl,
                    label: AppStrings.subject,
                    hint: 'Flutter collaboration / Job opportunity',
                    textInputAction: TextInputAction.next,
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Subject is required'
                        : null,
                  ),

                  const SizedBox(height: AppSpacing.md),

                  _AppFormField(
                    controller: _messageCtrl,
                    label: AppStrings.yourMessage,
                    hint: 'Tell me about the role, project, or idea…',
                    maxLines: 5,
                    textInputAction: TextInputAction.done,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return AppStrings.validationMessageRequired;
                      }
                      if (v.trim().length < 20) {
                        return AppStrings.validationMessageShort;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  PrimaryButton(
                    label: AppStrings.sendMessage,
                    icon: Icons.send_rounded,
                    isLoading: _isSubmitting,
                    isFullWidth: true,
                    onPressed: _submit,
                  ),

                  const SizedBox(height: AppSpacing.md),

                  Center(
                    child: AppText.bodySmall(
                      'I typically respond within 24–48 hours.',
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

// ---------------------------------------------------------------------------
// Name + email side-by-side on desktop, stacked on mobile
// ---------------------------------------------------------------------------

class _ResponsiveRow extends StatelessWidget {
  const _ResponsiveRow({required this.left, required this.right});
  final Widget left;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    if (deviceTypeOf(context).isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: left),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: right),
        ],
      );
    }
    return Column(
      children: [
        left,
        const SizedBox(height: AppSpacing.md),
        right,
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Reusable labelled form field
// ---------------------------------------------------------------------------

class _AppFormField extends StatelessWidget {
  const _AppFormField({
    required this.controller,
    required this.label,
    required this.hint,
    this.maxLines = 1,
    this.keyboardType,
    this.textInputAction,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final int maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.labelSmall(
          label.toUpperCase(),
          color: cs.onSurfaceVariant,
        ),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validator: validator,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(hintText: hint),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Post-submit success panel
// ---------------------------------------------------------------------------

class _SuccessMessage extends StatelessWidget {
  const _SuccessMessage();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxxl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.check_rounded,
              color: AppColors.primary,
              size: 36,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const AppText.titleLg('Message Sent!'),
          const SizedBox(height: AppSpacing.sm),
          AppText.muted(
            'Thanks for reaching out. I\'ll get back to you within 24–48 hours.',
            textAlign: TextAlign.center,
            color: cs.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}
