import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class PlatformThemes {
  static fluent.FluentThemeData fluentLightTheme(ThemeData materialTheme) {
    return fluent.FluentThemeData(
      brightness: Brightness.light,
      accentColor: fluent.AccentColor.swatch({
        'darkest': materialTheme.colorScheme.primary.withValues(alpha: 1.0),
        'darker': materialTheme.colorScheme.primary.withValues(alpha: 0.9),
        'dark': materialTheme.colorScheme.primary.withValues(alpha: 0.8),
        'normal': materialTheme.colorScheme.primary,
        'light': materialTheme.colorScheme.primary.withValues(alpha: 0.6),
        'lighter': materialTheme.colorScheme.primary.withValues(alpha: 0.4),
        'lightest': materialTheme.colorScheme.primary.withValues(alpha: 0.2),
      }),
    );
  }

  static fluent.FluentThemeData fluentDarkTheme(ThemeData materialTheme) {
    return fluent.FluentThemeData(
      brightness: Brightness.dark,
      accentColor: fluent.AccentColor.swatch({
        'darkest': materialTheme.colorScheme.primary.withValues(alpha: 1.0),
        'darker': materialTheme.colorScheme.primary.withValues(alpha: 0.9),
        'dark': materialTheme.colorScheme.primary.withValues(alpha: 0.8),
        'normal': materialTheme.colorScheme.primary,
        'light': materialTheme.colorScheme.primary.withValues(alpha: 0.6),
        'lighter': materialTheme.colorScheme.primary.withValues(alpha: 0.4),
        'lightest': materialTheme.colorScheme.primary.withValues(alpha: 0.2),
      }),
    );
  }

  static MacosThemeData macosLightTheme(ThemeData materialTheme) {
    return MacosThemeData.light().copyWith(
      canvasColor: materialTheme.colorScheme.surface,
    );
  }

  static MacosThemeData macosDarkTheme(ThemeData materialTheme) {
    return MacosThemeData.dark().copyWith(
      canvasColor: materialTheme.colorScheme.surface,
    );
  }

  static CupertinoThemeData cupertinoTheme(ThemeData materialTheme) {
    return CupertinoThemeData(
      primaryColor: materialTheme.colorScheme.primary,
      brightness: materialTheme.brightness,
    );
  }
}
