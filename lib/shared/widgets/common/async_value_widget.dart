import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../typography/app_text.dart';

/// Generic widget that handles all three states of a Riverpod [AsyncValue].
///
/// Eliminates repetitive `.when(data:, loading:, error:)` calls in UI code.
/// The local data sources resolve instantly (no visible loading flash), but
/// when Supabase arrives, the loading and error states become genuinely useful.
///
/// ```dart
/// // In any ConsumerWidget:
/// AsyncValueWidget<ProfileModel>(
///   value: ref.watch(profileProvider),
///   data: (profile) => HeroSection(profile: profile),
/// )
///
/// // Custom loading widget:
/// AsyncValueWidget<List<ProjectModel>>(
///   value: ref.watch(allProjectsProvider),
///   loading: const ProjectsSkeletonLoader(),
///   data: (projects) => ProjectsGrid(projects: projects),
/// )
/// ```
class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.data,
    this.loading,
    this.error,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;

  /// Custom loading widget — defaults to [_DefaultLoadingIndicator].
  final Widget? loading;

  /// Custom error widget factory — defaults to [_DefaultErrorWidget].
  final Widget Function(Object error, StackTrace? stack)? error;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: () => loading ?? const _DefaultLoadingIndicator(),
      error: (e, s) =>
          error?.call(e, s) ?? _DefaultErrorWidget(error: e),
    );
  }
}

// ---------------------------------------------------------------------------
// Default loading state
// ---------------------------------------------------------------------------

class _DefaultLoadingIndicator extends StatelessWidget {
  const _DefaultLoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xxl),
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Default error state
// ---------------------------------------------------------------------------

class _DefaultErrorWidget extends StatelessWidget {
  const _DefaultErrorWidget({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 32,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: AppSpacing.md),
            const AppText.titleMd(AppStrings.errorGeneral),
            const SizedBox(height: AppSpacing.sm),
            AppText.muted(error.toString(), maxLines: 2),
          ],
        ),
      ),
    );
  }
}
