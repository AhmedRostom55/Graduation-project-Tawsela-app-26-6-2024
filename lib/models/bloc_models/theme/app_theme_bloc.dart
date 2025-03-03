import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../../../utilities.dart';

part 'app_theme_event.dart';
part 'app_theme_state.dart';

class AppThemeBloc extends Bloc<AppThemeEvent, AppThemeState> {
  AppThemeBloc() : super(AppThemeInitial()) {
    on<AppThemeEvent>((event, emit) {
      if (event is InitialEvent){
         if (sharedPreferences!=null){
          if (sharedPreferences!.getString('theme')=='l'){
            emit(AppChangeTheme(appTheme: 'l'));
          }else {
            emit(AppChangeTheme(appTheme: 'd'));
          }
         }
      }
      else if (event is LightEvent){
        sharedPreferences!.setString('theme','l');
          emit(AppChangeTheme(appTheme: 'l'));
      }
      else if (event is DarkEvent){
        sharedPreferences!.setString('theme','d');
emit(AppChangeTheme(appTheme: 'd'));
      }
    });
  }
}