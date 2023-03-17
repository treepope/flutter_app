import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CalendarController _calendarController = CalendarController();
  DateTime today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Card(
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.all(8.0),
              child: TableCalendar(
                focusedDay: today, 
                firstDay: DateTime.utc(2010, 10, 16), 
                lastDay: DateTime.utc(2030, 3, 14),
                weekendDays: const [6],
                headerStyle: HeaderStyle(
                  decoration: const BoxDecoration(
                    color: Colors.blue 
                  ),
                  headerMargin: const EdgeInsets.only(bottom: 8.0),
                  titleTextStyle: const TextStyle(color: Colors.white),
                  formatButtonDecoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  formatButtonTextStyle: const TextStyle(color: Colors.white),
                  leftChevronIcon: const Icon(Icons.chevron_left_rounded, color: Colors.white,),
                  rightChevronIcon: const Icon(Icons.chevron_right_rounded, color: Colors.white,),
              ),
              calendarStyle: const CalendarStyle(),
              calendarBuilders: const CalendarBuilders(), 
              )
            ),
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}