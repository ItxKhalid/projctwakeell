import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../Utils/colors.dart';
import '../../../themeChanger/themeChangerProvider/theme_changer_provider.dart';

class LawyerEarningScreen extends StatefulWidget {
  const LawyerEarningScreen({Key? key});

  @override
  State<LawyerEarningScreen> createState() => _LawyerEarningState();
}

class _LawyerEarningState extends State<LawyerEarningScreen> {
  int totalCount = 1000; // Initialize with your actual values
  int leftCount = 450; // Initialize with your actual values
  int advanceCount = 200; // Initialize with your actual values

  Widget _buildCustomCard(BuildContext context, String count, String title, IconData iconData) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    return Container(
      width: 120.w,
      height: 120.h,
      margin: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white, // Changed to white background color
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: AppColors.tealB3, // Changed to teal icon color
            size: 24.sp, // Changed to size 18
          ),
          SizedBox(height: 10.h),
          Text(
            count,
            style: TextStyle(
              color: Colors.black, // Changed to black text color
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            title,
            style: TextStyle(
              color: Colors.black, // Changed to black text color
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('My Earnings'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppColors.tealB3,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Set scroll direction to horizontal
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCustomCard(
                    context,
                    totalCount.toString(),
                    'Total Earnings',
                    Icons.monetization_on,
                  ),
                  _buildCustomCard(
                    context,
                    leftCount.toString(),
                    'Amount Left',
                    Icons.monetization_on,
                  ),
                  _buildCustomCard(
                    context,
                    advanceCount.toString(),
                    'Cash Advance',
                    Icons.monetization_on,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15.h),
          Padding(
            padding: EdgeInsets.all(8.0), // Adjust the padding as needed
            child: Text(
              'Case Records', // Replace with the message content
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold
              ),
            ),
          ),// Add some space between the two containers
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 500), // Set a maximum height
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.teal),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(
                        label: Text('Lawyer', style: TextStyle(color: Colors.teal)),
                      ),
                      DataColumn(
                        label: Text('Case', style: TextStyle(color: Colors.teal)),
                      ),
                      DataColumn(
                        label: Text('Date', style: TextStyle(color: Colors.teal)),
                      ),
                      DataColumn(
                        label: Text('Total Earnings', style: TextStyle(color: Colors.teal)),
                      ),
                      DataColumn(
                        label: Text('Cash Advance', style: TextStyle(color: Colors.teal)),
                      ),
                      DataColumn(
                        label: Text('Amount Left', style: TextStyle(color: Colors.teal)),
                      ),
                    ],
                    rows: const [
                      DataRow(cells: [
                        DataCell(Text('John Doe')),
                        DataCell(Text('Case A')),
                        DataCell(Text('2024-05-01')),
                        DataCell(Text('\$1000')),
                        DataCell(Text('\$200')),
                        DataCell(Text('\$450')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('John Doe')),
                        DataCell(Text('Case A')),
                        DataCell(Text('2024-05-01')),
                        DataCell(Text('\$1000')),
                        DataCell(Text('\$200')),
                        DataCell(Text('\$450')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('John Doe')),
                        DataCell(Text('Case A')),
                        DataCell(Text('2024-05-01')),
                        DataCell(Text('\$1000')),
                        DataCell(Text('\$200')),
                        DataCell(Text('\$450')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('John Doe')),
                        DataCell(Text('Case A')),
                        DataCell(Text('2024-05-01')),
                        DataCell(Text('\$1000')),
                        DataCell(Text('\$200')),
                        DataCell(Text('\$450')),
                      ]), DataRow(cells: [
                        DataCell(Text('John Doe')),
                        DataCell(Text('Case A')),
                        DataCell(Text('2024-05-01')),
                        DataCell(Text('\$1000')),
                        DataCell(Text('\$200')),
                        DataCell(Text('\$450')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('John Doe')),
                        DataCell(Text('Case A')),
                        DataCell(Text('2024-05-01')),
                        DataCell(Text('\$1000')),
                        DataCell(Text('\$200')),
                        DataCell(Text('\$450')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('John Doe')),
                        DataCell(Text('Case A')),
                        DataCell(Text('2024-05-01')),
                        DataCell(Text('\$1000')),
                        DataCell(Text('\$200')),
                        DataCell(Text('\$450')),
                      ]), DataRow(cells: [
                        DataCell(Text('John Doe')),
                        DataCell(Text('Case A')),
                        DataCell(Text('2024-05-01')),
                        DataCell(Text('\$1000')),
                        DataCell(Text('\$200')),
                        DataCell(Text('\$450')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('John Doe')),
                        DataCell(Text('Case A')),
                        DataCell(Text('2024-05-01')),
                        DataCell(Text('\$1000')),
                        DataCell(Text('\$200')),
                        DataCell(Text('\$450')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('John Doe')),
                        DataCell(Text('Case A')),
                        DataCell(Text('2024-05-01')),
                        DataCell(Text('\$1000')),
                        DataCell(Text('\$200')),
                        DataCell(Text('\$450')),
                      ]), DataRow(cells: [
                        DataCell(Text('John Doe')),
                        DataCell(Text('Case A')),
                        DataCell(Text('2024-05-01')),
                        DataCell(Text('\$1000')),
                        DataCell(Text('\$200')),
                        DataCell(Text('\$450')),
                      ]),




                      // Add more DataRow widgets for additional records
                    ],
                  ),
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
}
