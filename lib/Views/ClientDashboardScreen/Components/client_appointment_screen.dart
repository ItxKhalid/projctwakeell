import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:projctwakeell/Utils/colors.dart';
import 'package:provider/provider.dart';
import '../../../themeChanger/themeChangerProvider/theme_changer_provider.dart';
import 'client_upcomming_screen.dart';

class ClientAppointmentScreen extends StatefulWidget {
  const ClientAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<ClientAppointmentScreen> createState() => _ClientAppointmentScreenState();
}

class _ClientAppointmentScreenState extends State<ClientAppointmentScreen> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: TabBar(
            labelColor: AppColors.tealB3,
            unselectedLabelColor: themeProvider.themeMode == ThemeMode.dark
                ? AppColors.white // Dark theme color
                : AppColors.black,
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.teal, width: 2.0),
              ),
            ),
            tabs: [
              Tab(text: 'Upcoming', icon: Icon(Icons.new_label_rounded)),
              Tab(text: 'Past', icon: Icon(Icons.paste)),
              Tab(text: 'Cancelled', icon: Icon(Icons.cancel)),
            ],
          ),
        ),

      ),
    );
  }
}
