import 'package:flutter/material.dart';

class EventDetailsPage extends StatelessWidget {
  final String selectedDate;
  final List<String> events;

  const EventDetailsPage({super.key, required this.selectedDate, required this.events});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sự kiện ngày $selectedDate'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: events.isNotEmpty
            ? ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(events[index]),
                    leading: const Icon(Icons.event),
                  );
                },
              )
            : const Center(
                child: Text(
                  'Không có sự kiện nào cho ngày này',
                  style: TextStyle(fontSize: 16),
                ),
              ),
      ),
    );
  }
}
