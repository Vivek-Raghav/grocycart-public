import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocycart/services/dart_theme_preferences.dart';

void themeProvide(bool value) async {}
final futureThemeProvider = FutureProvider<bool>((ref) async {
  bool themeStatus = await DarkThemePrefs().getThemeStatus();
  return themeStatus;
});

final themeProvider = StateProvider<bool>((ref) {
  final themeStatus = ref.watch(futureThemeProvider).maybeWhen(
        data: (value) => value,
        orElse: () => false,
      );
  return themeStatus;
});

void toggleTheme(WidgetRef ref) async {
  bool currentValue = ref.read(themeProvider.notifier).state;
  bool newValue = !currentValue;
  await DarkThemePrefs().setDarkTheme(newValue);
  ref.read(themeProvider.notifier).state = !ref.read(themeProvider);
}
