import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/widgets/custom_appbar.dart';
import 'package:bapenda_getx2_admin/widgets/easythrottle.dart';
import 'package:bapenda_getx2_admin/widgets/nodata.dart';
import 'package:bapenda_getx2_admin/widgets/shimmer.dart';
import 'package:bapenda_getx2_admin/widgets/texts.dart';
import 'package:bapenda_getx2_admin/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/laporan_daftaruser_controller.dart';

class LaporanDaftaruserView extends GetView<LaporanDaftaruserController> {
  const LaporanDaftaruserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Data Wajib Pajak Termuktahir", leading: true, isLogin: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GetBuilder<LaporanDaftaruserController>(
                init: LaporanDaftaruserController(Get.find<Api>()),
                builder: (controller) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: gradientColor),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Texts.caption("Masa Awal",
                                              isBold: true, color: Colors.white),
                                        ),
                                        Stack(
                                          children: [
                                            TextFormField(
                                              readOnly: true,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        10, 30, 10, 0),
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
                                              onTap: () {
                                                controller
                                                    .date_picker_awal(context);
                                              },
                                            ),
                                            GestureDetector(
                                              child: Container(
                                                child: Text(
                                                  controller.FinalDate == null
                                                      ? ""
                                                      : "${controller.FinalDate}",
                                                  style:
                                                      TextStyle(fontSize: 14.sp),
                                                ),
                                                margin: EdgeInsets.only(
                                                    left: 10, top: 13),
                                              ),
                                              onTap: () {
                                                controller
                                                    .date_picker_awal(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Texts.caption("Masa Akhir",
                                              isBold: true, color: Colors.white),
                                        ),
                                        Stack(
                                          children: [
                                            TextFormField(
                                              readOnly: true,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        10, 30, 10, 0),
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
                                              onTap: () {
                                                controller
                                                    .date_picker_akhir(context);
                                              },
                                            ),
                                            GestureDetector(
                                              child: Container(
                                                child: Text(
                                                  controller.FinalDate_akhir ==
                                                          null
                                                      ? ""
                                                      : "${controller.FinalDate_akhir}",
                                                  style:
                                                      TextStyle(fontSize: 14.sp),
                                                ),
                                                margin: EdgeInsets.only(
                                                    left: 10, top: 13),
                                              ),
                                              onTap: () {
                                                controller
                                                    .date_picker_akhir(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(4),
                              //   child: Texts.caption("Pilih Jenis Pajak",
                              //       isBold: true, color: Colors.white),
                              // ),
                              // Container(
                              //   child: DropdownButtonFormField<String>(
                              //     decoration: InputDecoration(
                              //       errorStyle: TextStyle(height: 0),
                              //       isDense: true,
                              //       contentPadding:
                              //           EdgeInsets.fromLTRB(10, 30, 10, 0),
                              //       fillColor: Colors.white,
                              //       filled: true,
                              //       hintText: '',
                              //       enabledBorder: const OutlineInputBorder(
                              //         borderSide: BorderSide(
                              //             color: Colors.grey, width: 0.0),
                              //       ),
                              //       focusedBorder: const OutlineInputBorder(
                              //         borderSide: BorderSide(
                              //             color: lightGreenColor, width: 2),
                              //       ),
                              //     ),
                              //     items: [
                              //       DropdownMenuItem(
                              //         child: Text('Item 1'),
                              //         value: '1',
                              //       ),
                              //       DropdownMenuItem(
                              //         child: Text('Item 2'),
                              //         value: '2',
                              //       ),
                              //       DropdownMenuItem(
                              //         child: Text('Item 3'),
                              //         value: '3',
                              //       ),
                              //     ],
                              //     onChanged: (newVal) {
                              //       controller.updateValueDropdown("${newVal}");
                              //     },
                              //     value: controller.valueJenisPajak == ""
                              //         ? null
                              //         : controller.valueJenisPajak,
                              //   ),
                              // ),
                              SizedBox(height: 10.h),
                              Center(
                                child: SizedBox(
                                  height: 40.h,
                                  width: 100.w,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Color.fromARGB(189, 252, 252, 252),
                                        Color.fromARGB(174, 242, 242, 242)
                                      ]),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                        ),
                                        child: Text(
                                          "Cari",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        onPressed: () {
                                           easyThrottle(
                                              handler: () {
                                                controller.populateDatalist();
                                                // controller.simpanLaporan();
                                              },
                                            );
                                          // if (controller.selectedDate == null ||
                                          //     controller.selectedDate_akhir ==
                                          //         null) {
                                          //   EasyLoading.showError(
                                          //       "Masa Pajak harus dipilih");
                                          // } else {
                                          //   // easyThrottle(
                                          //   //   handler: () {
                                          //   //     controller.populateDatalist();
                                          //   //     // controller.simpanLaporan();
                                          //   //   },
                                          //   // );
                                          // }
                                        }),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            Divider(),Text("Warna hijau adalah data yang diperbaharui"),
            GetBuilder<LaporanDaftaruserController>(
                init: LaporanDaftaruserController(Get.find<Api>()),
                builder: (controller) {
                  if (controller.isLoading) {
                    return ShimmerWidget.Items1();
                  }
                  if (controller.isEmpty) {
                    return NoData();
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 15,
                      columns: [
                        DataColumn(label: Text('NPWPD',style: TextStyle(fontSize: 11.sp))),
                        DataColumn(label: Text('NAMA USAHA',style: TextStyle(fontSize: 11.sp))),
                        DataColumn(label: Text('ALAMAT_USAHA',style: TextStyle(fontSize: 11.sp))),
                        DataColumn(label: Text('RT USAHA',style: TextStyle(fontSize: 11.sp))),
                        DataColumn(label: Text('NO.HP USAHA',style: TextStyle(fontSize: 11.sp))),
                        DataColumn(label: Text('EMAIL USAHA',style: TextStyle(fontSize: 11.sp))),
                        DataColumn(label: Text('NAMA PEMILIK',style: TextStyle(fontSize: 11.sp))),
                        DataColumn(label: Text('PEKERJAAN PEMILIK',style: TextStyle(fontSize: 11.sp))),
                        DataColumn(label: Text('NO.HP PEMILIK',style: TextStyle(fontSize: 11.sp))),
                        DataColumn(label: Text('EMAIL PEMILIK',style: TextStyle(fontSize: 11.sp))),
                        DataColumn(label: Text('KOORDINAT',style: TextStyle(fontSize: 11.sp))),
                        DataColumn(label: Text('TGL PERUBAHAN',style: TextStyle(fontSize: 11.sp))),
                      ],
                      rows: controller.datalist.map((dataItem) {
                        return DataRow(cells: [
                           DataCell(Container(width: Get.width * 0.3,height:Get.height * 0.05,child: Align(alignment: Alignment.centerLeft,
 child: Text("${dataItem.npwpd}",style: TextStyle(fontSize: 9.5.sp),)))),
                          DataCell(Container(
                         height:Get.height * 0.05,
                          constraints: BoxConstraints(maxWidth: 200), 
                          child: Align(alignment: Alignment.centerLeft,
child: Text("${dataItem.namaUsaha}",style: TextStyle(fontSize: 9.5.sp), overflow: TextOverflow.ellipsis, maxLines: 3)),
                        )),
                          DataCell(Container(
                          width: Get.width * 0.5, height:Get.height * 0.05,
                          constraints: BoxConstraints(maxWidth: 200), 
                          child: Text("${dataItem.alamatUsaha}",style: TextStyle(fontSize: 9.5.sp), overflow: TextOverflow.ellipsis, maxLines: 3),
                        )),
                         DataCell(Container(
                         height:Get.height * 0.05,
                          constraints: BoxConstraints(maxWidth: 200), 
                          child: Align(alignment: Alignment.centerLeft,
child: Text("${dataItem.rtUsaha}",style: TextStyle(fontSize: 9.5.sp), overflow: TextOverflow.ellipsis, maxLines: 3)),
                        )),
                           DataCell(Container(
                         height:Get.height * 0.05,
                          constraints: BoxConstraints(maxWidth: 200), color:  ( dataItem.nohpUsaha != ' ' && dataItem.nohpUsaha.isNotEmpty) ? Colors.green[300] : null,
                          child: Align(alignment: Alignment.centerLeft,
child: Text("${dataItem.nohpUsaha}",style: TextStyle(fontSize: 9.5.sp), overflow: TextOverflow.ellipsis, maxLines: 3)),
                        )),
                          DataCell(Container(
                         height:Get.height * 0.05,color:  (dataItem.emailUsaha != '-' && dataItem.emailUsaha != ' ' && dataItem.emailUsaha.isNotEmpty) ? Colors.green[300] : null,
                          constraints: BoxConstraints(maxWidth: 200), 
                          child: Align(alignment: Alignment.centerLeft,
child: Text("${dataItem.emailUsaha}",style: TextStyle(fontSize: 9.5.sp), overflow: TextOverflow.ellipsis, maxLines: 3)),
                        )),
                          DataCell(Container(
                         width: Get.width * 0.5,height:Get.height * 0.05,
                          constraints: BoxConstraints(maxWidth: 200), 
                          child: Align(alignment: Alignment.centerLeft,
child: Text("${dataItem.namaPemilik}",style: TextStyle(fontSize: 9.5.sp), overflow: TextOverflow.ellipsis, maxLines: 3)),
                        )),
                          DataCell(Container(
                         width: Get.width * 0.35,height:Get.height * 0.05,color: (dataItem.pekerjaanPemilik != 'Pemilik' && dataItem.pekerjaanPemilik != ' ' && dataItem.pekerjaanPemilik.isNotEmpty) ? Colors.green[300] : null,
                          constraints: BoxConstraints(maxWidth: 200), 
                          child: Align(alignment: Alignment.centerLeft,
child: Text("${dataItem.pekerjaanPemilik}",style: TextStyle(fontSize: 9.5.sp), overflow: TextOverflow.ellipsis, maxLines: 3)),
                        )),
                        DataCell(Container(
                         width: Get.width * 0.35,height:Get.height * 0.05,color:  (dataItem.nohpPemilik != ' ' && dataItem.nohpPemilik.isNotEmpty) ? Colors.green[300] : null,
                          constraints: BoxConstraints(maxWidth: 200), 
                          child: Align(alignment: Alignment.centerLeft,
child: Text("${dataItem.nohpPemilik}",style: TextStyle(fontSize: 9.5.sp), overflow: TextOverflow.ellipsis, maxLines: 3)),
                        )),
                          DataCell(Container(
                         width: Get.width * 0.35,height:Get.height * 0.05,color:  (dataItem.emailUsaha != '-' && dataItem.emailPemilik != ' ' && dataItem.emailPemilik.isNotEmpty) ? Colors.green[300] : null,
                          constraints: BoxConstraints(maxWidth: 200), 
                          child: Align(alignment: Alignment.centerLeft,
child: Text("${dataItem.emailPemilik}",style: TextStyle(fontSize: 9.5.sp), overflow: TextOverflow.ellipsis, maxLines: 3)),
                        )),
                          DataCell(Container(
                         width: Get.width * 0.5,height:Get.height * 0.05,color:  (dataItem.koordinat != ' ' && dataItem.koordinat.isNotEmpty) ? Colors.green[300] : null,
                          constraints: BoxConstraints(maxWidth: 200), 
                          child: Align(alignment: Alignment.centerLeft,
child: Text("${dataItem.koordinat}",style: TextStyle(fontSize: 9.5.sp), overflow: TextOverflow.ellipsis, maxLines: 3)),
                        )),
                        DataCell(Container(
                         width: Get.width * 0.5,height:Get.height * 0.05,color: Colors.green[300],
                          constraints: BoxConstraints(maxWidth: 200), 
                          child: Align(alignment: Alignment.centerLeft,
child: Text("${dataItem.date}",style: TextStyle(fontSize: 9.5.sp), overflow: TextOverflow.ellipsis, maxLines: 3)),
                        )),
                        ]);
                      }).toList(),
                    ),
                  );
                }),
            SizedBox(height: 5.h),
            GetBuilder<LaporanDaftaruserController>(
                init: LaporanDaftaruserController(Get.find<Api>()),
                builder: (controller) {
                  return controller.displayResult == true
                      ? Center(
                          child: SizedBox(
                            height: 40.h,
                            width: 100.w,
                            child: Container(
                              decoration: BoxDecoration(color: Colors.grey),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  child: Text("Cetak PDF"),
                                  onPressed: () {
                                    // easyThrottle(
                                    //   handler: () {
                                    //     controller.cetakLHP();
                                    //   },
                                    // );
                                  }),
                            ),
                          ),
                        )
                      : SizedBox();
                })
          ],
        ),
      ),
    );
  }
}
