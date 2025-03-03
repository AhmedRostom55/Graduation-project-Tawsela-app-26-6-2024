part of 'app_language_bloc.dart';

@immutable
sealed class AppLanguageState {}

final class AppLanguageInitial extends AppLanguageState {}


class AppChangeLanguage extends AppLanguageState{
  final String? languageCode;

  AppChangeLanguage({ this.languageCode});
}