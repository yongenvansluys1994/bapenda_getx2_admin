import 'package:bapenda_getx2_admin/widgets/custom_appbar.dart';
import 'package:bapenda_getx2_admin/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/lap_detail_qris_controller.dart';

class LapDetailQrisView extends GetView<LapDetailQrisController> {
  const LapDetailQrisView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "QRIS ", leading: true, isLogin: true),
      body: SingleChildScrollView(
        child: GetBuilder<LapDetailQrisController>(
          init: LapDetailQrisController(),
          builder: (controller) {
            if (controller.isLoading) {
              return Center(
                child: Dialog(
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // The loading indicator
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 15,
                        ),
                        // Some text
                        Text('Loading...'),
                        Text(
                          "${controller.ket_loading}",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.r),
                  child: Texts.body1("Riwayat 30 Transaksi QRIS Terakhir "),
                ),
                Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      maxWidth: 500,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.w),
                      border: Border.all(
                        color: Color(0xFFF1F4F8),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 193, 193, 193),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: const Offset(2, 2),
                        ),
                        const BoxShadow(
                            color: Colors.white,
                            offset: Offset(-2, -2),
                            blurRadius: 10,
                            spreadRadius: 1),
                      ],
                    ),
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.datalist.length,
                        itemBuilder: (context, index) {
                          var datatitem = controller.datalist[index];
                          Color backgroundColor = datatitem.trxDate == ""
                              ? Colors.redAccent.withOpacity(0.8)
                              : index.isEven
                                  ? Color.fromARGB(255, 230, 230, 230)
                                  : Colors.white;

                          return GestureDetector(
                            onTap: () {
                              controller.openDialog(datatitem.kdTagihan);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: backgroundColor,
                              ),
                              height: 40.h,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(4.w),
                                    child: Container(
                                      width: 100.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Texts.captionXs(
                                            maxLines: 2,
                                            "${datatitem.namaUsaha}",
                                            color:
                                                Color.fromARGB(255, 59, 59, 59),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(4.w),
                                    child: Container(
                                      width: 55.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Texts.captionXs(
                                            "${datatitem.kdTagihan}",
                                            color:
                                                Color.fromARGB(255, 59, 59, 59),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(4.w),
                                    child: Container(
                                      width: 35.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Texts.captionXs(
                                            "${datatitem.jenispajak}",
                                            color:
                                                Color.fromARGB(255, 59, 59, 59),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(4.w),
                                    child: Container(
                                      width: 46.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Texts.captionXs(
                                            "${datatitem.tanggalLunas}",
                                            color:
                                                Color.fromARGB(255, 59, 59, 59),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(4.w),
                                    child: Container(
                                      width: 75.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Texts.captionXs(
                                            "${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(int.parse(datatitem.amount))}",
                                            color:
                                                Color.fromARGB(255, 59, 59, 59),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                  height: 40.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4.w),
                        child: Container(
                          width: 108.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Texts.captionXs(
                                "TOTAL",
                                isBold: true,
                                color: Color.fromARGB(255, 59, 59, 59),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 0.5.w),
                      Padding(
                        padding: EdgeInsets.all(4.w),
                        child: Container(
                          width: 52.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Texts.captionXs(
                                "",
                                color: Color.fromARGB(255, 59, 59, 59),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 0.5.w),
                      Padding(
                        padding: EdgeInsets.all(4.w),
                        child: Container(
                          width: 36.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Texts.captionXs(
                                "",
                                color: Color.fromARGB(255, 59, 59, 59),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 0.5.w),
                      Padding(
                        padding: EdgeInsets.all(4.w),
                        child: Container(
                          width: 88.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Texts.captionXs(
                                "asd",
                                isBold: true,
                                color: Color.fromARGB(255, 59, 59, 59),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            );
          },
        ),
      ),
    );
  }
}
