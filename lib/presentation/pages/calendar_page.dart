import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lich_van_nien/data/models/calendar_event.dart';
import 'package:lich_van_nien/presentation/blocs/calendar/calendar_state.dart';
import '../blocs/calendar/calendar_bloc.dart';
import '../blocs/calendar/calendar_event.dart';
import '../widgets/calendar_grid.dart';
import 'event_details_page.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;
  final List<String> months = [
    'Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6',
    'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'
  ];

  @override
  void initState() {
    super.initState();
    context.read<CalendarBloc>().add(FetchCalendarEvents(selectedYear, selectedMonth));
  }

  @override
  Widget build(BuildContext context) {
    // Lấy trạng thái của Bloc
    final state = context.watch<CalendarBloc>().state;

    // Kiểm tra trạng thái và lấy sự kiện
    List<CalendarEventModel> events = [];
    if (state is CalendarLoaded) {
      events = state.events; // Chỉ lấy sự kiện từ trạng thái CalendarLoaded
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Lịch vạn niên', style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            // color: Color.fromARGB(0, 179, 232, 207),
          ),),
        ),
        // backgroundColor:const Color.fromARGB(0, 232, 186, 179),
      ),
      body: Column(
        children: [
          // Dropdown and buttons row
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Previous month button
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      if (selectedMonth == 1) {
                        selectedMonth = 12;
                        selectedYear--;
                      } else {
                        selectedMonth--;
                      }
                      context.read<CalendarBloc>().add(FetchCalendarEvents(selectedYear, selectedMonth));
                    });
                  },
                ),
                // Month Dropdown
                DropdownButton<int>(
                  value: selectedMonth,
                  items: List.generate(12, (index) {
                    return DropdownMenuItem<int>(
                      value: index + 1,
                      child: Text(months[index]),
                    );
                  }),
                  isExpanded: false,
                  menuMaxHeight: 150,
                  onChanged: (int? newMonth) {
                    setState(() {
                      selectedMonth = newMonth!;
                      context.read<CalendarBloc>().add(FetchCalendarEvents(selectedYear, selectedMonth));
                    });
                  },
                ),
                // Year Dropdown
                DropdownButton<int>(
                  value: selectedYear,
                  items: List.generate(20, (index) {
                    return DropdownMenuItem<int>(
                      value: DateTime.now().year - 10 + index,
                      child: Text((DateTime.now().year - 10 + index).toString()),
                    );
                  }),
                  isExpanded: false,
                  menuMaxHeight: 150,
                  onChanged: (int? newYear) {
                    setState(() {
                      selectedYear = newYear!;
                      context.read<CalendarBloc>().add(FetchCalendarEvents(selectedYear, selectedMonth));
                    });
                  },
                ),
                // Next month button
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    setState(() {
                      if (selectedMonth == 12) {
                        selectedMonth = 1;
                        selectedYear++;
                      } else {
                        selectedMonth++;
                      }
                      context.read<CalendarBloc>().add(FetchCalendarEvents(selectedYear, selectedMonth));
                    });
                  },
                ),
              ],
            ),
          ),
          // Xem button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: ElevatedButton(
              onPressed: () {
                // Load the selected month's data
                setState(() {
                  context.read<CalendarBloc>().add(FetchCalendarEvents(selectedYear, selectedMonth));
                });
              },
              child: const Text('Xem'),
            ),
          ),
          // Calendar Grid
          Expanded(
            flex: 3,
            child: CalendarGrid(
              events: events,
              onDayTap: (String selectedDay) {
                // Handle day tap navigation to EventDetailsPage
                final eventsForDay = events
                    .where((event) => event.startTime.day.toString() == selectedDay &&
                                      event.startTime.month == selectedMonth &&
                                      event.startTime.year == selectedYear)
                    .toList();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventDetailsPage(
                      selectedDate: '$selectedDay/$selectedMonth/$selectedYear',
                      events: eventsForDay.map((e) => e.title).toList(), // Chỉ lấy tiêu đề
                    ),
                  ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Danh sách sự kiện',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Event List
          const Expanded(
            flex: 2,
            child: Center(
              child: Text('Nhấn vào một ngày để xem sự kiện chi tiết'),
            ),
          ),
        ],
      ),
    );
  }
}
