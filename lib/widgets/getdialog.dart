import 'package:bapenda_getx2_admin/widgets/buttons.dart';
import 'package:bapenda_getx2_admin/widgets/texts.dart';
import 'package:bapenda_getx2_admin/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class getDefaultDialog {
  void onConfirm({
    required String title,
    required String desc,
    required String kategori,
    required VoidCallback handler,
  }) {
    Get.defaultDialog(
      radius: 12.r,
      titlePadding: EdgeInsets.zero,
      content: Column(
        children: [
          Lottie.asset('assets/lottie/${kategori}.json',
              width: 100.w, repeat: false),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 9.r),
            child: Text(
              "${title}",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.r),
            child: Text(
              "${desc}",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17.sp),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
      actions: [
        SizedBox(
          width: 80.w,
          child: Buttons.gradientButton(
            handler: () {
              Get.back();
            },
            widget: Texts.button("Tidak"),
            borderSide: false,
            gradient: [
              Colors.pinkAccent.withOpacity(0.8),
              Colors.redAccent.withOpacity(0.7)
            ],
          ),
        ),
        SizedBox(
          width: 80.w,
          child: Buttons.gradientButton(
            handler: handler,
            widget: Texts.button("Ya"),
            borderSide: false,
            gradient: [Colors.cyan, Colors.greenAccent],
          ),
        ),
      ],
    );
  }

  void onConfirmWithoutIcon({
    required String title,
    required String desc,
    required VoidCallback handler,
  }) {
    Get.defaultDialog(
      radius: 12.r,
      titlePadding: EdgeInsets.zero,
      content: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 9.r, horizontal: 7.r),
            child: Text(
              "${title}",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.r),
            child: Text(
              "${desc}",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17.sp),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
      actions: [
        SizedBox(
          width: 80.w,
          child: Buttons.gradientButton(
            handler: () {
              Get.back();
            },
            widget: Texts.button("Tidak"),
            borderSide: false,
            gradient: [
              Colors.pinkAccent.withOpacity(0.8),
              Colors.redAccent.withOpacity(0.7)
            ],
          ),
        ),
        SizedBox(
          width: 80.w,
          child: Buttons.gradientButton(
            handler: handler,
            widget: Texts.button("Ya"),
            borderSide: false,
            gradient: [Colors.cyan, Colors.greenAccent],
          ),
        ),
      ],
    );
  }

  void onFix({
    required String title,
    required String desc,
    required String kategori,
  }) {
    Get.defaultDialog(
      radius: 12.r,
      titlePadding: EdgeInsets.zero,
      content: Column(
        children: [
          Lottie.asset('assets/lottie/${kategori}.json',
              width: 120.w, repeat: false),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.r, horizontal: 10.r),
            child: Text(
              "${title}",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.r),
            child: Text(
              "${desc}",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
      actions: [
        SizedBox(
          width: 80.w,
          child: Buttons.gradientButton(
            handler: () {
              Get.back();
            },
            widget: Texts.button("Ok"),
            borderSide: false,
            gradient: [Colors.cyan, Colors.indigo],
          ),
        ),
      ],
    );
  }

  void onFixWithHandler({
    required String title,
    required String desc,
    required String kategori,
    required VoidCallback handler,
  }) {
    Get.defaultDialog(
      barrierDismissible: false,
      radius: 12.r,
      titlePadding: EdgeInsets.zero,
      content: Column(
        children: [
          Lottie.asset('assets/lottie/${kategori}.json',
              width: 120.w, repeat: false),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.r, horizontal: 10.r),
            child: Text(
              "${title}",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.r),
            child: Text(
              "${desc}",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
      actions: [
        SizedBox(
          width: 80.w,
          child: Buttons.gradientButton(
            handler: handler,
            widget: Texts.button("Ok"),
            borderSide: false,
            gradient: [Colors.cyan, Colors.indigo],
          ),
        ),
      ],
    );
  }

  void onFixWithoutIcon({
    required String title,
    required String desc,
  }) {
    Get.defaultDialog(
      radius: 12.r,
      title: "",
      titlePadding: EdgeInsets.zero,
      content: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 9.r),
            child: Text(
              "${title}",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.r),
            child: Text(
              "${desc}",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.sp),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
      actions: [
        SizedBox(
          width: 80.w,
          child: Buttons.gradientButton(
            handler: () {
              Get.back();
            },
            widget: Texts.button("Ok"),
            borderSide: false,
            gradient: [Colors.cyan, Colors.indigo],
          ),
        ),
      ],
    );
  }

  void BannerDashboard({
    required String title,
    required String desc,
  }) {
    Get.defaultDialog(
      title: "",
        backgroundColor: Colors.transparent,
        titlePadding: EdgeInsets.zero,
        content: Stack(
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Image.asset(
                "assets/images/banner.png",
                width: 280.w,
              ),
            ),
            Positioned(
              right: 10.w,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 28.sp,
                  height: 28.sp,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x2B202529),
                        offset: Offset(0, 2),
                      )
                    ],
                    shape: BoxShape.circle,
                  ),
                  alignment: AlignmentDirectional(0.00, 0.00),
                  child: Icon(
                    Icons.cancel_outlined,
                    color: MainColor,
                    size: 26.sp,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

// void getDefaultDialogFix(String text, String kategori) {
//   Get.defaultDialog(
//       title: "",
//       titlePadding: EdgeInsets.all(0),
//       content: Column(
//         children: [
//           Text(
//             text,
//             style: TextStyle(fontWeight: FontWeight.w600),
//           ),
//           Lottie.asset('assets/lottie/${kategori}.json',
//               width: 500.w, repeat: false),
//         ],
//       ),
//       contentPadding: EdgeInsets.symmetric(vertical: 0),
//       radius: 10,
//       textConfirm: "Ok");

//   //Auto dismissing after the 2 seconds
//   // You can set the time as per your requirements in Duration
//   // This will dismiss the dialog automatically after the time you
//   // have mentioned
// }

// void getDefaultDialogtoHome(String text, String kategori, int timer) {
//   Get.defaultDialog(
//       title: "",
//       titlePadding: EdgeInsets.all(0),
//       content: Column(
//         children: [
//           Text(
//             text,
//             style: TextStyle(fontWeight: FontWeight.w600),
//           ),
//           Lottie.asset('assets/lottie/${kategori}.json',
//               width: 500.w, repeat: false),
//         ],
//       ),
//       contentPadding: EdgeInsets.symmetric(vertical: 0),
//       radius: 10);
//   Future.delayed(Duration(seconds: timer), () {
//     Get.offAllNamed(Routes.DASHBOARD);
//   });
// }

// void getDialog(String title, String text) {
//   Get.dialog(
//     AlertDialog(
//       title: Text(title),
//       content: Text(text),
//       actions: [
//         TextButton(
//           child: Text("Ok"),
//           onPressed: () => Get.back(),
//         ),
//       ],
//     ),
//   );
// }

void GetDialogDismissible(
    {required int currentversion, required String DBVersion}) {
  Get.defaultDialog(
    barrierDismissible: false,
    title: "",
    // titleStyle: TextStyle(fontSize: 20.sp),
    titlePadding: EdgeInsets.all(0),
    content: Column(
      children: [
        Lottie.asset('assets/lottie/error.json', width: 120.w, repeat: true),
        Text(
          'Update Versi Terbaru Tersedia!',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 10.h),
        Text(
          'Versi Terbaru 1.${DBVersion} Aplikasi telah tersedia, Versi Anda sekarang adalah 1.${currentversion}',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15.sp),
        ),
        Text(
          'Silahkan Hubungi Super Admin',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15.sp),
        ),
      ],
    ),
    contentPadding: EdgeInsets.only(bottom: 10, top: 0),
    radius: 10,
    actions: [
      SizedBox(
        width: 100.w,
        child: Buttons.gradientButton(
          handler: () {},
          widget: Texts.button("Update"),
          borderSide: false,
          gradient: [Colors.cyan, Colors.greenAccent],
        ),
      ),
    ],
  );
}
