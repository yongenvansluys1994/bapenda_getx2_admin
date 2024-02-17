import 'package:bapenda_getx2_admin/app/modules/pendataan/controllers/pendataan_controller.dart';
import 'package:bapenda_getx2_admin/app/routes/app_pages.dart';
import 'package:bapenda_getx2_admin/widgets/nodata.dart';

import 'package:bapenda_getx2_admin/widgets/shimmer.dart';
import 'package:bapenda_getx2_admin/widgets/texts.dart';
import 'package:bapenda_getx2_admin/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Pendataan_all extends StatelessWidget {
  Pendataan_all({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PendataanController>(
      init: PendataanController(),
      builder: (controller) {
        if (controller.datalist_all.isEmpty) {
          return NoData(); //menampilkan lotties no data
        }
        if (controller.isLoading) {
          return ShimmerWidget.Items1();
        }
        return ListView.builder(
            controller: controller.controllerScroll,
            itemCount: controller.datalist_all.length + 1,
            itemBuilder: (context, index) {
              if (index < controller.datalist_all.length) {
                var item = controller.datalist_all[index];
                var itemjenispajak;
                switch (item.idRekening) {
                  case "1194":
                  case "1239":
                  case "1240":
                  case "1241":
                  case "1242":
                  case "1243":
                  case "1244":
                  case "1246":
                  case "1247":
                  case "1248":
                  case "1298":
                  case "1299":
                  case "1300":
                  case "2925":
                    itemjenispajak = "hotel";
                    break;
                  case "211":
                  case "1249":
                  case "1250":
                  case "1251":
                  case "1301":
                  case "2926":
                  case "2927":
                  case "2928":
                    itemjenispajak = "restaurant";
                    break;
                  case "213":
                  case "1256":
                  case "1257":
                  case "1258":
                  case "1259":
                  case "1260":
                  case "1261":
                  case "1262":
                  case "1263":
                  case "1264":
                  case "1267":
                  case "1269":
                  case "1270":
                  case "1273":
                  case "1306":
                    itemjenispajak = "hiburan";
                    break;
                  case "1255":
                    itemjenispajak = "catering";
                    break;
                  case "220":
                    itemjenispajak = "parkir";
                    break;
                  case "2964":
                  case "4278":
                  case "4279":
                  case "4281":
                  case "4285":
                  case "4287":
                  case "4288":
                    itemjenispajak = "ppj";
                    break;
                  default:
                    // Handle other cases or set a default value for itemjenispajak
                    break;
                }
                return Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
                  child: Container(
                    height: 90.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 0,
                          color: Color(0xFFE0E3E7),
                          offset: Offset(0, 1),
                        )
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        if (item.idRekening == "2964" ||
                            item.idRekening == "4278" ||
                            item.idRekening == "4279" ||
                            item.idRekening == "4281" ||
                            item.idRekening == "4285" ||
                            item.idRekening == "4287" ||
                            item.idRekening == "4288") {
                          Get.toNamed(Routes.PENDATAAN_DETAIL_PPJ,
                              arguments: item,
                              parameters: {
                                "authModel_nik": controller.authModel.nik!,
                                "jenis": "All"
                              });
                        } else {
                          Get.toNamed(Routes.PENDATAAN_DETAIL,
                              arguments: item,
                              parameters: {
                                "authModel_nik": controller.authModel.nik!,
                                "jenis": "All"
                              });
                        }
                      },
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 15.w,
                              child: Stack(
                                alignment: AlignmentDirectional(0, 0),
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0, -0.7),
                                    child: Container(
                                      width: 12.w,
                                      height: 12.w,
                                      decoration: BoxDecoration(
                                        color: lightBlueColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      VerticalDivider(
                                        thickness: 2,
                                        color: lightBlueColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                              child: Container(
                                width: 35.w,
                                height: 35.h,
                                decoration: BoxDecoration(
                                  color: Color(0xFF39D2C0),
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      2, 2, 2, 2),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.asset(
                                      'assets/icon/${itemjenispajak}.png',
                                      width: 90.w,
                                      height: 90.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 10, 0, 1),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 300.w,
                                          height: 20.h,
                                          child: Stack(
                                            children: [
                                              Texts.caption(
                                                  "${item.namaUsaha}"),
                                              Positioned(
                                                right: 1,
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(8, 0, 0, 0),
                                                  child: Container(
                                                    color: Colors.white,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Periode ',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Outfit',
                                                            color: Color(
                                                                0xFF39D2C0),
                                                            fontSize: 10.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            height: 0.5,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${item.masaPajak}',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Outfit',
                                                            color: Color(
                                                                0xFF39D2C0),
                                                            fontSize: 12.5.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            height: 1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 4, 0, 0),
                                      child: item.status == "0"
                                          ? Text(
                                              'Belum di Verifikasi Petugas.',
                                              maxLines: 2,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                fontFamily: 'Outfit',
                                                color: Color.fromARGB(
                                                    255, 233, 175, 1),
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            )
                                          : item.status == "1" &&
                                                  item.nomorKohir == "0"
                                              ? Texts.captionSm(
                                                  "Segera Ditetapkan di Aplikasi Simpatda",
                                                  color: Color.fromARGB(
                                                      255, 192, 87, 87),
                                                )
                                              : item.tanggalLunas != "0"
                                                  ? Icon(
                                                      Icons.check_box,
                                                      color: Color.fromARGB(
                                                          255, 108, 226, 112),
                                                      size: 18.6.w,
                                                    )
                                                  : Icon(
                                                      Icons
                                                          .check_box_outline_blank,
                                                      color: Color.fromARGB(
                                                          255, 108, 226, 112),
                                                      size: 18.6.w,
                                                    ),
                                    ),
                                    Divider(height: 5.h),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: item.status == "0"
                                                ? Text(
                                                    "Rp. xxx",
                                                    maxLines: 1,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        fontFamily: 'Outfit',
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: MainColor),
                                                  )
                                                : Text(
                                                    NumberFormat.currency(
                                                            locale: 'id',
                                                            symbol: 'Rp. ',
                                                            decimalDigits: 0)
                                                        .format(int.parse(item
                                                            .pajak
                                                            .toString())),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        fontFamily: 'Outfit',
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: MainColor),
                                                  ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Lihat Detail',
                                                style: TextStyle(
                                                  fontFamily: 'Outfit',
                                                  color: textLink,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Icon(
                                                Icons.chevron_right_rounded,
                                                color: Color(0xFF57636C),
                                                size: 24,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
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
            });
      },
    );
  }
}
