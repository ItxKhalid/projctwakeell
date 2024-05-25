
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projctwakeell/Utils/colors.dart';
import 'package:projctwakeell/Views/LawyerDashBoardScreen/Components/Lawyer_message_screen.dart';
import 'package:projctwakeell/Widgets/custom_drawer.dart';
import '../../../Widgets/custom_client_drawer.dart';
import '../../../Widgets/custom_text.dart';
import '../../../service/Userclass.dart';


class ClientUpcommingScreen extends StatefulWidget {
  final UserModel loggedInUser;
  const ClientUpcommingScreen({super.key, required this.loggedInUser});

  @override
  State<ClientUpcommingScreen> createState() => _ClientUpcommingScreenState();
}

class _ClientUpcommingScreenState extends State<ClientUpcommingScreen> {


  @override
  Widget build(BuildContext context) {
    UserModel loggedInUser = widget.loggedInUser;

    return Scaffold(
      body: SafeArea(
        child:SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.only(top: 42.h,left: 39.w,right: 29.13.h),

              ),
            ],
          ),
        ),
      ),
      drawer: MyClientDrawer(loggedInUser: loggedInUser)

    );
  }
}