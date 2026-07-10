import 'package:flutter/material.dart';

/// Solid primary button using the brand color (#0C7029).
///
/// The primary CTA for the portfolio: "Hire Me", "View Projects", "Send Message".
///
/// States:
/// - Default: brand green background
/// - Hover: slightly lighter background
/// - Disabled: muted, non-interactive
/// - Loading: shows [CircularProgressIndicator] in place of label
///
/// ```dart
/// PrimaryButton(
///   label: 'Hire Me',
///   onPressed: () => context.go(AppRoutes.contact),
/// )
/// PrimaryButton(
///   label: 'Send Message',
///   icon: Icons.send_rounded,
///   isLoading: _isSending,
///   onPressed: _handleSubmit,
/// )
/// ```
class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.size = ButtonSize.medium,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;
  final ButtonSize size;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    final (hPad, vPad, iconSize, spinnerSize) = switch (widget.size) {
      ButtonSize.small => (16.0, 10.0, 14.0, 12.0),
      ButtonSize.medium => (24.0, 14.0, 16.0, 14.0),
      ButtonSize.large => (32.0, 18.0, 18.0, 16.0),
    };

    Widget child;
    if (widget.isLoading) {
      child = SizedBox(
        width: spinnerSize,
        height: spinnerSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      );
    } else if (widget.icon != null) {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(widget.icon, size: iconSize),
          const SizedBox(width: 8),
          Text(widget.label),
        ],
      );
    } else {
      child = Text(widget.label);
    }

    Widget button = ElevatedButton(
      onPressed: widget.isLoading ? null : widget.onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
      ),
      child: child,
    );

    if (widget.isFullWidth) {
      button = SizedBox(width: double.infinity, child: button);
    }

    return button;
  }
}

enum ButtonSize { small, medium, large }
