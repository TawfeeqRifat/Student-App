import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: calendar_background_color,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: TableCalendar(

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
                          backgroundColor: calendar_notify_color,
                        ),
                      );
                    }
                    return null;
                  },
                  selectedBuilder: (context, day, focusedDay) {
                    return Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        backgroundColor: calendar_selected_color,
                        child: Text(
                          day.day.toString(),
                          style: TextStyle(
                            color: calendar_foreground_color
                          ),
                        ),
                      ),
                    );
                  },
                  todayBuilder: (context, day, focusedDay) {
                    return Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        backgroundColor: calendar_today_color,
                        child: Text(
                          day.day.toString(),
                          style: TextStyle(
                            color: calendar_foreground_color,
                            fontWeight: FontWeight.w100,
                            fontSize: 16
                          ),
                        ),
                      ),
                    );
                  },
                  defaultBuilder: (context, day, focusedDay) {
                    return Align(
                      alignment: Alignment.center,
                      child: Text(
                        day.day.toString(),
                        style: TextStyle(
                          color: calendar_foreground_color,
                          fontWeight: FontWeight.w100,
                          fontSize: 16
                        ),
                      ),
                    );
                  },
                  dowBuilder: (context, day) {
                    return Align(
                      alignment: Alignment.center,
                      child: Text(
                        DateFormat('EEEE').format(day).toString()[0],
                        style: TextStyle(
                          color: calendar_foreground_color
                        ),
                      )
                    );
                  },
                  outsideBuilder: (context, day, focusedDay) {
                    return Align(
                      child: Text(
                        day.day.toString(),
                        style: TextStyle(
                          color: calendar_foreground_color.withValues(alpha: 0.4),
                        ),
                      ),
                    );
                  },

                  headerTitleBuilder: (context, day) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        DateFormat("MMMM yyyy").format(day).toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: calendar_foreground_color,
                          fontSize: 20
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 16,),


            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(32), topLeft: Radius.circular(32))
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16,),
                      Text(
                          "Today",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      SizedBox(height: 16,),
                      ValueListenableBuilder<List<Event>>(
                        valueListenable: _selectedEvents,
                        builder: (context, value, _) {
                          return ListView.separated(
                            itemCount: value.length,
                            shrinkWrap: true,
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 16);
                            },
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black26,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8)
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${value[index]}',
                                            style: TextStyle(
                                              fontSize: 16
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Icon(Icons.alarm),
                                              Text("12:00")
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 16,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: (index % 2 == 0)? Colors.pink: Colors.teal,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(7),
                                          bottomRight: Radius.circular(7)
                                        )
                                      ),
                                    )
                                  ],
                                )
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
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
  final String level;

  const Event(this.title,this.level);

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
  '12-6-2025' : [
    {
      "message": "English Exam",
      "level": 1
    },
    {
      "message": "Semester Fee Last Date",
      "level" : 2
    },
  ],
  '27-6-2025' : [
    {
      "message": "English Exam",
      "level": 1
    },
    {
      "message": "Semester Fee Last Date",
      "level" : 2
    },
    // "Semester Fee Last Date"
  ],
};

void addcalendarInfo(){
  calInfo.forEach((day,infos) {
    final date = day.split('-').map(int.parse).toList();
    List<Event> events = [];
    for(var event in infos){
      events.add(Event(event['message'].toString(),event['level'].toString()));
    }
    _kEventSource [DateTime.utc(date[2],date[1],date[0])] = events;

  });
}

Color calendar_foreground_color = Colors.white;
Color calendar_background_color = Color(0xff87CEEB);
Color calendar_selected_color = Color(0xff00008B);
Color calendar_today_color = Color(0xff0F52BA);
Color calendar_notify_color = Colors.red;
