import 'package:flutter/material.dart';
import 'package:lich_van_nien/core/utils/lunar_solar_converter.dart';
import 'package:lich_van_nien/data/models/calendar_event.dart';

class CalendarGrid extends StatelessWidget {
  final List<CalendarEventModel> events;
  final Function(String) onDayTap;
  final int selectedYear;
  final int selectedMonth;

  const CalendarGrid({
    super.key,
    required this.events,
    required this.onDayTap,
    required this.selectedYear,
    required this.selectedMonth,
  });

  @override
  Widget build(BuildContext context) {
    final firstDayOfMonth = DateTime(selectedYear, selectedMonth, 1);
    final daysInMonth = DateTime(selectedYear, selectedMonth + 1, 0).day;
    final firstWeekday = firstDayOfMonth.weekday;

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 0.85,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: 42,
      itemBuilder: (context, index) {
        final int day = index - firstWeekday + 2;
        if (day < 1 || day > daysInMonth) {
          return Container(); // Empty cell for days outside the current month
        }

        final solarDate = DateTime(selectedYear, selectedMonth, day);
        final lunarDate = LunarSolarConverter.convertSolarToLunar(solarDate);
        final bool isToday = _isToday(solarDate);
        final bool hasEvent = _hasEvent(solarDate);

        return GestureDetector(
          onTap: () => onDayTap(day.toString()),
          child: Container(
            decoration: BoxDecoration(
              color: _getBackgroundColor(isToday, hasEvent),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey[400]!, width: 1.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  day.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isToday ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  '${lunarDate.getDay()}/${lunarDate.getMonth()}',
                  style: TextStyle(fontSize: 10, color: isToday ? Colors.white70 : Colors.grey[600]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getBackgroundColor(bool isToday, bool hasEvent) {
    if (isToday) return Colors.blue;
    if (hasEvent) return Colors.orange[200]!;
    return Colors.white;
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  bool _hasEvent(DateTime date) {
    return events.any((event) =>
        event.startTime.year == date.year &&
        event.startTime.month == date.month &&
        event.startTime.day == date.day);
  }
}