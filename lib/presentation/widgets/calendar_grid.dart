import 'package:flutter/material.dart';
import 'package:lich_van_nien/data/models/calendar_event.dart';
import 'package:lich_van_nien/core/utils/lunar_solar_converter.dart';
import 'package:lunar/calendar/Lunar.dart';
import 'package:lunar/calendar/Solar.dart';

class CalendarGrid extends StatelessWidget {
  final List<CalendarEventModel> events;
  final Function(String) onDayTap;
  final int selectedYear; // Thêm biến selectedYear
  final int selectedMonth; // Thêm biến selectedMonth

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
        final lunarDate = _getLunarDate(int.parse(solarDate), selectedYear, selectedMonth); // Lấy lịch âm
        final bool isToday = solarDate == DateTime.now().day.toString(); // Logic kiểm tra ngày hôm nay

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
                  if (isEventDay(solarDate)) // Show a dot under dates with events
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
    final day = (index % 30) + 1;
    return day.toString();
  }

  // Logic to get lunar date using the conversion function
  String _getLunarDate(int solarDay, int year, int month) {
    final solarDate = DateTime(year, month, solarDay); // Lấy ngày dương
    final lunarDate = convertSolarToLunar(solarDate); // Chuyển đổi sang âm
    return '${lunarDate.getDay()}/${lunarDate.getMonth()}'; // Trả về định dạng chuỗi
  }

  // Logic to check if a date has events
  bool isEventDay(String date) {
    List<String> eventDates = ['2', '10', '17', '28']; // Example event dates
    return eventDates.contains(date);
  }

  static Lunar convertSolarToLunar(DateTime solarDate) {
    Solar solar = Solar.fromDate(solarDate);
    return solar.getLunar();
  }
}
