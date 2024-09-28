import 'package:flutter/material.dart';
   import 'presentation/pages/calendar_page.dart';
   import 'presentation/pages/home_page.dart';
   import 'presentation/pages/settings_page.dart';

  class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/calendar': (context) => const CalendarPage(),
        '/settings': (context) => const SettingsPage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/event-details':
            // Assume EventDetailsPage takes an event parameter
            // final event = settings.arguments as CalendarEvent;
            // return MaterialPageRoute(builder: (context) => EventDetailsPage(event: event));
            return null; // Implement event details page
          default:
            return null; // Handle unknown routes
        }
      },
    );
  }
}