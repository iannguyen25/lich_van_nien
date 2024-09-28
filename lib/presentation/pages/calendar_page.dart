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
    _fetchEvents(); // Tải sự kiện cho tháng và năm hiện tại
  }

  void _fetchEvents() {
    context.read<CalendarBloc>().add(FetchCalendarEvents(selectedYear, selectedMonth));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn tháng và năm'),
      ),
      body: Column(
        children: [
          // Đoạn mã cho Dropdown và button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Nút tháng trước
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
                      _fetchEvents();
                    });
                  },
                ),
                // Dropdown cho tháng
                DropdownButton<int>(
                  value: selectedMonth,
                  items: List.generate(12, (index) {
                    return DropdownMenuItem<int>(
                      value: index + 1,
                      child: Text(months[index]),
                    );
                  }),
                  onChanged: (int? newMonth) {
                    setState(() {
                      selectedMonth = newMonth!;
                      _fetchEvents(); // Tải sự kiện mới
                    });
                  },
                ),
                // Dropdown cho năm
                DropdownButton<int>(
                  value: selectedYear,
                  items: List.generate(20, (index) {
                    return DropdownMenuItem<int>(
                      value: DateTime.now().year - 10 + index,
                      child: Text((DateTime.now().year - 10 + index).toString()),
                    );
                  }),
                  onChanged: (int? newYear) {
                    setState(() {
                      selectedYear = newYear!;
                      _fetchEvents(); // Tải sự kiện mới
                    });
                  },
                ),
                // Nút tháng tiếp theo
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
                      _fetchEvents(); // Tải sự kiện mới
                    });
                  },
                ),
              ],
            ),
          ),
          // Nút "Xem"
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: ElevatedButton(
              onPressed: () {
                _fetchEvents(); // Gọi lại để tải sự kiện mới
              },
              child: const Text('Xem'),
            ),
          ),
          // Hiển thị danh sách sự kiện
          const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: Center(child: Text('Thứ 2'))),
              Expanded(child: Center(child: Text('Thứ 3'))),
              Expanded(child: Center(child: Text('Thứ 4'))),
              Expanded(child: Center(child: Text('Thứ 5'))),
              Expanded(child: Center(child: Text('Thứ 6'))),
              Expanded(child: Center(child: Text('Thứ 7'))),
              Expanded(child: Center(child: Text('CN'))),
            ],
          ),
        ),
          Expanded(
            flex: 3,
            child: BlocBuilder<CalendarBloc, CalendarState>(
              builder: (context, state) {
                if (state is CalendarLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is CalendarLoaded) {
                  final events = state.events;
                  return CalendarGrid(
                    events: events,
                    selectedYear: selectedYear, // Truyền selectedYear
                    selectedMonth: selectedMonth, // Truyền selectedMonth
                    onDayTap: (String selectedDay) {
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
                            events: eventsForDay.map((e) => e.title).toList(),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is CalendarError) {
                  return Center(child: Text('Có lỗi: ${state.message}'));
                }
                return const Center(child: Text('Không có sự kiện nào')); // Trả về thông báo nếu không có sự kiện
              },
            ),
          ),
        ],
      ),
    );
  }
}
