import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:projctwakeell/Utils/colors.dart';
import 'package:projctwakeell/Views/CreateAccountSCreen/create_account_screen.dart';
import 'package:projctwakeell/Widgets/custom_radiolistile.dart';
import 'package:provider/provider.dart';
import '../../Controllers/RadioListEngUrdu_controller.dart';
import '../../Utils/images.dart';
import '../../Widgets/custom_Container_button.dart';
import '../../Widgets/custom_text.dart';
import '../../themeChanger/themeChangerProvider/theme_changer_provider.dart';

class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({super.key});
  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}
class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {

  final RadioListEngUrduController controller=Get.put(RadioListEngUrduController());
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(top: 38.h,left: 39.w),
              child: Align(
                alignment: Alignment.topLeft,
                child: CustomText(
                    textAlign: TextAlign.left,
                    text:'Wakeel Naama',
                    color: AppColors.tealB3,
                    fontSize: 20.91.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily:'Acme'),
              ),
            ),


            Padding(
              padding:  EdgeInsets.only(top: 20.h,left: 90.w,right: 90.w),
             child: Image.asset(AppImages.image1,width: 214.w,height: 236.h,fit: BoxFit.cover,),
            ),

            Padding(
              padding:  EdgeInsets.only(top:20.h,left: 33.w),
              child: Align(
                alignment: Alignment.topLeft,
                child: CustomText(
                    textAlign: TextAlign.left,
                    text:'Connect with Expert\nLawyers, Anytime,\nAnywhere !',
                    color: themeProvider.themeMode == ThemeMode.dark
                        ? AppColors.white // Dark theme color
                        : AppColors.black,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily:'Mulish'),
              ),
            ),

            Padding(
              padding:  EdgeInsets.only(top: 40.h,),
              child: Align(
                alignment: Alignment.center,
                child: CustomText(
                    textAlign: TextAlign.center,
                    text:'Choose the language',
                    color: AppColors.tealB3,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily:'Mulish'),
              ),
            ),


        Obx(() {
          return  Padding(
            padding: EdgeInsets.only(top: 30.h,left: 33.w,right: 34.w),
            child: CustomRadioList(
              contentpadding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 0.h),
        radioValue: "English",
        onChanged:( value){
         controller.ChangeRadioButtonEngUrdu(value);
        },
        groupValue: controller.radioengvalue.value,
        title: 'English'),
          );



        }
        ),

               Obx(() {
         return    Padding(
           padding: EdgeInsets.only(top: 22.38.h,left: 33.w,right: 34.w),
           child: CustomRadioList(
               contentpadding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 0.h),
               radioValue: "Urdu",
               onChanged:( value){
                 controller.ChangeRadioButtonEngUrdu(value);
               },
               groupValue: controller.radioengvalue.value,
               title: 'Urdu'),
         );
               }),



            Padding(
              padding:  EdgeInsets.only(top: 30.h,left:38.w,right: 38.w),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateAccountScreen()));
                },
                child: CustomButton(borderRadius: BorderRadius.circular(10.r),
                    height: 55.h,
                    width: 317.w,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Mulish',
                    fontSize: 22.2.sp,
                    text: 'Continue',
                    backgroundColor: AppColors.tealB3,
                    color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
