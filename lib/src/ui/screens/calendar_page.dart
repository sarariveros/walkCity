import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:walkcity/src/models/festivity_models.dart';
import 'package:walkcity/src/styles/style.dart';

class CalendarPage extends StatefulWidget {
  final Festivity festivity;
  const CalendarPage(this.festivity);
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _focusedDay;
  DateTime? _selectedDay;
  Map<DateTime, List> _eventsList = {};

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  int getYear(int month) {
    if (DateTime.now().month > month) {
      return DateTime.now().year + 1;
    } else {
      return DateTime.now().year;
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.utc(getYear(widget.festivity.month),
        widget.festivity.month, widget.festivity.day);
    _eventsList = {
      DateTime.utc(getYear(widget.festivity.month), widget.festivity.month,
          widget.festivity.day): [widget.festivity.title]
    };
  }

  @override
  Widget build(BuildContext context) {
    final _events = LinkedHashMap<DateTime, List>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_eventsList);

    List _getEventForDay(DateTime day) {
      return _events[day] ?? [];
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(199, 200, 34, 22),
        title: const Text('Calendario'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
        children: [
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TableCalendar(
              firstDay: DateTime.utc(DateTime.now().year - 1, 1, 1),
              lastDay: DateTime.utc(DateTime.now().year + 1, 12, 31),
              focusedDay: DateTime.utc(getYear(widget.festivity.month),
                  widget.festivity.month, widget.festivity.day),
              eventLoader: _getEventForDay,

              headerStyle: HeaderStyle(
                  headerMargin: EdgeInsets.only(top: 10,bottom: 20),
                  formatButtonVisible: false,
                  titleCentered: true,
                  decoration: BoxDecoration(
                    
                      color: Styles.firstColor,
                      borderRadius: BorderRadius.circular(20))),
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                  _getEventForDay(selectedDay);
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
          ),
          Column(
            children: _getEventForDay(_selectedDay!)
                .map((event) => Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.festivity.title,style: const TextStyle(fontSize: 25),),
                      ),
                      Container(
                        width: 320,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(20),
                          image: DecorationImage(image: NetworkImage(widget.festivity.image),fit: BoxFit.cover),
                          border: Border.all(color: Colors.amber,width: 3) ),
                          
                        
                      ),
                    ]))
                .toList(),
          ),
          SizedBox(height: 20,)
        ],
      ),
    ));
  }
}
