import 'package:flutter/material.dart';
import '../../data/models/calendar_event.dart';

class EventList extends StatelessWidget {
  final List<CalendarEventModel> events;

  const EventList({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: events.isNotEmpty
          ? ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(events[index].title), // Sử dụng thuộc tính title
                  leading: const Icon(Icons.event),
                );
              },
            )
          : const Center(
              child: Text(
                'Không có sự kiện nào',
                style: TextStyle(fontSize: 16),
              ),
            ),
    );
  }
}
