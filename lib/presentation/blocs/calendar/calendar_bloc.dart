import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lich_van_nien/data/repositories/calendar_repository.dart';
import 'package:lich_van_nien/presentation/blocs/calendar/calendar_event.dart';
import 'package:lich_van_nien/presentation/blocs/calendar/calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final CalendarRepository calendarRepository;

  CalendarBloc({required this.calendarRepository}) : super(CalendarInitial()) {
    on<FetchCalendarEvents>(_onFetchCalendarEvents);
    on<SaveEvent>(_onSaveEvent);
    on<DeleteEvent>(_onDeleteEvent);
    on<UpdateEvent>(_onUpdateEvent);
    _loadLocalEvents();
  }

  Future<void> _loadLocalEvents() async {
    try {
      await calendarRepository.loadEventsFromLocal();
    } catch (e) {
      print('Lỗi khi tải sự kiện cục bộ: $e');
    }
  }

  Future<void> _onFetchCalendarEvents(FetchCalendarEvents event, Emitter<CalendarState> emit) async {
    emit(CalendarLoading());
    try {
      final events = await calendarRepository.getEvents(event.year, event.month);
      emit(CalendarLoaded(events: events));
    } catch (e) {
      emit(CalendarError(message: 'Lỗi khi lấy sự kiện: $e'));
    }
  }

  Future<void> _onSaveEvent(SaveEvent event, Emitter<CalendarState> emit) async {
    emit(CalendarLoading());
    try {
      await calendarRepository.saveEvent(event.calendarEvent);
      final updatedEvents = await calendarRepository.getEvents(event.year, event.month);
      emit(CalendarLoaded(events: updatedEvents));
    } catch (e) {
      emit(CalendarError(message: 'Lỗi khi lưu sự kiện: $e'));
    }
  }

  Future<void> _onDeleteEvent(DeleteEvent event, Emitter<CalendarState> emit) async {
    emit(CalendarLoading());
    try {
      await calendarRepository.deleteEvent(event.eventId);
      final updatedEvents = await calendarRepository.getEvents(event.year, event.month);
      emit(CalendarLoaded(events: updatedEvents));
    } catch (e) {
      emit(CalendarError(message: 'Lỗi khi xóa sự kiện: $e'));
    }
  }

  Future<void> _onUpdateEvent(UpdateEvent event, Emitter<CalendarState> emit) async {
    emit(CalendarLoading());
    try {
      await calendarRepository.saveEvent(event.updatedEvent);
      final updatedEvents = await calendarRepository.getEvents(event.year, event.month);
      emit(CalendarLoaded(events: updatedEvents));
    } catch (e) {
      emit(CalendarError(message: 'Lỗi khi cập nhật sự kiện: $e'));
    }
  }
}