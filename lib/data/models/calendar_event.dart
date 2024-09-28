import 'package:equatable/equatable.dart';

class CalendarEventModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final bool isLunar;
  final String color;

  const CalendarEventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    this.isLunar = false,
    this.color = '#000000',
  });

  factory CalendarEventModel.fromJson(Map<String, dynamic> json) {
    DateTime startTime = DateTime.parse(json['startTime']);
    DateTime endTime = DateTime.parse(json['endTime']);

    if (startTime.isAfter(endTime)) {
      throw Exception('Start time cannot be after end time');
    }

    return CalendarEventModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      startTime: startTime,
      endTime: endTime,
      isLunar: json['isLunar'] ?? false,
      color: json['color'] ?? '#000000',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'isLunar': isLunar,
      'color': color,
    };
  }

  @override
  List<Object?> get props => [id, title, description, startTime, endTime, isLunar, color];
}
