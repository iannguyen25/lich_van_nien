import 'package:lich_van_nien/data/datasources/local/local_storage.dart';
import 'package:lich_van_nien/data/models/calendar_event.dart';

class CalendarRepository {
  final LocalStorage localStorage;

  CalendarRepository({required this.localStorage});
  // Giả sử chúng ta đang sử dụng một danh sách trong bộ nhớ để lưu trữ sự kiện
  final List<CalendarEventModel> _events = [];

  Future<void> saveEvent(CalendarEventModel event) async {
  print('Saving event: ${event.title}'); // Debug print
  _events.add(event); // Lưu vào danh sách tạm thời
  
  // Lưu vào SharedPreferences
  await localStorage.saveEvent(event.toJson());
}

Future<void> loadEventsFromLocal() async {
  final localEvents = await localStorage.getEvents();
  _events.clear();
  _events.addAll(localEvents.map((e) => CalendarEventModel.fromJson(e)).toList());
}


Future<List<CalendarEventModel>> getEvents(int year, int month) async {
  print('Getting events for $month/$year'); // Debug print
  // Lọc sự kiện cho tháng và năm cụ thể
  return _events.where((event) =>
      event.startTime.year == year && event.startTime.month == month).toList();
}


  Future<void> deleteEvent(String eventId) async {
    await localStorage.deleteEvent(eventId);
  }

  Future<List<CalendarEventModel>> getLocalEvents() async {
    try {
      final eventList = await localStorage.getEvents();
      return eventList.map((event) => CalendarEventModel.fromJson(event)).toList();
    } catch (e) {
      throw Exception('Failed to load events: $e');
    }
  }

  Future<List<CalendarEventModel>> fetchCalendarEvents(int year, int month) async {
    // Giả lập một số sự kiện
    return [
      CalendarEventModel(
        id: '1',
        title: 'Sự kiện 1',
        startTime: DateTime(year, month, 1),
        endTime: DateTime(year, month, 1, 23, 59),
        description: '',
      ),
      CalendarEventModel(
        id: '2',
        title: 'Sự kiện 2',
        startTime: DateTime(year, month, 15),
        endTime: DateTime(year, month, 15, 23, 59),
        description: '',
      ),
      CalendarEventModel(
        id: '3',
        title: 'Sự kiện 3',
        startTime: DateTime(year, month, 20),
        endTime: DateTime(year, month, 20, 23, 59),
        description: '',
      ),
    ];
  }
}