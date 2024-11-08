import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/app/modules/laporan_bayaroffline/controllers/laporan_bayaroffline_controller.dart';
import 'package:bapenda_getx2_admin/widgets/custom_appbar.dart';
import 'package:bapenda_getx2_admin/widgets/easythrottle.dart';
import 'package:bapenda_getx2_admin/widgets/shimmer.dart';
import 'package:bapenda_getx2_admin/widgets/texts.dart';
import 'package:bapenda_getx2_admin/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LaporanBayarOfflineView extends GetView<LaporanBayarOfflineController> {
  const LaporanBayarOfflineView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Laporan Pembayaran Offline/Teller",
        leading: true,
        isLogin: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GetBuilder<LaporanBayarOfflineController>(
                init: LaporanBayarOfflineController(Get.find<Api>()),
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
                                              isBold: true,
                                              color: Colors.white),
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
                                                  style: TextStyle(
                                                      fontSize: 14.sp),
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
                                              isBold: true,
                                              color: Colors.white),
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
                                                  style: TextStyle(
                                                      fontSize: 14.sp),
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
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
                                              if (controller.selectedDate == null ||
                                                  controller.selectedDate_akhir ==
                                                      null) {
                                                EasyLoading.showError(
                                                    "Masa Pajak harus dipilih");
                                              } else {
                                                easyThrottle(
                                                  handler: () {
                                                    controller.populateDatalist();
                                                    // controller.simpanLaporan();
                                                  },
                                                );
                                              }
                                            }),
                                      ),
                                    ),
                                     SizedBox(width: 5.h),
                                    GetBuilder<LaporanBayarOfflineController>(
                init: LaporanBayarOfflineController(Get.find<Api>()),
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
                                    easyThrottle(
                                      handler: () {
                                        controller.cetakLHP();
                                      },
                                    );
                                  }),
                            ),
                          ),
                        )
                      : SizedBox();
                })
                                  ],
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
            Divider(),
            GetBuilder<LaporanBayarOfflineController>(
              init: LaporanBayarOfflineController(Get.find<Api>()),
              builder: (controller) {
                if (controller.isLoading) {
                  return ShimmerWidget.Items1();
                }
                if (controller.isEmpty) {
                  return Center(child: Texts.body1("Data tidak ditemukan."));
                }
                double totalDibayar = controller.datalist.fold(0, (sum, item) => sum + item.telahDibayar);

return SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: DataTable(
    columns: [
      DataColumn(
        label: Text(
          'TGL \nPENETAPAN',
          textAlign: TextAlign.center,
        ),
      ),
      DataColumn(label: Text('JATUH TEMPO')),
      DataColumn(label: Text('KODE REKENING')),
      DataColumn(
        label: Text(
          'NAMA \nREKENING',
          textAlign: TextAlign.center,
        ),
      ),
      DataColumn(label: Text('NO KOHIR')),
      DataColumn(label: Text('NAMA WP')),
      DataColumn(label: Text('NPWPD')),
      DataColumn(label: Text('PAJAK')),
      DataColumn(label: Text('DENDA')),
      DataColumn(label: Text('DIBAYAR')),
      DataColumn(label: Text('MASA PAJAK')),
      DataColumn(label: Text('METODE BAYAR')),
    ],
    rows: [
      // Baris data dari controller.datalist
      ...controller.datalist.map((dataItem) {
        return DataRow(cells: [
          DataCell(Text(dataItem.tglPenetapan)),
          DataCell(Text(dataItem.batasBayar)),
          DataCell(Text(dataItem.kodeRekening)),
          DataCell(Container(
            width: Get.width * 0.5,
            constraints: BoxConstraints(maxWidth: 200),
            child: Text("${dataItem.namaRekening}", overflow: TextOverflow.ellipsis, maxLines: 3),
          )),
          DataCell(Text(dataItem.nomorKohir)),
          DataCell(Container(
            width: Get.width * 0.5,
            constraints: BoxConstraints(maxWidth: 200),
            child: Text("${dataItem.namaWp}", overflow: TextOverflow.ellipsis, maxLines: 3),
          )),
          DataCell(Text(dataItem.npwpd)),
          DataCell(Text(
            "${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(dataItem.jumlahPajak)}",
          )),
          DataCell(Text(
            "${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(dataItem.denda)}",
          )),
          DataCell(Text(
            "${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(dataItem.telahDibayar)}",
          )),
          DataCell(Text(dataItem.masaPajak)),
          DataCell(Text(dataItem.uraianH2H)),
        ]);
      }).toList(),
      // Baris Jumlah total
      DataRow(cells: [
        DataCell(Text('TOTAL',style: TextStyle(fontWeight: FontWeight.bold),)), // Kosong untuk kolom TGL PENETAPAN
        DataCell(Text('')), // Kosong untuk kolom JATUH TEMPO
        DataCell(Text('')), // Kosong untuk kolom KODE REKENING
        DataCell(Text('')), // Kosong untuk kolom NAMA REKENING
        DataCell(Text('')), // Kosong untuk kolom NO KOHIR
        DataCell(Text('')), // Kosong untuk kolom NAMA WP
        DataCell(Text('')), // Kosong untuk kolom NPWPD
        DataCell(Text('')), // Kosong untuk kolom PAJAK
        DataCell(Text('')), // Kosong untuk kolom DENDA
        DataCell(Text(
          "Rp. ${NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0).format(totalDibayar)}", // Menampilkan total
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        DataCell(Text('')), // Kosong untuk kolom MASA PAJAK
        DataCell(Text('')), // Kosong untuk kolom METODE BAYAR
      ]),
    ],
  ),
);

              },
            ),
            SizedBox(height: 5.h),
            
          ],
        ),
      ),
    );
  }
}
