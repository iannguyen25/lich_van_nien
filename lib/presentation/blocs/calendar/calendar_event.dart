import 'package:equatable/equatable.dart';
import 'package:lich_van_nien/data/models/calendar_event.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

// Sự kiện để lấy sự kiện lịch
class FetchCalendarEvents extends CalendarEvent {
  final int year;
  final int month;

  const FetchCalendarEvents(this.year, this.month);

  @override
  List<Object> get props => [year, month];
}

// Sự kiện để chuyển đổi ngày
class ConvertDate extends CalendarEvent {
  final DateTime solarDate;

  const ConvertDate(this.solarDate);

  @override
  List<Object> get props => [solarDate];
}

// Sự kiện để lưu sự kiện
class SaveEvent extends CalendarEvent {
  final CalendarEventModel calendarEvent;
  final int year; // thêm tham số year

  const SaveEvent(this.calendarEvent, this.year); // thêm year vào constructor

  @override
  List<Object> get props => [calendarEvent, year]; // thêm year vào props
}
