import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/Utilities/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late final ValueNotifier<List<Event>> _selectedEvents;

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  void _onDaySelection(DateTime selectedDay, DateTime focuesedDay){
    if(!isSameDay(_selectedDay,selectedDay)){
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focuesedDay;
      });
      _selectedEvents.value = _getEventsForDay(selectedDay);

    }
  }

  @override
  void initState(){
    super.initState();
    addcalendarInfo();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(
    _getEventsForDay(_selectedDay!)
    );
  }

  @override dispose(){
    _selectedEvents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2025, 6, 1),
              lastDay: DateTime.utc(2026, 4, 30),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: _onDaySelection,
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              headerStyle: HeaderStyle(
                formatButtonVisible: false
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, events) {
                  if (kEvents[day]!=null) {
                    return Align(
                      alignment: Alignment(0.6, -0.6),
                      child: CircleAvatar(
                        radius: 3,
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                  return null;
                },
                selectedBuilder: (context, day, focusedDay) {
                  return Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundColor: AppThemeColor,
                      child: Text(
                        day.day.toString(),
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                  );
                },
                todayBuilder: (context, day, focusedDay) {
                  return Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundColor: AppThemeColor.withValues(alpha: 0.6),
                      child: Text(
                        day.day.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                          fontSize: 16
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16,),
            Expanded(
              child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppThemeColor
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            title: Text(
                              '${value[index]}',
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

Map<DateTime,List<Event>> _kEventSource = {};

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

final calInfo = {
  '5-6-2025' : [
    "assembly",
    "fees"
  ],
};

void addcalendarInfo(){
  calInfo.forEach((day,infos) {
    final date = day.split('-').map(int.parse).toList();
    List<Event> evnts = [];
    for(var evnt in infos){
      evnts.add(Event(evnt));
    }
    _kEventSource[DateTime.utc(date[2],date[1],date[0])] = evnts;

  });
}