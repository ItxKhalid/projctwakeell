import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:projctwakeell/Utils/images.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../../Utils/colors.dart';
import '../../service/Userclass.dart';
import '../LawyerDashBoardScreen/Components/dialog.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    fetchAppointments();
  }

  Future<List<Map<String, dynamic>>> fetchAppointments() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('appointments').get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Error fetching appointments: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
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
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _calendarFormat = CalendarFormat.month;
                      });
                    },
                    icon: const Icon(Icons.calendar_today, color: Colors.teal),
                    label: const Text('Month',
                        style: TextStyle(color: Colors.teal)),
                  ),
                  const SizedBox(width: 10), // Add space between buttons
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _calendarFormat = CalendarFormat.twoWeeks;
                      });
                    },
                    icon: const Icon(Icons.calendar_view_month,
                        color: Colors.teal),
                    label: const Text('Two Weeks',
                        style: TextStyle(
                            color: Colors.teal)), // Changed text color here
                  ),
                  const SizedBox(width: 10), // Add space between buttons
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _calendarFormat = CalendarFormat.week;
                      });
                    },
                    icon: const Icon(Icons.calendar_view_week,
                        color: Colors.teal),
                    label: const Text('Week',
                        style: TextStyle(
                            color: Colors.teal)), // Changed text color here
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
                selectedDecoration: const BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: const TextStyle(color: Colors.white),
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
            FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchAppointments(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: AppConst.spinKitWave());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No events found'));
                } else {
                  return EventList(events: snapshot.data!);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAddEventDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AddEventDialog();
          },
        );
      },
    );
  }
}

class EventList extends StatelessWidget {
  final List<Map<String, dynamic>> events;

  const EventList({Key? key, required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        Map<String, dynamic> event = events[index];
        String title = event['title'] ?? 'No Title';

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          // Add padding
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200], // Light grey background color
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            child: ListTile(
              title: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
              ),
              subtitle: Text(
                event['startDate'].toString(),
                // Custom date format
                style: const TextStyle(),
              ),
              onTap: () {
                // Add your action when tapping on an event
              },
            ),
          ),
        );
      },
    );
  }
}
