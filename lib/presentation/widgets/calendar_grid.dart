import 'package:flutter/material.dart';
import '../../data/models/calendar_event.dart';

class CalendarGrid extends StatelessWidget {
  final List<CalendarEventModel> events;
  final Function(String) onDayTap;
  final int selectedYear; // Thêm tham số này
  final int selectedMonth; // Thêm tham số này

  const CalendarGrid({
    super.key,
    required this.events,
    required this.onDayTap,
    required this.selectedYear,
    required this.selectedMonth,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7, // 7 days in a week
        childAspectRatio: 1, // Keep the cells square
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: 42, // Total cells (7 days * 6 rows)
      itemBuilder: (context, index) {
        final String solarDate = _getSolarDate(index); // Get solar date
        final String lunarDate = _getLunarDate(index); // Get lunar date
        final bool isToday = solarDate == '28'; // Example logic for today's date

        return GestureDetector(
          onTap: () {
            onDayTap(solarDate); // Pass the tapped solar date
          },
          child: Container(
            decoration: BoxDecoration(
              color: isToday ? Colors.orange[200] : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey[400]!,
                width: 1.0,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    solarDate, // Display the solar date
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isToday ? Colors.orange : Colors.black,
                    ),
                  ),
                  Text(
                    lunarDate, // Display the lunar date
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  if (isEventDay(solarDate)) // Example logic to show a dot under dates with events
                    const Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: Icon(
                        Icons.circle,
                        size: 6,
                        color: Colors.redAccent,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Placeholder logic for solar dates
  String _getSolarDate(int index) {
  final currentDate = DateTime(selectedYear, selectedMonth, 1);
  final targetDate = currentDate.add(Duration(days: index - currentDate.weekday + 1));
  return targetDate.day.toString();
}


  // Placeholder logic for lunar dates
  String _getLunarDate(int index) {
    final lunarDay = (index % 30) + 1;
    return lunarDay == 1 ? "1/8" : lunarDay.toString(); // Example lunar month "1/8" for new month
  }

  // Logic to check if a date has events
  // Logic to check if a date has events
bool isEventDay(String date) {
  // Lấy danh sách ngày từ events
  List<String> eventDates = events
      .where((event) => event.startTime.day.toString() == date &&
                        event.startTime.month == selectedMonth &&
                        event.startTime.year == selectedYear)
      .map((event) => event.startTime.day.toString())
      .toList();
  return eventDates.contains(date);
}
}
