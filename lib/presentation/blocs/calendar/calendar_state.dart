import 'package:equatable/equatable.dart';
import 'package:lich_van_nien/data/models/calendar_event.dart';
import 'package:lich_van_nien/data/models/lunar_date.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object> get props => [];

  get events => null;
}

class CalendarInitial extends CalendarState {}

class CalendarLoading extends CalendarState {}

class CalendarLoaded extends CalendarState {
  @override
  final List<CalendarEventModel> events;

  const CalendarLoaded({required this.events});

  @override
  List<Object> get props => [events];
}

class LunarDateConverted extends CalendarState {
  final LunarDate lunarDate;

  const LunarDateConverted({required this.lunarDate});

  @override
  List<Object> get props => [lunarDate];
}

class EventSaved extends CalendarState {}

class CalendarError extends CalendarState {
  final String message;

  const CalendarError({required this.message});

  @override
  List<Object> get props => [message];
}
