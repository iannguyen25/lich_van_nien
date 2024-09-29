import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lich_van_nien/data/models/calendar_event.dart';
import 'package:lich_van_nien/presentation/blocs/calendar/calendar_bloc.dart';
import 'package:lich_van_nien/presentation/blocs/calendar/calendar_event.dart';
import 'package:lich_van_nien/presentation/blocs/calendar/calendar_state.dart';

class EventDetailsPage extends StatefulWidget {
  final String selectedDate;

  const EventDetailsPage({super.key, required this.selectedDate});

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  late List<CalendarEventModel> events = [];

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  void _loadEvents() {
    final dateParts = widget.selectedDate.split('/');
    final eventDate = DateTime(
      int.parse(dateParts[2]),  // Year
      int.parse(dateParts[1]),  // Month
      int.parse(dateParts[0]),  // Day
    );
    context.read<CalendarBloc>().add(FetchCalendarEvents(eventDate.year, eventDate.month));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sự kiện ngày ${widget.selectedDate}'),
      ),
      body: BlocConsumer<CalendarBloc, CalendarState>(
        listener: (context, state) {
          if (state is CalendarLoaded) {
            setState(() {
              events = state.events.where((event) => 
                event.startTime.day == int.parse(widget.selectedDate.split('/')[0])).toList();
            });
          }
        },
        builder: (context, state) {
          if (state is CalendarLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: events.isNotEmpty
                ? ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];
                      return ListTile(
                        title: Text(event.title),
                        subtitle: Text(event.description),
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'edit') {
                              _editEvent(context, event);
                            } else if (value == 'delete') {
                              _confirmDelete(context, event);
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              const PopupMenuItem<String>(
                                value: 'edit',
                                child: Text('Sửa'),
                              ),
                              const PopupMenuItem<String>(
                                value: 'delete',
                                child: Text('Xóa'),
                              ),
                            ];
                          },
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text(
                      'Không có sự kiện nào cho ngày này',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEventDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddEventDialog(BuildContext context) {
    final TextEditingController eventController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thêm sự kiện mới'),
          content: TextField(
            controller: eventController,
            decoration: const InputDecoration(hintText: "Nhập tên sự kiện"),
          ),
          actions: [
            TextButton(
              child: const Text('Hủy'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Thêm'),
              onPressed: () {
                if (eventController.text.isNotEmpty) {
                  _addEvent(context, eventController.text);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _addEvent(BuildContext context, String eventTitle) {
    final dateParts = widget.selectedDate.split('/');
    final eventDate = DateTime(
      int.parse(dateParts[2]),  // Year
      int.parse(dateParts[1]),  // Month
      int.parse(dateParts[0]),  // Day
    );

    final newEvent = CalendarEventModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: eventTitle,
      startTime: eventDate,
      endTime: eventDate,
      description: '',
    );

    context.read<CalendarBloc>().add(SaveEvent(newEvent, eventDate.month, eventDate.year));
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thông báo'),
          content: const Text('Sự kiện đã được thêm'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editEvent(BuildContext context, CalendarEventModel event) {
    TextEditingController titleController = TextEditingController(text: event.title);
    TextEditingController descriptionController = TextEditingController(text: event.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sửa sự kiện'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Tiêu đề'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Mô tả'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedEvent = event.copyWith(
                  title: titleController.text,
                  description: descriptionController.text,
                );
                context.read<CalendarBloc>().add(UpdateEvent(updatedEvent, event.startTime.month, event.startTime.year));
                Navigator.of(context).pop();
              },
              child: const Text('Lưu'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, CalendarEventModel event) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Xác nhận'),
          content: const Text('Bạn có chắc chắn muốn xóa sự kiện này?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<CalendarBloc>().add(DeleteEvent(event.id, event.startTime.month, event.startTime.year));
                Navigator.of(context).pop();
              },
              child: const Text('Xóa'),
            ),
          ],
        );
      },
    );
  }
}