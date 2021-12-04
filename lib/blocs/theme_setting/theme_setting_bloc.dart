import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_app/blocs/theme_setting/theme_setting.dart';
import 'package:today_app/blocs/theme_setting/theme_setting_event.dart';
import 'package:today_app/models/models.dart';

class ThemeSettingBloc extends Bloc<ThemeSettingEvent, ThemeSettingState> {
  ThemeSettingBloc() : super(const ThemeInitialized(Themes.light)) {
    on<ThemeChanged>(
      (event, emit) async {
        final Themes theme;
        switch (event.themeIndex) {
          case 0:
            theme = Themes.light;
            break;
          case 1:
            theme = Themes.dark;
            break;
          case 2:
            theme = Themes.green;
            break;
          case 3:
            theme = Themes.blue;
            break;
          default:
            theme = Themes.light;
        }

        print("theme ${event.themeIndex} $theme");
        emit(ThemeLoaded(theme));
      },
    );
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
