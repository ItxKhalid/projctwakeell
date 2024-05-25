import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:projctwakeell/Controllers/RadioListClientLaywerController.dart';
import 'package:projctwakeell/Utils/colors.dart';
import 'package:projctwakeell/Views/SignUpAsClientScreen/signup_as_client_screen.dart';
import 'package:projctwakeell/Views/SignUpAsLawyerScreen/signup_as_lawyer_screen.dart';
import 'package:projctwakeell/Widgets/custom_radiolist2.dart';
import 'package:projctwakeell/Widgets/custom_Container_button.dart';
import 'package:projctwakeell/Widgets/custom_text.dart';
import 'package:provider/provider.dart';
import '../../Utils/images.dart';
import '../../themeChanger/themeChangerProvider/theme_changer_provider.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final RadioListClientLawyerController controller = Get.put(RadioListClientLawyerController());

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 42.h, left: 39.w),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: CustomText(
                    textAlign: TextAlign.left,
                    text: 'Wakeel Naama',
                    color: AppColors.tealB3,
                    fontSize: 20.91.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Acme',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 44.h),
                child: Align(
                  alignment: Alignment.center,
                  child: CustomText(
                    textAlign: TextAlign.center,
                    text: 'Join as a client or',
                    color: themeProvider.themeMode == ThemeMode.dark
                        ? AppColors.white // Dark theme color
                        : AppColors.black,
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Mulish',
                  ),
                ),
              ),
              Align(

                alignment: Alignment.center,
                child: CustomText(
                  textAlign: TextAlign.center,
                  text: 'Lawyer',
                  color: themeProvider.themeMode == ThemeMode.dark
                      ? AppColors.white // Dark theme color
                      : AppColors.black,
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Mulish',
                ),
              ),
              Obx(

                    () => Padding(
                  padding: EdgeInsets.only(top: 44.h, left: 33.w, right: 34.w),

                  child: GestureDetector(
                    onTap: () {
                      controller.changeRadioButtonClientLawyer("Im a client, looking for legal expertise and assistance");
                    },

                    child: CustomRadioList2(
                      image1: Image.asset(
                        AppImages.profileimg,color: themeProvider.themeMode==ThemeMode.dark ? AppColors.white : AppColors.black,
                        width: 51.w,
                        height: 46.w,
                        fit: BoxFit.cover,
                      ),
                      radioValue1: "Im a client, looking for legal expertise and assistance",
                      onChanged1: (value) {
                        controller.changeRadioButtonClientLawyer(value);
                      },
                      groupValue1: controller.radioclientvalue.value ?? "",
                      subtitle1: "Im a client, looking for legal expertise and assistance",
                    ),
                  ),
                ),
              ),
              Obx(
                    () => Padding(
                  padding: EdgeInsets.only(top: 24.h, left: 33.w, right: 34.w),
                  child: GestureDetector(
                    onTap: () {
                      controller.changeRadioButtonClientLawyer("I'm a lawyer, ready to offer my legal expertise and services");
                    },
                    child: CustomRadioList2(
                      image1: Image.asset(
                        AppImages.image2,color: themeProvider.themeMode==ThemeMode.dark ? AppColors.white:AppColors.black,
                        width: 56.w,
                        height: 46.w,
                        fit: BoxFit.cover,
                      ),
                      radioValue1: "I'm a lawyer, ready to offer my legal expertise and services",
                      onChanged1: (value) {
                        controller.changeRadioButtonClientLawyer(value);
                      },
                      groupValue1: controller.radioclientvalue.value ?? "",
                      subtitle1: "I'm a lawyer, ready to offer my legal expertise and services",
                    ),
                  ),
                ),
              ),
              Obx(
                    () {
                  bool isSelected = controller.radioclientvalue.value != null;
                  return Padding(
                    padding: EdgeInsets.only(top: 25.h, left: 38.w, right: 38.w),
                    child: CustomButton(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: AppColors.tealB3),
                      height: 55.h,
                      width: 317.w,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Mulish',
                      fontSize: 22.2.sp,
                      text: isSelected
                          ? (controller.radioclientvalue.value == "Im a client, looking for legal expertise and assistance"
                          ? "Join as a Client"
                          : "Join as a Lawyer")
                          : 'Create Account',
                      backgroundColor: isSelected ? AppColors.tealB3 : AppColors.black919,
                      color: AppColors.white,
                      onTap: () {
                        if (isSelected) {
                          if (controller.radioclientvalue.value == "Im a client, looking for legal expertise and assistance") {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupAsClientScreen()));
                          } else {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupAsLawyerScreen()));
                          }
                        }
                      },
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 25.h),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Already have an account?',
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? AppColors.white // Dark theme color
                            : AppColors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Mulish',
                      ),
                      CustomText(
                        text: ' Log In',
                        color: AppColors.tealB3,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Mulish',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
