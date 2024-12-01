import 'package:flutter/material.dart';
import 'package:pusdatin_end/dummy/dummy_calendar.dart';
import 'package:pusdatin_end/widget/popup/event_dialog.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarCard extends StatefulWidget {
  @override
  _CalendarCardState createState() => _CalendarCardState();
}

class _CalendarCardState extends State<CalendarCard> with SingleTickerProviderStateMixin {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
  }

  // Fungsi untuk mendapatkan event per hari
  List<String> _getEventsForDay(DateTime day) {
    return dummyEvents[day] ?? [];
  }

  // Fungsi untuk mendapatkan penanda event pada kalender
  List<String> _getEventMarkersForDay(DateTime day) {
    if (day == _selectedDay) {
      return [];
    }
    return dummyEvents[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TableCalendar(
            firstDay: DateTime(2020, 1, 1),
            lastDay: DateTime(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              _showEventDialog(selectedDay);
            },
            eventLoader: _getEventMarkersForDay,
            calendarFormat: CalendarFormat.month,
            availableCalendarFormats: const {
              CalendarFormat.month: 'Perbulan',
            },
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.black87),
              rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.black87),
            ),
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
              defaultTextStyle: const TextStyle(color: Colors.black87),
              weekendTextStyle: const TextStyle(color: Colors.redAccent),
              outsideDaysVisible: false,
              markersMaxCount: 1,
              markerDecoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(color: Colors.black54),
              weekendStyle: TextStyle(color: Colors.redAccent),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // Fungsi untuk menampilkan dialog event saat memilih hari
  void _showEventDialog(DateTime selectedDay) {
    final events = _getEventsForDay(selectedDay);

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeIn,
              ),
            ),
            child: EventDialog(
              selectedDay: selectedDay,
              events: events,
            ),
          );
        },
        barrierColor: Colors.transparent,
        opaque: false,
        barrierDismissible: false,
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }
}
