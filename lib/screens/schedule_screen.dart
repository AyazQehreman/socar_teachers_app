import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  CalendarController _calendarController;
  Map<DateTime, List> _events ;
  List _selectedEvents;

  @override
  void initState() {
    super.initState();

    final _selectedDay = DateTime.now();

    _events = {
      _selectedDay.subtract(Duration(days: 1)) : ['Event Something'],
      _selectedDay.subtract(Duration(days: 2)) : ['Event 2'],
    };
    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();


  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.lightBlueAccent,
          child: TableCalendar(
            headerStyle: HeaderStyle(
                formatButtonVisible: false, centerHeaderTitle: true),
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
                todayColor: Colors.red,
                selectedColor: Colors.orange,
                weekendStyle: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                )),
            calendarController: _calendarController,
          ),
        ),
        Expanded(
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.lightBlueAccent,
                child: Text("Next lesson",
                    style: TextStyle(
                      fontSize: 30.0,
                    ))),
          ),
        ),
      ],
    );
  }
}
