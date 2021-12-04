import 'package:equatable/equatable.dart';
import 'package:today_app/models/models.dart';

abstract class ThemeSettingEvent extends Equatable {
  const ThemeSettingEvent();

  @override
  List<Object> get props => [];
}

class ThemeChanged extends ThemeSettingEvent {
  final  int themeIndex;
  const ThemeChanged(this.themeIndex);
  @override
  List<Object> get props => [themeIndex];
}
