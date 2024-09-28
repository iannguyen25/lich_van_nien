import 'package:equatable/equatable.dart';

class LunarDate extends Equatable {
  final int day;
  final int month;
  final int year;
  // final bool isLeapMonth;

  const LunarDate({
    required this.day,
    required this.month,
    required this.year,
    // this.isLeapMonth = false,
  });

  @override
  List<Object?> get props => [day, month, year];
}