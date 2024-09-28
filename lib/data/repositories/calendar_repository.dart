import 'package:lich_van_nien/data/datasources/local/local_storage.dart';
import 'package:lich_van_nien/data/models/calendar_event.dart';

class CalendarRepository {
  final LocalStorage localStorage;

  CalendarRepository({required this.localStorage});

  Future<void> saveEvent(CalendarEventModel event) async {
    await localStorage.saveEvent(event.toJson());
  }

  Future<List<CalendarEventModel>> getLocalEvents() async {
    try {
      final eventList = await localStorage.getEvents();
      return eventList.map((event) => CalendarEventModel.fromJson(event)).toList();
    } catch (e) {
      throw Exception('Failed to load events: $e');
    }
  }

  Future<void> deleteEvent(String eventId) async {
    await localStorage.deleteEvent(eventId);
  }

  Future<List<CalendarEventModel>> fetchCalendarEvents(int year, int month) async {
    // Giả lập một số sự kiện
    return [
      CalendarEventModel(id: '1', title: 'Sự kiện 1', startTime: DateTime(year, month, 1), endTime: DateTime(year, month, 1), description: ''),
      CalendarEventModel(id: '2', title: 'Sự kiện 2', startTime: DateTime(year, month, 15), endTime: DateTime(year, month, 15), description: ''),
      CalendarEventModel(id: '3', title: 'Sự kiện 3', startTime: DateTime(year, month, 20), endTime: DateTime(year, month, 20), description: ''),
    ];
  }
}
