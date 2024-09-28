import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lich_van_nien/data/models/calendar_event.dart';
import 'package:lich_van_nien/data/models/lunar_date.dart';
import 'package:lich_van_nien/data/repositories/calendar_repository.dart';
import 'package:lich_van_nien/domain/usecases/convert_solar_to_lunar.dart';
import 'package:lich_van_nien/domain/usecases/get_calendar_events.dart';
import 'package:lich_van_nien/presentation/blocs/calendar/calendar_event.dart';
import 'package:lich_van_nien/presentation/blocs/calendar/calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final GetCalendarEvents getCalendarEvents;
  final ConvertSolarToLunar convertSolarToLunar;
  final CalendarRepository calendarRepository;

  CalendarBloc({
    required this.getCalendarEvents,
    required this.convertSolarToLunar,
    required this.calendarRepository,
  }) : super(CalendarInitial()) {
    on<FetchCalendarEvents>(_onFetchCalendarEvents);
    on<ConvertDate>(_onConvertDate);
    on<SaveEvent>(_onSaveEvent);
  }

  Future<void> _onFetchCalendarEvents(FetchCalendarEvents event, Emitter<CalendarState> emit) async {
    emit(CalendarLoading());
    try {
      final List<CalendarEventModel> events = await getCalendarEvents(event.year, event.month);
      emit(CalendarLoaded(events: events)); // Đảm bảo rằng trạng thái CalendarLoaded được cập nhật
    } catch (e) {
      emit(CalendarError(message: 'Failed to fetch calendar events: ${e.toString()}'));
    }
  }

  Future<void> _onConvertDate(ConvertDate event, Emitter<CalendarState> emit) async {
    try {
      LunarDate lunarDate = convertSolarToLunar(event.solarDate);
      emit(LunarDateConverted(lunarDate: lunarDate));
    } catch (e) {
      emit(CalendarError(message: 'Failed to convert date: ${e.toString()}'));
    }
  }

  Future<void> _onSaveEvent(SaveEvent event, Emitter<CalendarState> emit) async {
    emit(CalendarLoading());
    try {
      await calendarRepository.saveEvent(event.calendarEvent);
      emit(EventSaved());
      add(FetchCalendarEvents(event.year, event.month)); // Cập nhật để lấy lại sự kiện
    } catch (e) {
      emit(CalendarError(message: 'Failed to save event: ${e.toString()}'));
    }
  }
}

// Sự kiện để lưu sự kiện
// ignore: must_be_immutable
class SaveEvent extends CalendarEvent {
  final CalendarEventModel calendarEvent;
  int year;
  int month;

  SaveEvent(this.calendarEvent, this.month, this.year);

  @override
  List<Object> get props => [calendarEvent, year, month]; // Thêm year và month vào props
}
