import 'package:bapenda_getx2_admin/app/routes/app_pages.dart';
import 'package:bapenda_getx2_admin/widgets/custom_appbar.dart';
import 'package:bapenda_getx2_admin/widgets/custtombottombar.dart';
import 'package:bapenda_getx2_admin/widgets/nodata.dart';
import 'package:bapenda_getx2_admin/widgets/shimmer.dart';
import 'package:bapenda_getx2_admin/widgets/texts.dart';
import 'package:bapenda_getx2_admin/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/pendaftaran_controller.dart';

class PendaftaranView extends GetView<PendaftaranController> {
  const PendaftaranView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(title: "Pendaftaran WP", leading: true, isLogin: true),
      body: GetBuilder<PendaftaranController>(
        init: PendaftaranController(),
        builder: (controller) {
          if (controller.isEmpty) {
            return NoData(); //menampilkan lotties no data
          }

          if (controller.isLoading) {
            return ShimmerWidget.Items1();
          }
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.r),
            child: ListView.builder(
                itemCount: controller.datalist.length + 1,
                controller: controller.controllerScroll,
                itemBuilder: (context, index) {
                  if (index < controller.datalist.length) {
                    var dataitem = controller.datalist[index];
                    String? assetpajak;
                    if (dataitem.jenispajak == "HOTEL") {
                      assetpajak = "hotel";
                    } else if (dataitem.jenispajak == "HIBURAN") {
                      assetpajak = "hiburan";
                    } else if (dataitem.jenispajak == "RESTORAN" ||
                        dataitem.jenispajak == "CAFETARIA" ||
                        dataitem.jenispajak == "WARUNG") {
                      assetpajak = "restaurant";
                    } else if (dataitem.jenispajak == "Parkir") {
                      assetpajak = "parkir";
                    } else if (dataitem.jenispajak == "CATERING") {
                      assetpajak = "catering";
                    } else {
                      assetpajak = "hotel";
                    }
                    return InkWell(
                      onTap: () {
                        Get.toNamed(Routes.PENDAFTARAN_DETAIL,
                            arguments: dataitem,
                            parameters: {
                              "authModel_nik": controller.authModel.nik!
                            });
                      },
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 5, 7),
                        child: Container(
                          height: 92.h,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 9,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Container(
                                    width: 330.w,
                                    height: 80.h,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF0e3f8a),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5,
                                          color: Color(0x33000000),
                                          offset: Offset(0, 3),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          57, 4, 12, 12),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 220.w,
                                            child: Texts.caption(
                                                "${dataitem.namaUsaha}",
                                                isBold: true,
                                                color: Colors.white),
                                          ),
                                          Texts.captionSm(
                                              "Jenis Pajak : ${dataitem.jenispajak}",
                                              color: Colors.white),
                                          SizedBox(height: 9.h),
                                          SelectionArea(
                                              child: Texts.captionXs(
                                                  'Terakhir Login ',
                                                  color: Colors.white)),
                                          SelectionArea(
                                              child: Texts.captionXs(
                                                  'Yesterday, 4:21pm ',
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Container(
                                  width: 66.h,
                                  height: 69.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 5,
                                        color: Color(0x33000000),
                                        offset: Offset(0, 3),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(
                                      color: Color(
                                          0xFF0e3f8a), // Set the border color
                                      width: 1, // Set the border width
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.r),
                                    child: Image.asset(
                                      "assets/icon/icon-${assetpajak}.png",
                                      height: 20.h,
                                      width: 20.w,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 1,
                                child: SizedBox(
                                  height: 21.h,
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                dataitem.status == "0"
                                                    ? kdaftar
                                                    : dataitem.status == "3"
                                                        ? kdaftar
                                                        : kdisetujui),
                                      ),
                                      child: dataitem.status == "0"
                                          ? Text(
                                              'Daftar Baru',
                                              style: TextStyle(fontSize: 13.sp),
                                            )
                                          : dataitem.status == "3"
                                              ? Text(
                                                  'Daftar Lama',
                                                  style: TextStyle(
                                                      fontSize: 13.sp),
                                                )
                                              : Text(
                                                  'Aktif',
                                                  style: TextStyle(
                                                      fontSize: 13.sp),
                                                )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Center(
                        child: controller.hasMore
                            ? CircularProgressIndicator()
                            : Text("Tidak ada data lagi"),
                      ),
                    );
                  }
                }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Container(
          width: 60.w,
          height: 60.h,
          child: Icon(
            Icons.add,
            size: 40,
          ),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: gradientColor)),
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: customButtomBar(),
    );
  }
}
