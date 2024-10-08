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

class DeleteEvent extends CalendarEvent {
  final String eventId;
  final int year;
  final int month;

  const DeleteEvent(this.eventId, this.month, this.year);

  @override
  List<Object> get props => [eventId, month, year];
}

class UpdateEvent extends CalendarEvent {
  final CalendarEventModel updatedEvent;
  final int year;
  final int month;

  const UpdateEvent(this.updatedEvent, this.month, this.year);

  @override
  List<Object> get props => [updatedEvent, month, year];
}

// ignore: must_be_immutable
class SaveEvent extends CalendarEvent {
  final CalendarEventModel calendarEvent;
  int year;
  int month;

  SaveEvent(this.calendarEvent, this.month, this.year);

  @override
  List<Object> get props => [calendarEvent, year, month]; 
}