import '../../data/models/calendar_event.dart';
import '../../data/repositories/calendar_repository.dart';

class GetCalendarEvents {
  final CalendarRepository calendarRepository;

  GetCalendarEvents({required this.calendarRepository});

  Future<List<CalendarEventModel>> call(int year, int month) async {
    Map<String, CalendarEventModel> eventMap = {};

    try {
      // Lấy sự kiện từ API
      final eventsFromApi = await calendarRepository.fetchCalendarEvents(year, month);
      for (var event in eventsFromApi) {
        eventMap[event.id] = event; 
      }
    } catch (e) {
      print('Error fetching events from API: $e');
    }

    try {
      // Lấy sự kiện từ local storage
      final localEvents = await calendarRepository.getLocalEvents();
      for (var event in localEvents) {
        eventMap[event.id] = event;
      }
    } catch (e) {
      print('Error fetching local events: $e');
    }

    return eventMap.values.toList();
  }
}
