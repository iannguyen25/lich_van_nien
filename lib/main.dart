import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lich_van_nien/app.dart';
import 'data/datasources/local/local_storage.dart';
import 'data/repositories/calendar_repository.dart';
import 'domain/usecases/get_calendar_events.dart';
import 'domain/usecases/convert_solar_to_lunar.dart';
import 'presentation/blocs/calendar/calendar_bloc.dart';
// Uncomment the following imports if using Firebase
// import 'package:firebase_core/firebase_core.dart';
// import 'services/auth_service.dart';
// import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(); // Uncomment if using Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localStorage = LocalStorage();
    final calendarRepository = CalendarRepository(localStorage: localStorage);

    return MultiBlocProvider(
      providers: [
        BlocProvider<CalendarBloc>(
          create: (context) => CalendarBloc(
            getCalendarEvents: GetCalendarEvents(calendarRepository: calendarRepository),
            convertSolarToLunar: ConvertSolarToLunar(),
            calendarRepository: calendarRepository,
          ),
        ),
        // Add other BlocProviders here if needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lịch Vạn Niên',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        home: const App(),
      ),
    );
  }
}