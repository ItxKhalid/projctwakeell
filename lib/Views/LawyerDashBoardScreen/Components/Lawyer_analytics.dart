import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../Utils/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../themeChanger/themeChangerProvider/theme_changer_provider.dart';

class LawyerAnalyticsScreen extends StatefulWidget {
  const LawyerAnalyticsScreen({Key? key});

  @override
  State<LawyerAnalyticsScreen> createState() => _LawyerAnalyticsScreenState();
}


class _LawyerAnalyticsScreenState extends State<LawyerAnalyticsScreen> {
  // Sample data for demonstration
  final double totalEarnings = 3000; // Replace with your actual data
  final double totalCashAdvance = 1000; // Replace with your actual data
  final double totalAmountLeft = 2000; // Replace with your actual data
  final List<String> months = ['Jan', 'Feb', 'Mar']; // List of months
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('My Analytics'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Earnings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Line chart for earnings, cash advance, and amount left
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: totalEarnings,
                      color: Colors.blue,
                      title: '\$${totalEarnings.toStringAsFixed(2)}',
                      radius: 70,
                    ),
                    PieChartSectionData(
                      value: totalCashAdvance,
                      color: Colors.red,
                      title: '\$${totalCashAdvance.toStringAsFixed(2)}',
                      radius: 70,
                    ),
                    PieChartSectionData(
                      value: totalAmountLeft,
                      color: Colors.green,
                      title: '\$${totalAmountLeft.toStringAsFixed(2)}',
                      radius: 70,
                    ),
                  ],
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  borderData: FlBorderData(show: false),
                  pieTouchData: PieTouchData(enabled: false),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(height: 10),
            // Row with three columns
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildColumn(text: 'Cash Advance', color: Colors.red),
                _buildColumn(text: 'Total Amount', color: Colors.blue),
                _buildColumn(text: 'Amount Left', color: Colors.green),
              ],
            ),
            SizedBox(height: 20),

            const Text(
              'Success Rates',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            // Bar chart for success rates
            SizedBox(
              height: 250,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  groupsSpace: 12,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTextStyles: (value) => TextStyle(color: AppColors.tealB3),
                      getTitles: (value) {
                        // Replace with your case labels
                        switch (value.toInt()) {
                          case 0:
                            return 'Case 1';
                          case 1:
                            return 'Case 2';
                          case 2:
                            return 'Case 3';
                        // Add more cases as needed
                          default:
                            return '';
                        }
                      },
                    ),
                    leftTitles: SideTitles(
                      showTitles: true,
                      getTextStyles: (value) => TextStyle(color: AppColors.tealB3),
                      getTitles: (value) {
                        // Adjust y-axis labels according to your requirement
                        switch (value.toInt()) {
                          case 0:
                            return '0';
                          case 1000:
                            return '1k';
                          case 1500:
                            return '1.5k';
                          case 2000:
                            return '2k';
                          case 2500:
                            return '2.5k';
                          case 3000:
                            return '3k';
                          default:
                            return '';
                        }
                      },
                    ),

                  ),
                  borderData: FlBorderData(show: true),
                  barGroups: List.generate(
                    months.length,
                        (index) => BarChartGroupData(
                      x: index,
                      barsSpace: 4,
                      barRods: [
                        BarChartRodData(
                          y: totalCashAdvance, // Red data for total cash advance
                          colors: [Colors.red],
                        ),
                        BarChartRodData(
                          y: totalEarnings, // Blue data for total earnings
                          colors: [Colors.blue],
                        ),
                        BarChartRodData(
                          y: totalAmountLeft, // Green data for total amount left
                          colors: [Colors.green],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
  Widget _buildColumn({required String text, required Color color}) {
    return Column(
      children: [
        Text(text),
        SizedBox(height: 5),
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
      ],
    );
  }

}



