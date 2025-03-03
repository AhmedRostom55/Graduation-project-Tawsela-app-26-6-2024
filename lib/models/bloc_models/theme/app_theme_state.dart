part of 'app_theme_bloc.dart';

@immutable
sealed class AppThemeState {}

final class AppThemeInitial extends AppThemeState {}

class AppChangeTheme extends AppThemeState{
  final String ?appTheme;

  AppChangeTheme({ this.appTheme});
}

class AppLightThemeState extends AppThemeState{
  final String ?appTheme;

  AppLightThemeState({ this.appTheme});
}
class AppDarkThemeState extends AppThemeState {
  final String ?appTheme;

  AppDarkThemeState({ this.appTheme});
}