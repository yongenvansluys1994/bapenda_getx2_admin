import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan_detail/controllers/pelaporan_history_controller.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan_detail/views/histori_pajak.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan_detail/views/histori_pajak2.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan_detail/views/histori_pajak3.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan_detail/views/histori_pajak4.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan_detail/views/histori_pajak5.dart';
import 'package:bapenda_getx2_admin/app/routes/app_pages.dart';
import 'package:bapenda_getx2_admin/widgets/custom_appbar.dart';
import 'package:bapenda_getx2_admin/widgets/easythrottle.dart';
import 'package:bapenda_getx2_admin/widgets/getdialog.dart';
import 'package:bapenda_getx2_admin/widgets/shimmer.dart';
import 'package:bapenda_getx2_admin/widgets/snackbar.dart';
import 'package:bapenda_getx2_admin/widgets/texts.dart';
import 'package:bapenda_getx2_admin/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../controllers/pendataan_detail_controller.dart';

class PendataanDetailView extends GetView<PendataanDetailController> {
  const PendataanDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            title: "Detail Pendataan/Pelaporan", leading: true, isLogin: true),
        body: GestureDetector(
          child: PageView(
            controller: controller.pageController,
            onPageChanged: (int page) {
              controller.currentPage = page;
              controller.swipePage();
            },
            children: [
              Stack(
                children: [
                  GetBuilder<PendataanDetailController>(
                    init: PendataanDetailController(),
                    builder: (controller) {
                      return SingleChildScrollView(
                          child: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              constraints: BoxConstraints(
                                maxWidth: Get.width * 0.95,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14.w),
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
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 7.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [Texts.body2("Jenis Pajak")],
                                    ),
                                    controller.status == "0"
                                        ? Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.r),
                                            child: Container(
                                              child: InputDecorator(
                                                decoration: InputDecoration(
                                                  enabled: false,
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(
                                                          8, 4, 0, 1),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  hintText: '',
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
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton(
                                                    dropdownColor:
                                                        Colors.blueGrey[100],
                                                    isDense: true,
                                                    isExpanded: true,
                                                    iconSize: 32,
                                                    hint: Text(
                                                      "Pilih Jenis Pajak",
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15.sp,
                                                        fontFamily:
                                                            "verdana_regular",
                                                      ),
                                                    ),
                                                    items: controller
                                                        .data_dropdown
                                                        .map((item) {
                                                      return new DropdownMenuItem(
                                                        child: Container(
                                                            width: 300.w,
                                                            color: item['suggest'] ==
                                                                    true
                                                                ? Colors.red
                                                                : Colors
                                                                    .transparent,
                                                            child: new Text(
                                                                item['label'])),
                                                        value: item['value']
                                                            .toString(),
                                                      );
                                                    }).toList(),
                                                    onChanged: (newVal) {
                                                      controller
                                                          .updateValueDropdown(
                                                              "${newVal}");
                                                    },
                                                    value: controller
                                                                .valuejenispajak ==
                                                            ""
                                                        ? null
                                                        : controller
                                                            .valuejenispajak,
                                                  ),
                                                ),
                                              ),
                                              decoration:
                                                  BoxDecoration(boxShadow: [
                                                BoxShadow(
                                                  color: Colors.red,
                                                  blurRadius: 5,
                                                ),
                                              ]),
                                            ),
                                          )
                                        : Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Texts.body1(
                                                  "${controller.kode_rekening}",
                                                  isBold: true),
                                              SizedBox(width: 2.w),
                                              SizedBox(
                                                width: 220.w,
                                                child: Texts.body1(
                                                    "${controller.nama_rekening}",
                                                    isBold: true),
                                              ),
                                            ],
                                          ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'NPWPD',
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            color:
                                                Color.fromARGB(255, 71, 80, 90),
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          '${controller.npwpd}',
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            color:
                                                Color.fromARGB(255, 71, 80, 90),
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.h),
                                    Center(
                                      child: Container(
                                        width: 250.w,
                                        height: Get.height * 0.055,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 249, 249, 249),
                                          borderRadius:
                                              BorderRadius.circular(20.w),
                                          border: Border.all(
                                            color: Color(0xFFF1F4F8),
                                            width: 2,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 2,
                                              blurRadius: 3,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        padding: EdgeInsets.all(0.5.w),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 4, 0, 4),
                                                  child: Text(
                                                    'Periode Awal',
                                                    style: TextStyle(
                                                      fontFamily: 'Outfit',
                                                      color: Color.fromARGB(
                                                          255, 71, 80, 90),
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      height:
                                                          Get.height * 0.00055,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 4, 0, 4),
                                                  child: Text(
                                                    '${controller.masa_pajak2}',
                                                    style: TextStyle(
                                                      fontFamily: 'Outfit',
                                                      color: Color.fromARGB(
                                                          255, 71, 80, 90),
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      height:
                                                          Get.height * 0.00055,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 4, 0, 4),
                                                  child: Text(
                                                    'Periode Akhir',
                                                    style: TextStyle(
                                                      fontFamily: 'Outfit',
                                                      color: Color.fromARGB(
                                                          255, 71, 80, 90),
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      height:
                                                          Get.height * 0.00055,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 4, 0, 4),
                                                  child: Text(
                                                    '${controller.masa_akhir2}',
                                                    style: TextStyle(
                                                      fontFamily: 'Outfit',
                                                      color: Color.fromARGB(
                                                          255, 71, 80, 90),
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      height:
                                                          Get.height * 0.00055,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      height: 24,
                                      thickness: 2,
                                      color: Color(0xFFF1F4F8),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 44.w,
                                          height: 44.h,
                                          decoration: BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 71, 80, 90),
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 4,
                                                color: Color(0x2B202529),
                                                offset: Offset(0, 2),
                                              )
                                            ],
                                            shape: BoxShape.circle,
                                          ),
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              color: Colors.white,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 0, 0, 0),
                                            child: Text(
                                              controller.status == "0"
                                                  ? 'Menunggu Verifikasi'
                                                  : controller.dataArgument
                                                                  .nomorKohir ==
                                                              "0" &&
                                                          controller.status ==
                                                              "1"
                                                      ? 'Menunggu Ditetapkan di Aplikasi Simpatda'
                                                      : controller.dataArgument
                                                                  .tanggalLunas !=
                                                              "0"
                                                          ? 'Lunas'
                                                          : 'Menunggu Pembayaran',
                                              style: TextStyle(
                                                fontFamily: 'Outfit',
                                                color: Color.fromARGB(
                                                    255, 71, 80, 90),
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_right_rounded,
                                          color:
                                              Color.fromARGB(255, 71, 80, 90),
                                          size: 24,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.h),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 44.w,
                                          height: 44.h,
                                          decoration: BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 71, 80, 90),
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 4,
                                                color: Color(0x2B202529),
                                                offset: Offset(0, 2),
                                              )
                                            ],
                                            shape: BoxShape.circle,
                                          ),
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Text(
                                            '2',
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              color: Colors.white,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(16, 0, 0, 0),
                                              child: InkWell(
                                                onTap: () {
                                                  controller.bukti!.contains(
                                                          new RegExp(
                                                              "\.(jpg|jpeg|png)"))
                                                      ? Get.toNamed(
                                                          Routes.DETAIL_SCREEN,
                                                          arguments:
                                                              controller.bukti)
                                                      : controller.OpenFile(
                                                          controller.bukti);
                                                },
                                                child: Text(
                                                  'Lihat File Bukti LHP',
                                                  style: TextStyle(
                                                    fontFamily: 'Outfit',
                                                    color: Color.fromARGB(
                                                        255, 71, 80, 90),
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              )),
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_right_rounded,
                                          color:
                                              Color.fromARGB(255, 71, 80, 90),
                                          size: 24,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              width: double.infinity,
                              constraints: BoxConstraints(
                                maxWidth: Get.width * 0.95,
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
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 230, 230, 230),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.w),
                                          topRight: Radius.circular(10.w)),
                                    ),
                                    height: Get.height * 0.07,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(4.w),
                                          child: Container(
                                            width: 145.w,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Texts.captionSm(
                                                  "NIK",
                                                  isBold: true,
                                                  color: Color.fromARGB(
                                                      255, 71, 80, 90),
                                                ),
                                                Texts.captionSm(
                                                  "${controller.nik_user}",
                                                  color: Color.fromARGB(
                                                      255, 59, 59, 59),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 0.5.w),
                                        Padding(
                                          padding: EdgeInsets.all(4.w),
                                          child: Container(
                                            width: 145.w,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Texts.captionSm(
                                                  "NAMA",
                                                  isBold: true,
                                                  color: Color.fromARGB(
                                                      255, 71, 80, 90),
                                                ),
                                                Texts.captionSm(
                                                  "${controller.nama_usaha}",
                                                  color: Color.fromARGB(
                                                      255, 59, 59, 59),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    height: Get.height * 0.07,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8.r),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(4.w),
                                            child: Container(
                                              width: 310.w,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Texts.captionSm(
                                                    "ALAMAT",
                                                    isBold: true,
                                                    color: Color.fromARGB(
                                                        255, 71, 80, 90),
                                                  ),
                                                  Texts.captionSm(
                                                    "${controller.alamat_usaha}",
                                                    color: Color.fromARGB(
                                                        255, 59, 59, 59),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 230, 230, 230),
                                    ),
                                    height: Get.height * 0.07,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(4.w),
                                          child: Container(
                                            width: 145.w,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Texts.captionSm(
                                                  "KECAMATAN",
                                                  isBold: true,
                                                  color: Color.fromARGB(
                                                      255, 71, 80, 90),
                                                ),
                                                Texts.captionSm(
                                                  "${controller.kec_usaha}",
                                                  color: Color.fromARGB(
                                                      255, 59, 59, 59),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 0.5.w),
                                        Padding(
                                          padding: EdgeInsets.all(4.w),
                                          child: Container(
                                            width: 145.w,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Texts.captionSm(
                                                  "KELURAHAN",
                                                  isBold: true,
                                                  color: Color.fromARGB(
                                                      255, 71, 80, 90),
                                                ),
                                                Texts.captionSm(
                                                  "${controller.kel_usaha}",
                                                  color: Color.fromARGB(
                                                      255, 59, 59, 59),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(4.w),
                                          bottomRight: Radius.circular(4.w)),
                                    ),
                                    height: Get.height * 0.07,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(4.w),
                                          child: Container(
                                            width: 145.w,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Texts.captionSm(
                                                  "RT",
                                                  isBold: true,
                                                  color: Color.fromARGB(
                                                      255, 71, 80, 90),
                                                ),
                                                Texts.captionSm(
                                                  "${controller.rt_usaha}",
                                                  color: Color.fromARGB(
                                                      255, 59, 59, 59),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 0.5.w),
                                        Padding(
                                          padding: EdgeInsets.all(4.w),
                                          child: Container(
                                            width: 145.w,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Texts.captionSm(
                                                  "KOTA",
                                                  isBold: true,
                                                  color: Color.fromARGB(
                                                      255, 71, 80, 90),
                                                ),
                                                Texts.captionSm(
                                                  "${controller.kota_usaha}",
                                                  color: Color.fromARGB(
                                                      255, 59, 59, 59),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              width: double.infinity,
                              constraints: BoxConstraints(
                                maxWidth: Get.width * 0.95,
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
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 60,
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF1F4F8),
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 7.w),
                                    child: Text(
                                      'Perhitungan Pajak',
                                      style: TextStyle(
                                        fontFamily: 'Outfit',
                                        color: Color.fromARGB(255, 71, 80, 90),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    height: 15,
                                    thickness: 2,
                                    color: Color(0xFFF1F4F8),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(controller
                                                      .dataArgument.status ==
                                                  "0"
                                              ? "assets/images/putih_polos.png"
                                              : controller.dataArgument
                                                          .tanggalLunas !=
                                                      "0"
                                                  ? "assets/images/lunas.png"
                                                  : "assets/images/belum_bayar.png"),
                                          fit: BoxFit.cover),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 0,
                                          color: Color(0xFFE0E3E7),
                                          offset: Offset(0, 1),
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24, 5, 24, 4),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                'Periode Pelaporan Pajak : ',
                                                style: TextStyle(
                                                  fontFamily: 'Roboto Mono',
                                                  color: Color.fromARGB(
                                                      255, 71, 80, 90),
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24, 4, 24, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'OMSET PENDAPATAN/BRUTO',
                                                style: TextStyle(
                                                  fontFamily: 'Roboto Mono',
                                                  color: Color.fromARGB(
                                                      255, 52, 59, 66),
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Text(
                                                '${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(controller.pendapatan)}',
                                                style: TextStyle(
                                                  fontFamily: 'Roboto Mono',
                                                  color: Color.fromARGB(
                                                      255, 52, 59, 66),
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24, 4, 24, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'TARIF PERSEN (%)',
                                                style: TextStyle(
                                                  fontFamily: 'Roboto Mono',
                                                  color: Color.fromARGB(
                                                      255, 52, 59, 66),
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Text(
                                                controller.hitungPajak == false
                                                    ? ''
                                                    : '${controller.tarif_persen}',
                                                style: TextStyle(
                                                  fontFamily: 'Roboto Mono',
                                                  color: Color.fromARGB(
                                                      255, 52, 59, 66),
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          height: 3.w,
                                          thickness: 0.2.w,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24, 4, 24, 24),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    'JUMLAH PAJAK',
                                                    style: TextStyle(
                                                      fontFamily: 'Outfit',
                                                      color: Color.fromARGB(
                                                          255, 52, 59, 66),
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                controller.hitungPajak == false
                                                    ? ''
                                                    : '${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(controller.pajak)}',
                                                style: TextStyle(
                                                  fontFamily: 'Outfit',
                                                  color: Color.fromARGB(
                                                      255, 52, 59, 66),
                                                  fontSize: 17.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            controller.dataArgument.tanggalLunas != "0"
                                ? detailTransaksi(controller: controller)
                                : SizedBox(),
                            controller.dataArgument.status == "0" &&
                                    controller.authModel_no_hp == "admin"
                                ? Column(
                                    children: [
                                      controller.dataArgument.jenispajak ==
                                              "HOTEL"
                                          ? Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.sp),
                                              child: Row(
                                                children: <Widget>[
                                                  controller.isChecked == false
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            controller
                                                                .CheckSecurity(
                                                                    true); //ketika diklik akan merubah ischecked menjadi true
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .check_box_outline_blank,
                                                            color:
                                                                lightBlueColor,
                                                            size: 22.w,
                                                          ),
                                                        )
                                                      : GestureDetector(
                                                          onTap: () {
                                                            controller
                                                                .CheckSecurity(
                                                                    false); //ketika diklik akan merubah ischecked menjadi false
                                                          },
                                                          child: Icon(
                                                            Icons.check_box,
                                                            color:
                                                                lightBlueColor,
                                                            size: 22.w,
                                                          ),
                                                        ),
                                                  Texts.captionSm(
                                                      "Mengnonaktifkan Security Double SPT di Simpatda"),
                                                ],
                                              ),
                                            )
                                          : SizedBox(),
                                      SizedBox(
                                        width: 150.w,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              if (controller.hitungPajak ==
                                                  false) {
                                                RawSnackbar_top(
                                                    message:
                                                        "Tentukan Jenis Pajak terlebih dahulu",
                                                    kategori: "warning",
                                                    duration: 2);
                                              } else {
                                                getDefaultDialog().onConfirm(
                                                  title:
                                                      "Setujui Pelaporan ini?",
                                                  desc: controller.isChecked ==
                                                          true
                                                      ? "Anda Menyalakan Fitur Nonaktif Security Double SPT, Apakah anda setuju untuk memverifikasi?"
                                                      : "Pastikan anda telah memeriksa data dengan benar",
                                                  kategori: "warning",
                                                  handler: () {
                                                    easyThrottle(
                                                      handler: () {
                                                        controller
                                                            .VerifLaporan();
                                                      },
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(lightBlueColor),
                                            ),
                                            child: Texts.caption(
                                                "Verif Laporan Pajak")),
                                      ),
                                      SizedBox(
                                        width: 160.w,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              getDefaultDialog().onConfirm(
                                                title: "Tolak Pelaporan ini?",
                                                desc:
                                                    "Jika anda melakukan penolakan, Pelaporan Pajak ini akan terhapus permanen dari sistem, dan Wajib pajak akan menerima pemberitahuan penolakannya.",
                                                kategori: "warning",
                                                handler: () {
                                                  easyThrottle(
                                                    handler: () {
                                                      controller.Dikembalikan();
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      Color.fromARGB(
                                                          255, 247, 207, 30)),
                                            ),
                                            child: Text(
                                              'Dikembalikan/Ditolak',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            )),
                                      )
                                    ],
                                  )
                                : controller.dataArgument.status == "1" &&
                                        controller.dataArgument.nomorKohir ==
                                            "0"
                                    ? SizedBox()
                                    : SizedBox(),
                            SizedBox(height: 10.h),
                            // riwayatVerifikasi(controller: controller),
                          ],
                        ),
                      ));
                    },
                  ),
                  swipeLeft(controller: controller),
                ],
              ),
              HistoryPembayaran(
                  idWajibPajak: controller.dataArgument.idWajibPajak,
                  controller1: controller),
            ],
          ),
        ));
  }
}

class detailTransaksi extends StatelessWidget {
  final PendataanDetailController controller;

  detailTransaksi({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxWidth: Get.width * 0.95,
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
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 4,
                decoration: BoxDecoration(
                  color: Color(0xFFF1F4F8),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.w),
            child: Text(
              'Detail Pembayaran',
              style: TextStyle(
                fontFamily: 'Outfit',
                color: Color.fromARGB(255, 71, 80, 90),
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Divider(
            height: 15,
            thickness: 2,
            color: Color(0xFFF1F4F8),
          ),
          Container(
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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 5, 24, 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Metode Pembayaran : ${controller.metodePembayaran == "qris" ? "QRIS" : controller.metodePembayaran == "va" ? "Virtual Account" : "Teller atau Lainnya"}',
                        style: TextStyle(
                          fontFamily: 'Roboto Mono',
                          color: Color.fromARGB(255, 71, 80, 90),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                controller.isLoadingPembayaran == true
                    ? ShimmerWidget.Items1()
                    : controller.metodePembayaran == "qris"
                        ? dataQRIS(controller: controller)
                        : controller.metodePembayaran == "va"
                            ? dataVA(controller: controller)
                            : dataLainnya(controller: controller)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class dataQRIS extends StatelessWidget {
  final PendataanDetailController controller;
  const dataQRIS({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Texts.captionSm(
                  "No. Invoice",
                  color: Color.fromARGB(255, 52, 59, 66),
                ),
                Texts.captionSm(
                  "${controller.responsePembayaran['invoice_no']}",
                  color: Color.fromARGB(255, 52, 59, 66),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Texts.captionSm(
                  "Kode Tagihan",
                  color: Color.fromARGB(255, 52, 59, 66),
                ),
                Texts.captionSm(
                  "${controller.responsePembayaran['kd_tagihan']}",
                  color: Color.fromARGB(255, 52, 59, 66),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Texts.captionSm(
                  "Tgl Transaksi",
                  color: Color.fromARGB(255, 52, 59, 66),
                ),
                Texts.captionSm(
                  "${controller.responsePembayaran['trx_date']}",
                  color: Color.fromARGB(255, 52, 59, 66),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Texts.captionSm(
                  "Nama Pengirim",
                  color: Color.fromARGB(255, 52, 59, 66),
                ),
                Texts.captionSm(
                  "${controller.responsePembayaran['customer_name']}",
                  maxLines: 1,
                  color: Color.fromARGB(255, 52, 59, 66),
                ),
              ],
            ),
          ),
          Divider(
            height: 3.w,
            thickness: 0.2.w,
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 24),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Texts.captionSm(
                  "Nominal",
                  color: Color.fromARGB(255, 52, 59, 66),
                ),
                Texts.captionSm(
                  "${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(double.parse(controller.responsePembayaran['bruto_amount']))}",
                  maxLines: 1,
                  color: Color.fromARGB(255, 52, 59, 66),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class dataVA extends StatelessWidget {
  final PendataanDetailController controller;
  const dataVA({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Texts.captionSm(
                  "No. Referensi",
                  color: Color.fromARGB(255, 52, 59, 66),
                ),
                Texts.captionSm(
                  "${controller.responsePembayaran['data']['reference']}",
                  color: Color.fromARGB(255, 52, 59, 66),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Texts.captionSm(
                  "No. VA",
                  color: Color.fromARGB(255, 52, 59, 66),
                ),
                Texts.captionSm(
                  "${controller.responsePembayaran['data']['number']}",
                  color: Color.fromARGB(255, 52, 59, 66),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Texts.captionSm(
                  "Tgl Transaksi",
                  color: Color.fromARGB(255, 52, 59, 66),
                ),
                Texts.captionSm(
                  "${controller.responsePembayaran['data']['trx_date']}",
                  color: Color.fromARGB(255, 52, 59, 66),
                ),
              ],
            ),
          ),
          Divider(
            height: 3.w,
            thickness: 0.2.w,
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 24),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Texts.captionSm(
                  "Nominal",
                  color: Color.fromARGB(255, 52, 59, 66),
                ),
                Texts.captionSm(
                  "${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(double.parse(controller.responsePembayaran['data']['amount']))}",
                  maxLines: 1,
                  color: Color.fromARGB(255, 52, 59, 66),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class dataLainnya extends StatelessWidget {
  final PendataanDetailController controller;
  const dataLainnya({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Texts.captionSm(
                  "No. Kohir",
                  color: Color.fromARGB(255, 52, 59, 66),
                ),
                Texts.captionSm(
                  "${controller.dataArgument.nomorKohir}",
                  color: Color.fromARGB(255, 52, 59, 66),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Texts.captionSm(
                  "No. SPT",
                  color: Color.fromARGB(255, 52, 59, 66),
                ),
                Texts.captionSm(
                  "${controller.dataArgument.nomorSpt}",
                  color: Color.fromARGB(255, 52, 59, 66),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Texts.captionSm(
                  "Tgl Lunas",
                  color: Color.fromARGB(255, 52, 59, 66),
                ),
                Texts.captionSm(
                  "${controller.dataArgument.tanggalLunas}",
                  color: Color.fromARGB(255, 52, 59, 66),
                ),
              ],
            ),
          ),
          Divider(
            height: 3.w,
            thickness: 0.2.w,
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 24),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Texts.captionSm(
                  "Nominal",
                  color: Color.fromARGB(255, 52, 59, 66),
                ),
                Texts.captionSm(
                  "${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(double.parse(controller.dataArgument.pajak))}",
                  maxLines: 1,
                  color: Color.fromARGB(255, 52, 59, 66),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class swipeLeft extends StatelessWidget {
  final PendataanDetailController controller;
  const swipeLeft({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PendataanDetailController>(
      init: PendataanDetailController(),
      builder: (controller) {
        return Positioned(
          right: 0,
          bottom: 185.r,
          child: AnimatedOpacity(
            curve: Curves.linear,
            opacity: controller.isVisibleSwipe ? 1.0 : 0.0,
            duration: Duration(milliseconds: 700),
            child: Container(
              height: 110.h,
              width: 130.w,
              child: Stack(
                children: [
                  Positioned(
                    top: 30.h,
                    right: 0,
                    child: Container(
                      height: Get.height * 0.055,
                      width: 120.w,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: gradientColor),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(48),
                            bottomLeft: Radius.circular(48),
                            bottomRight: Radius.circular(7),
                            topRight: Radius.circular(7),
                          ),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 7,
                                offset: Offset(5, 5),
                                color: lightBlueColor.withOpacity(0.4)),
                            BoxShadow(
                                blurRadius: 7,
                                offset: Offset(-2, -2),
                                color: lightBlueColor.withOpacity(0.4))
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Texts.captionSm("Riwayat",
                                  textAlign: TextAlign.right,
                                  color: Colors.white),
                              Texts.captionSm("Pembayaran ",
                                  textAlign: TextAlign.right,
                                  color: Colors.white),
                            ],
                          ),
                          SizedBox(
                            width: 3.w,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 7.r,
                    left: 7.r,
                    child: SizedBox(
                        child: Lottie.asset('assets/lottie/swipeleft.json',
                            fit: BoxFit.fill, height: 65.h)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class HistoryPembayaran extends StatelessWidget {
  final PendataanDetailController controller1;
  final String idWajibPajak;
  const HistoryPembayaran(
      {super.key, required this.idWajibPajak, required this.controller1});

  @override
  Widget build(BuildContext context) {
    double initialX = 0.0;
    return GetBuilder<PelaporanHistoryController>(
        init: PelaporanHistoryController(Get.find<Api>()),
        builder: (controller) {
          final List<Tab> Tabs = <Tab>[
            //5 tahun terakhir
            Tab(
              child: Text(
                "${controller.tahunhistory[0]}",
                style: TextStyle(fontSize: 11.sp), // Ubah ukuran font di sini
              ),
            ),
            Tab(
              child: Text(
                "${controller.tahunhistory[1]}",
                style: TextStyle(fontSize: 11.sp), // Ubah ukuran font di sini
              ),
            ),
            Tab(
              child: Text(
                "${controller.tahunhistory[2]}",
                style: TextStyle(fontSize: 11.sp), // Ubah ukuran font di sini
              ),
            ),
            Tab(
              child: Text(
                "${controller.tahunhistory[3]}",
                style: TextStyle(fontSize: 11.sp), // Ubah ukuran font di sini
              ),
            ),
            Tab(
              child: Text(
                "${controller.tahunhistory[4]}",
                style: TextStyle(fontSize: 11.sp), // Ubah ukuran font di sini
              ),
            ),
          ];
          return SingleChildScrollView(
            child: DefaultTabController(
              length: 5, // Number of tabs
              child: Builder(builder: (BuildContext context) {
                final TabController tabController =
                    DefaultTabController.of(context);
                return Column(
                  children: [
                    TabBar(
                      labelColor: lightBlueColor,
                      unselectedLabelColor: MainColor,
                      indicatorColor: lightBlueColor,
                      //isScrollable: true,
                      tabs: Tabs,
                    ),
                    SizedBox(
                      height: 1280.h, // Adjust the height as needed
                      child: Listener(
                        onPointerDown: (PointerDownEvent event) {
                          initialX = event.position.dx;
                        },
                        onPointerUp: (PointerUpEvent event) {
                          double dx = event.position.dx - initialX;
                          if (dx > 0) {
                            // If dx is negative, it's a swipe left
                            if (tabController.index == 0) {
                              controller1.pageController.previousPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            }
                          }
                        },
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            HistoryPajak(id_wajib_pajak: idWajibPajak),
                            HistoryPajak2(id_wajib_pajak: idWajibPajak),
                            HistoryPajak3(id_wajib_pajak: idWajibPajak),
                            HistoryPajak4(id_wajib_pajak: idWajibPajak),
                            HistoryPajak5(id_wajib_pajak: idWajibPajak),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          );
        });
  }
}

class riwayatVerifikasi extends StatelessWidget {
  final PendataanDetailController controller;

  riwayatVerifikasi({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxWidth: Get.width * 0.95,
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
        child: Align(
          alignment: AlignmentDirectional(0, 0),
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              maxWidth: Get.width * 0.95,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Color(0xFFE0E3E7),
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                          child: Wrap(
                            spacing: 0,
                            runSpacing: 4,
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            direction: Axis.horizontal,
                            runAlignment: WrapAlignment.start,
                            verticalDirection: VerticalDirection.down,
                            clipBehavior: Clip.none,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 4, 0),
                                child: Text(
                                  'Riwayat Verifikasi',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color.fromARGB(255, 71, 80, 90),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 4, 0),
                                  child: Container(
                                    width: 250.w,
                                    padding: EdgeInsets.all(8.0),
                                    child: Text.rich(
                                      TextSpan(
                                        text:
                                            'Pelaporan Pajak Telah di verifikasi oleh : ',
                                        style: TextStyle(fontSize: 13.sp),
                                        children: [
                                          TextSpan(
                                            text: 'Dia Novita Sari',
                                            style: TextStyle(
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                      softWrap: true,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 32,
                        width: 80.w,
                        decoration: BoxDecoration(
                          color: Color(0xFFF1F4F8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                          child: Text(
                            '${DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now())}',
                            style: TextStyle(fontSize: 11.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
