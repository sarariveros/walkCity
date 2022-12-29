import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
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
          backgroundColor: Styles.secondColor,
          
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20),
                color: Styles.secondColor,
                width: double.maxFinite,
                child: Text(
                  widget.festivity.title,
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
              TableCalendar(
                firstDay: DateTime.utc(DateTime.now().year - 1, 1, 1),
                lastDay: DateTime.utc(DateTime.now().year + 1, 12, 31),
                focusedDay: DateTime.utc(getYear(widget.festivity.month),
                    widget.festivity.month, widget.festivity.day),
                eventLoader: _getEventForDay,
                headerStyle: HeaderStyle(
                    titleTextStyle:
                        TextStyle(color: Colors.white, fontSize: 20),
                    headerMargin: EdgeInsets.only(bottom: 20),
                    formatButtonVisible: false,
                    titleCentered: true,
                    leftChevronIcon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                    rightChevronIcon: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      color: Styles.secondColor,
                    )),
                calendarFormat: _calendarFormat,
                calendarStyle: CalendarStyle(
                    tablePadding:
                        EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    todayDecoration: BoxDecoration(
                        color: Styles.sitecardColor,
                        borderRadius: BorderRadius.circular(20)),
                    selectedDecoration: BoxDecoration(
                        color: Styles.secondColor,
                        borderRadius: BorderRadius.circular(20)),
                    markerDecoration: BoxDecoration(
                        color: Styles.firstColor,
                        borderRadius: BorderRadius.circular(20))),
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
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
              Container(
                width: 320,
                height: 180,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage(widget.festivity.image),
                        fit: BoxFit.cover),
                    border: Border.all(color: Styles.secondColor, width: 3)),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }
}
