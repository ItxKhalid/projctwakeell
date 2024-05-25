import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  List<Event> events = [
    Event(name: 'Meeting', startDate: DateTime.now().subtract(Duration(days: 1))),
    Event(name: 'Dentist Appointment', startDate: DateTime.now().add(Duration(days: 1))),
    Event(name: 'Gym Session', startDate: DateTime.now().add(Duration(days: 2))),
    Event(name: 'Family Dinner', startDate: DateTime.now().add(Duration(days: 3))),
    Event(name: 'Conference', startDate: DateTime.now().add(Duration(days: 4))),
  ];

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_circle_outline,
              color: Colors.teal, // Color specified here
              size: 30, // Size specified here
            ),
            onPressed: () {
              _showAddEventDialog(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _calendarFormat = CalendarFormat.month;
                      });
                    },
                    icon: Icon(Icons.calendar_today, color: Colors.teal),
                    label: Text('Month', style: TextStyle(color: Colors.teal)),
                  ),
                  SizedBox(width: 10), // Add space between buttons
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _calendarFormat = CalendarFormat.twoWeeks;
                      });
                    },
                    icon: Icon(Icons.calendar_view_month, color: Colors.teal),
                    label: Text('Two Weeks', style: TextStyle(color: Colors.teal)), // Changed text color here
                  ),
                  SizedBox(width: 10), // Add space between buttons
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _calendarFormat = CalendarFormat.week;
                      });
                    },
                    icon: Icon(Icons.calendar_view_week, color: Colors.teal),
                    label: Text('Week', style: TextStyle(color: Colors.teal)), // Changed text color here
                  ),
                ],
              ),
            ),
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(color: Colors.white),
                // Add other style properties as needed
              ),
            ),

            const SizedBox(height: 10), // Add some space
            const Padding(
              padding: EdgeInsets.only(left: 16.0), // Add left padding
              child: Text(
                'My Events', // Replace with the message content
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            EventList(events: events),
          ],
        ),
      ),
    );
  }

  void _showAddEventDialog(BuildContext context) {
    TextEditingController startDateController = TextEditingController();
    TextEditingController endDateController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Event'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(decoration: InputDecoration(labelText: 'Title')),
                SizedBox(height: 10),
                TextField(
                  controller: startDateController,
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      startDateController.text = pickedDate.toString();
                    }
                  },
                  decoration: InputDecoration(labelText: 'Start Date'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: endDateController,
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      endDateController.text = pickedDate.toString();
                    }
                  },
                  decoration: InputDecoration(labelText: 'End Date'),
                ),
                SizedBox(height: 10),
                TextField(decoration: InputDecoration(labelText: 'Repeated')),
                SizedBox(height: 10),
                TextField(decoration: InputDecoration(labelText: 'Alarm and Reminders')),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    // Add your action here
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class Event {
  final String name;
  final DateTime startDate;

  Event({required this.name, required this.startDate});
}

class EventList extends StatelessWidget {
  final List<Event> events;

  const EventList({Key? key, required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (BuildContext context, int index) {
          Event event = events[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), // Add padding
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200], // Light grey background color
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
              child: ListTile(
                title: Text(
                  "${event.name}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "${DateFormat('MM/dd/yyyy hh:mm a').format(event.startDate)}",
                  style: TextStyle(),
                ),
                onTap: () {
                  // Add your action when tapping on an event
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
