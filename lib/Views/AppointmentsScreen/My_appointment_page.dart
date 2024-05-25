import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../../Utils/colors.dart';
import '../../service/Userclass.dart';

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
    Event(name: 'Meeting', startDate: DateTime.now().subtract(const Duration(days: 1))),
    Event(name: 'Dentist Appointment', startDate: DateTime.now().add(const Duration(days: 1))),
    Event(name: 'Gym Session', startDate: DateTime.now().add(const Duration(days: 2))),
    Event(name: 'Family Dinner', startDate: DateTime.now().add(const Duration(days: 3))),
    Event(name: 'Conference', startDate: DateTime.now().add(const Duration(days: 4))),
  ];

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    fetchClientData().then((clientData) {
      setState(() {
        clients = clientData;
      });
    });
  }
  List<UserModel> clients = [];

  String? _selectedClient;
  UserModel? selectedClientData;
  Future<List<UserModel>> fetchClientData() async {
    List<UserModel> clients = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('client').get();
      clients = querySnapshot.docs.map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      print("Error fetching client data: $e");
    }
    return clients;
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
                    label: const Text('Month', style: TextStyle(color: Colors.teal)),
                  ),
                  const SizedBox(width: 10), // Add space between buttons
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _calendarFormat = CalendarFormat.twoWeeks;
                      });
                    },
                    icon: const Icon(Icons.calendar_view_month, color: Colors.teal),
                    label: const Text('Two Weeks', style: TextStyle(color: Colors.teal)), // Changed text color here
                  ),
                  const SizedBox(width: 10), // Add space between buttons
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _calendarFormat = CalendarFormat.week;
                      });
                    },
                    icon: const Icon(Icons.calendar_view_week, color: Colors.teal),
                    label: const Text('Week', style: TextStyle(color: Colors.teal)), // Changed text color here
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
            EventList(events: events),
          ],
        ),
      ),
    );
  }

  void _showAddEventDialog(BuildContext context) {
    TextEditingController startDateController = TextEditingController();
    TextEditingController endDateController = TextEditingController();
    TextEditingController titleController = TextEditingController();
    TextEditingController _fullNameController = TextEditingController();
    List<UserModel> clients = [];

    String? _selectedClient;
    UserModel? selectedClientData;
    Future<List<UserModel>> fetchClientData() async {
      List<UserModel> clients = [];

      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('client').get();
        clients = querySnapshot.docs.map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
      } catch (e) {
        print("Error fetching client data: $e");
      }
      return clients;
    }
    @override
    void initState() {
      super.initState();
      fetchClientData().then((clientData) {
        setState(() {
          clients = clientData;
        });
      });
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Event'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
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
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                const SizedBox(height: 10),
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
                  decoration: const InputDecoration(labelText: 'Start Date'),
                ),
                const SizedBox(height: 10),
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
                  decoration: const InputDecoration(labelText: 'End Date'),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedClient,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedClient = newValue;
                      if (_selectedClient != null) {
                        // Find the selected client from the list
                        selectedClientData = clients.firstWhere(
                              (client) => '${client.firstName} ${client.lastName}' == _selectedClient,

                        );
                        // If a matching client is found, set the contact number
                        if (selectedClientData != null) {
                          _fullNameController.text=selectedClientData!.firstName!+" "+selectedClientData!.firstName!;
                        }
                      }
                    });
                  },
                  items: clients.map((client) {
                    return DropdownMenuItem<String>(
                      value: '${client.firstName} ${client.lastName}',
                      child: Text('${client.firstName} ${client.lastName}'),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Select client',
                  ),
                ),
                // const TextField(decoration: InputDecoration(labelText: 'Repeated')),
                // const SizedBox(height: 10),
                // const TextField(decoration: InputDecoration(labelText: 'Alarm and Reminders')),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.check),
                    onPressed: ()async {
                      // Handle save logic here
                      String fullName = _fullNameController.text;
                      String startDate = startDateController.text;
                      String endDate = endDateController.text;
                      if (fullName.isNotEmpty)
                      {
                        /// save client data
                        String uid = FirebaseAuth.instance.currentUser!.uid;
                        String? email = FirebaseAuth.instance.currentUser!.email;

                        // Construct a map for the client data
                        Map<String, dynamic> clientData = {
                          'clientName': fullName,
                          'startDate': startDate,
                          'endDate': endDate,
                          'title': titleController.text.trim(),
                        };
                        await FirebaseFirestore.instance.collection('appointments').add(clientData).then((value) =>
                        {
                          Get.snackbar('Successfully', 'Appointment add',
                              backgroundColor: AppColors.blue,
                              colorText: AppColors.white,
                              borderRadius: 20.r,
                              icon: Icon(Icons.error_outline, color: AppColors.white,),
                              snackPosition: SnackPosition.TOP),
                          _selectedClient=null,
                          setState(() {
                          }),
                        });





                        /*try {
                          DocumentReference docRef = await FirebaseFirestore.instance.collection('client').add({
                            'firstName': firstName,
                            'lastName': lastName,
                            'email': email,
                            'cnic': cnic,
                            'phoneNumber': phoneNumber,
                            'gender': gender,
                          });

                          // Show success snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Registration successful! ID: ${docRef.id}'),
                            ),
                          );

                          // Clear text controllers
                          firstnameController.clear();
                          lastnameController.clear();
                          emailController.clear();
                          cnicController.clear();
                          fullPhoneNumber = '';
                          setState(() {
                            selectedGender = '';
                          });


                        } catch (e) {
                          // Show error snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to register your account: $e'),
                            ),
                          );
                        }*/
                      }
                      else
                      {
                        if (fullName.isEmpty) {
                          Get.snackbar('Error', 'Full Name Required!',
                              backgroundColor: AppColors.red,
                              colorText: AppColors.white,
                              borderRadius: 20.r,
                              icon: Icon(Icons.error_outline, color: AppColors.white,),
                              snackPosition: SnackPosition.TOP);
                        }

                        else if (endDate.isEmpty) {
                          Get.snackbar('Error', 'Please select end date',
                              backgroundColor: AppColors.red,
                              colorText: AppColors.white,
                              borderRadius: 20.r,
                              icon: Icon(Icons.error_outline, color: AppColors.white,),
                              snackPosition: SnackPosition.TOP);

                        }
                        else if (startDate.isEmpty) {
                          Get.snackbar('Error', 'Please select start date!',
                              backgroundColor: AppColors.red,
                              colorText: AppColors.white,
                              borderRadius: 20.r,
                              icon: Icon(Icons.error_outline, color: AppColors.white,),
                              snackPosition: SnackPosition.TOP);
                        }

                      }


                      // Clear the text fields after saving

                    }
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), // Add padding
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200], // Light grey background color
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
              child: ListTile(
                title: Text(
                  event.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  DateFormat('MM/dd/yyyy hh:mm a').format(event.startDate),
                  style: const TextStyle(),
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
