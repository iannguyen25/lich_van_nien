import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lich_van_nien/presentation/blocs/calendar/calendar_bloc.dart';
import 'package:lich_van_nien/presentation/blocs/theme/theme_bloc.dart';
import 'package:lich_van_nien/data/datasources/local/local_storage.dart';
import 'package:lich_van_nien/data/repositories/calendar_repository.dart';
import 'package:lich_van_nien/app.dart';
import 'package:lich_van_nien/config/theme.dart'; // Import your theme configuration

// Uncomment the following imports if using Firebase
// import 'package:firebase_core/firebase_core.dart';
// import 'services/auth_service.dart';
// import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeBloc = ThemeBloc(); // Create an instance of ThemeBloc

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CalendarBloc>(
          create: (context) {
            final localStorage = LocalStorage();
            final calendarRepository = CalendarRepository(localStorage: localStorage);
            return CalendarBloc(calendarRepository: calendarRepository);
          },
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => themeBloc,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Lịch Vạn Niên',
          theme: state.themeData,
          darkTheme: getDarkTheme(),
          themeMode: state.themeData.brightness == Brightness.dark
              ? ThemeMode.dark
              : ThemeMode.light,
          home: const App(),
        );
      },
    );
  }
}
