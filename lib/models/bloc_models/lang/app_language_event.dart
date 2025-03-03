part of 'app_language_bloc.dart';

@immutable
sealed class AppLanguageEvent {}

class InitialLanguage extends AppLanguageEvent{}
class ArabicLanguageEvent extends AppLanguageEvent{}
class EnglishLanguageEvent extends AppLanguageEvent{}