import 'package:equatable/equatable.dart';
import 'package:today_app/models/models.dart';

abstract class ThemeSettingState extends Equatable {
  final Themes theme;

  const ThemeSettingState(this.theme);

  @override
  List<Object> get props => [theme.index];
}

class ThemeInitialized extends ThemeSettingState {
  const ThemeInitialized(Themes theme) : super(theme);
}

class ThemeLoaded extends ThemeSettingState {
  const ThemeLoaded(Themes theme) : super(theme);
}
