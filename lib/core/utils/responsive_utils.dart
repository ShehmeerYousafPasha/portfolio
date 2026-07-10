import 'package:flutter/material.dart';
import '../constants/breakpoints.dart';

/// Resolves the [DeviceType] from the current [BuildContext].
///
/// Uses [MediaQuery.sizeOf] which is cheaper than [MediaQuery.of]
/// because it only rebuilds when the size changes.
DeviceType deviceTypeOf(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;
  return _deviceTypeFromWidth(width);
}

DeviceType _deviceTypeFromWidth(double width) {
  if (width < Breakpoints.mobile) return DeviceType.mobile;
  if (width < Breakpoints.tablet) return DeviceType.tablet;
  if (width < Breakpoints.desktop) return DeviceType.desktop;
  return DeviceType.largeDesktop;
}

/// Returns true when the current screen is mobile width.
bool isMobile(BuildContext context) => deviceTypeOf(context).isMobile;

/// Returns true when the current screen is tablet width.
bool isTablet(BuildContext context) => deviceTypeOf(context).isTablet;

/// Returns true when the current screen is desktop or larger.
bool isDesktop(BuildContext context) => deviceTypeOf(context).isDesktop;

/// Returns true when the current screen is tablet or larger.
bool isTabletOrAbove(BuildContext context) =>
    deviceTypeOf(context).isTabletOrAbove;

/// Returns a value based on the current screen size.
///
/// Falls back to the next smaller tier if a specific tier is not provided:
/// largeDesktop → desktop → tablet → mobile (always required).
///
/// Example:
/// ```dart
/// final columns = responsiveValue<int>(
///   context,
///   mobile: 1,
///   tablet: 2,
///   desktop: 3,
/// );
/// ```
T responsiveValue<T>(
  BuildContext context, {
  required T mobile,
  T? tablet,
  T? desktop,
  T? largeDesktop,
}) {
  final type = deviceTypeOf(context);
  return switch (type) {
    DeviceType.largeDesktop => largeDesktop ?? desktop ?? tablet ?? mobile,
    DeviceType.desktop => desktop ?? tablet ?? mobile,
    DeviceType.tablet => tablet ?? mobile,
    DeviceType.mobile => mobile,
  };
}

/// Same as [responsiveValue] but resolved from a raw [width] instead of context.
/// Useful inside [LayoutBuilder] callbacks.
T responsiveValueFromWidth<T>(
  double width, {
  required T mobile,
  T? tablet,
  T? desktop,
  T? largeDesktop,
}) {
  final type = _deviceTypeFromWidth(width);
  return switch (type) {
    DeviceType.largeDesktop => largeDesktop ?? desktop ?? tablet ?? mobile,
    DeviceType.desktop => desktop ?? tablet ?? mobile,
    DeviceType.tablet => tablet ?? mobile,
    DeviceType.mobile => mobile,
  };
}
