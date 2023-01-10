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
  DateTime? _focuseddia;
  DateTime? _selecteddia;
  Map<DateTime, List> _eventsList = {};

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  int getYear(int mes) {
    if (DateTime.now().month > mes) {
      return DateTime.now().year + 1;
    } else {
      return DateTime.now().year;
    }
  }

  @override
  void initState() {
    super.initState();
    _selecteddia = DateTime.utc(getYear(widget.festivity.mes!),
        widget.festivity.mes!, widget.festivity.dia!);
    _eventsList = {
      DateTime.utc(getYear(widget.festivity.mes!), widget.festivity.mes!,
          widget.festivity.dia!): [widget.festivity.titulo]
    };
  }

  @override
  Widget build(BuildContext context) {
    final _events = LinkedHashMap<DateTime, List>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_eventsList);

    List _getEventFordia(DateTime dia) {
      return _events[dia] ?? [];
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.firstColor,
          title: Text( widget.festivity.titulo!,
                  style:const TextStyle(color: Colors.white, fontSize: 25),),
          
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              
              TableCalendar(
                firstDay: DateTime.utc(DateTime.now().year - 1, 1, 1),
                lastDay: DateTime.utc(DateTime.now().year + 1, 12, 31),
                focusedDay: DateTime.utc(getYear(widget.festivity.mes!),
                    widget.festivity.mes!, widget.festivity.dia!),
                eventLoader: _getEventFordia,
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
                      color: Styles.firstColor,
                    )),
                calendarFormat: _calendarFormat,
                calendarStyle: CalendarStyle(
                    tablePadding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    todayDecoration: BoxDecoration(
                        color: Color.fromARGB(255, 142, 140, 140),
                        borderRadius: BorderRadius.circular(20)),
                    selectedDecoration: BoxDecoration(
                        color: Styles.firstColor,
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
                selectedDayPredicate: (dia) {
                  return isSameDay(_selecteddia, dia);
                },
                onPageChanged: (focuseddia) {
                  _focuseddia = focuseddia;
                },
              ),
              Text("DESCRIPCIÓN:",textAlign: TextAlign.right,style: TextStyle(color: Styles.textColor,fontSize:23,fontWeight: FontWeight.bold),),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:15 ,horizontal:20 ),
                
                child: Text(widget.festivity.descripcion!,style: TextStyle(fontSize: 18,),textAlign: TextAlign.justify,),
              ),
              Container(
                width: 320,
                height: 180,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage(widget.festivity.imagen!),
                        fit: BoxFit.cover),
                    border: Border.all(color: Styles.secondColor, width: 3)),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
