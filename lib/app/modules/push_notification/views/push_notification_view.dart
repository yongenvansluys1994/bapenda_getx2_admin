import 'dart:io';

import 'package:bapenda_getx2_admin/widgets/custom_appbar.dart';
import 'package:bapenda_getx2_admin/widgets/dismiss_keyboard.dart';
import 'package:bapenda_getx2_admin/widgets/easythrottle.dart';
import 'package:bapenda_getx2_admin/widgets/texts.dart';
import 'package:bapenda_getx2_admin/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/push_notification_controller.dart';

class PushNotificationView extends GetView<PushNotificationController> {
  const PushNotificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "Broadcast", leading: true, isLogin: true),
        body: GestureDetector(
            onTap: () => dismissKeyboard(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GetBuilder<PushNotificationController>(
                    init: PushNotificationController(),
                    builder: (controller) {
                      return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                        child: Column(
                          children: [
                            Center(
                                child: Texts.caption("Form Broadcast",
                                    isBold: true)),
                            SizedBox(height: 10.h),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: Color(0x33000000),
                                    offset: Offset(0, 2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 16, bottom: 16),
                                child: Form(
                                  key: controller.formKey,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 15),
                                            Container(
                                              child: TextFormField(
                                                controller: controller.judul,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(
                                                          18, 18, 18, 0),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  hintText:
                                                      'Masukan Judul Broadcast ',
                                                  labelText:
                                                      'Judul Broadcast  *',
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey,
                                                        width: 0.0),
                                                  ),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: lightGreenColor,
                                                        width: 2),
                                                  ),
                                                ),
                                              ),
                                              decoration:
                                                  BoxDecoration(boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 164, 186, 206),
                                                  blurRadius: 2,
                                                ),
                                              ]),
                                            ),
                                            SizedBox(height: 15),
                                            Container(
                                              child: TextFormField(
                                                minLines:
                                                    5, // any number you need (It works as the rows for the textarea)
                                                keyboardType:
                                                    TextInputType.multiline,
                                                textInputAction:
                                                    TextInputAction.newline,
                                                maxLines: null,
                                                controller: controller.isi,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(
                                                          18, 18, 18, 0),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  hintText: 'Isi Broadcast',
                                                  labelText: 'Isi Broadcast *',
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey,
                                                        width: 0.0),
                                                  ),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: lightGreenColor,
                                                        width: 2),
                                                  ),
                                                ),
                                              ),
                                              decoration:
                                                  BoxDecoration(boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 164, 186, 206),
                                                  blurRadius: 2,
                                                ),
                                              ]),
                                            ),
                                            SizedBox(height: 15),
                                            // Column(
                                            //   crossAxisAlignment:
                                            //       CrossAxisAlignment.start,
                                            //   children: [
                                            //     Padding(
                                            //       padding:
                                            //           const EdgeInsets.all(8),
                                            //       child: Text(
                                            //         "Upload Gambar/Thumbnail :",
                                            //       ),
                                            //     ),
                                            //     Container(
                                            //       width: 150.w,
                                            //       height: 75.h,
                                            //       child:
                                            //           (controller.imageFile ==
                                            //                   null)
                                            //               ? Text("")
                                            //               : Image.file(File(
                                            //                   controller
                                            //                       .imageFile!
                                            //                       .path)),
                                            //     ),
                                            //     SizedBox(
                                            //       width: 110.w,
                                            //       child: ElevatedButton(
                                            //         onPressed: () {
                                            //           controller
                                            //               .openGallery(context);
                                            //         },
                                            //         style: ButtonStyle(
                                            //           backgroundColor:
                                            //               MaterialStateProperty
                                            //                   .all<Color>(Color
                                            //                       .fromARGB(
                                            //                           255,
                                            //                           64,
                                            //                           64,
                                            //                           64)),
                                            //         ),
                                            //         child: Row(
                                            //           children: [
                                            //             Icon(Icons.camera_alt,
                                            //                 size: 20),
                                            //             SizedBox(
                                            //               width: 8,
                                            //             ),
                                            //             Text(
                                            //               'Pilih Gambar',
                                            //               style: TextStyle(
                                            //                   fontSize: 9.sp),
                                            //             )
                                            //           ],
                                            //         ),
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            width: 160.w,
                                            child: OutlinedButton.icon(
                                                //Handle button press event
                                                onPressed: () {
                                                  easyThrottle(
                                                    handler: () {
                                                      controller.tambah();
                                                    },
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  side: const BorderSide(
                                                    color: lightBlueColor,
                                                    width: 1,
                                                  ),
                                                  onPrimary: lightBlueColor,
                                                ),
                                                icon:
                                                    const Icon(Icons.save_alt),
                                                label: const Text(
                                                    "Kirim Broadcast")),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            )));
  }
}
