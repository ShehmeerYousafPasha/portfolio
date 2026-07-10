/// Design system barrel export.
///
/// Import this single file to access all shared widgets:
/// ```dart
/// import 'package:shehmeer_portfolio/shared/widgets/widgets.dart';
/// ```

library widgets;

// Typography
export 'typography/app_text.dart';

// Buttons
export 'buttons/primary_button.dart';
export 'buttons/secondary_button.dart' hide ButtonSize;
export 'buttons/ghost_button.dart';
export 'buttons/icon_text_button.dart';

// Cards
export 'cards/app_card.dart';
export 'cards/hover_card.dart';

// Section
export 'section/section_header.dart';
export 'section/section_container.dart';

// Badges
export 'badges/open_to_work_badge.dart';
export 'badges/tech_chip.dart';
export 'badges/status_badge.dart';

// Common
export 'common/app_divider.dart';
export 'common/hover_wrapper.dart';
export 'common/async_value_widget.dart';
export 'common/skeleton_loader.dart';
export 'common/theme_toggle_button.dart';
export 'common/app_footer.dart';
