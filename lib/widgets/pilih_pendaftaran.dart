
import 'package:bapenda_getx2_admin/app/routes/app_pages.dart';
import 'package:bapenda_getx2_admin/widgets/texts.dart';
import 'package:bapenda_getx2_admin/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

PilihPendaftaran(BuildContext context) {
    Alert(
            context: context,
            content: Container(
              height: MediaQuery.of(context).size.height / 4.5,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Column(
                  children: [
                    Texts.headline6("Pilih Jenis Pendaftaran", isBold: true),
                    SizedBox(height: 7.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 115.w,
                          height: 115.h,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 1),
                                  blurRadius: 2.0)
                            ],
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                          ),
                          child: Material(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12.0),
                              onTap: () {
                                Get.back();
                                Get.toNamed(Routes.TAMBAH_NPWPD);
                              },
                              splashColor: primaryColor,
                              splashFactory: InkSplash.splashFactory,
                              child: Container(
                                padding: EdgeInsets.all(2.0),
                                child: Column(
                                  children: <Widget>[
                                    Image.asset(
                                      "assets/images/icon-npwpd.png",
                                      width: 70.w,
                                      height: 70.h,
                                    ),
                                    SizedBox(
                                      height: 4.0,
                                    ),
                                    Texts.captionSm("Sudah Memiliki NPWPD",
                                        isBold: true,
                                        maxLines: 2,
                                        textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 115.w,
                          height: 115.h,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 1),
                                  blurRadius: 2.0)
                            ],
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                          ),
                          child: Material(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12.0),
                              onTap: () {
                                Get.back();
                                Get.toNamed(Routes.TAMBAH_NPWPDBARU);
                              },
                              splashColor: primaryColor,
                              splashFactory: InkSplash.splashFactory,
                              child: Container(
                                padding: EdgeInsets.all(2.0),
                                child: Column(
                                  children: <Widget>[
                                    Image.asset(
                                      "assets/images/icon-nonnpwpd.png",
                                      width: 70.w,
                                      height: 70.h,
                                    ),
                                    SizedBox(
                                      height: 4.0,
                                    ),
                                    Texts.captionSm("Daftar Baru NPWPD",
                                        isBold: true,
                                        maxLines: 2,
                                        textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            style: AlertStyle(
                isButtonVisible: false, animationType: AnimationType.grow))
        .show();
  }