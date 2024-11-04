// theme_bloc.dart (continued)
part of 'theme_bloc.dart';

abstract class ThemeEvent {}

class ThemeChangedEvent extends ThemeEvent {
  final AppTheme theme;

  ThemeChangedEvent({required this.theme});
}
