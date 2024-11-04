// theme_bloc.dart
import 'package:final_timebrew_app/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(
          themeData: appThemeData[AppTheme.Basic]!,
          appTheme: AppTheme.Basic,
        )) {
    on<ThemeChangedEvent>((event, emit) {
      emit(ThemeState(
        themeData: appThemeData[event.theme]!,
        appTheme: event.theme,
      ));
    });
  }
}
