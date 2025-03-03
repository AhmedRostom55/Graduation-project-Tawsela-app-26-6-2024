part of 'app_theme_bloc.dart';

@immutable
sealed class AppThemeEvent {}

class InitialEvent extends AppThemeEvent{}
class LightEvent extends AppThemeEvent{}
class DarkEvent extends AppThemeEvent{}