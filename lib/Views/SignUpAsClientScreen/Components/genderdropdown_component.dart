import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../Controllers/DropDownGenderController.dart';
import '../../../Utils/colors.dart';
import '../../../themeChanger/themeChangerProvider/theme_changer_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GenderDropDownComponent extends StatefulWidget {
  const GenderDropDownComponent({Key? key}) : super(key: key);

  @override
  State<GenderDropDownComponent> createState() => _GenderDropDownComponentState();
}

class _GenderDropDownComponentState extends State<GenderDropDownComponent> {
  final GenderDropDownController controller = Get.put(GenderDropDownController());

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          width: double.infinity, // Make the container span full width
          height: 38.h,
          decoration: BoxDecoration(
            color: themeProvider.themeMode == ThemeMode.dark ? AppColors.black12 : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(5.r),
            border: Border.all(
              color: themeProvider.themeMode == ThemeMode.dark ? AppColors.white : AppColors.black,
            ),
          ),
          padding: EdgeInsets.only(left: 0.w),
          child: Obx(() {
            return DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true, // Make the dropdown button fill the container
                value: controller.dropdownValue.value,
                icon: Container(
                  width: 49.w,
                  height: 38.h,
                  decoration: BoxDecoration(
                    color: AppColors.grey41,
                    border: Border.all(
                      color: themeProvider.themeMode == ThemeMode.dark ? AppColors.white : AppColors.black,
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/downicon.png',
                    color: AppColors.tealB3,
                  ),
                ),
                onChanged: (value) {
                  controller.changeGenderDropDown(value!);
                },
                items: [
                  'Male',
                  'Female',
                  'Other',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                      width: 315,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: themeProvider.themeMode == ThemeMode.dark ? AppColors.white : AppColors.black,
                        ),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(3), bottomLeft: Radius.circular(3)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          value,
                          style: TextStyle(
                            color: themeProvider.themeMode == ThemeMode.dark ? AppColors.white : AppColors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
                dropdownColor: AppColors.tealB3,
                borderRadius: BorderRadius.circular(5.r),

                style: TextStyle(
                  color: themeProvider.themeMode == ThemeMode.dark ? AppColors.white : AppColors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter',
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
