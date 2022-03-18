import 'package:equatable/equatable.dart';

class Adequacy extends Equatable {
  final String title;
  final String dayTitle;
  final String dayNumber;
  final String month;

  const Adequacy(
      {this.title = '',
      this.dayTitle = '',
      this.dayNumber = '',
      this.month = ''});
  @override
  List<Object?> get props => [title, dayTitle, dayNumber, month];
}
