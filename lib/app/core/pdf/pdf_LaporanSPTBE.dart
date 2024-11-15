import 'dart:io';

import 'package:bapenda_getx2_admin/app/modules/laporan_spt_be/models/laporan_sptbe_model.dart';
import 'package:bapenda_getx2_admin/core/pdf/pdf_helper.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfLaporanSPTBE {
  static Future<File> generate(RxList<ModelSptbe> laporan,
      DateTime? selectedDate, DateTime? selectedDate_akhir) async {
    final pdf = Document();

    const pageSize = 32;

    Map<int, List<pw.TableRow>> rows = {};

    final numberOfPages = (laporan.length / pageSize).ceil();

    for (var page = 0; page < numberOfPages; page++) {
      rows[page] = [
        pw.TableRow(
          children: [
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("No.",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("Jenis Pajak",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14.sp)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("Jml SPT",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14.sp)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("Total Pajak",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14.sp)),
              ),
            ),
          ],
        ),
      ];

      var loopLimit =
          laporan.length - (laporan.length - ((page + 1) * pageSize));

      if (loopLimit > laporan.length) loopLimit = laporan.length;

      for (var index = pageSize * page; index < loopLimit; index++) {
        rows[page]!.add(pw.TableRow(
          children: [
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text(
                  "${index + 1}",
                ),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text(
                  "${laporan[index].namaPajak} ",
                ),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text(
                  "${laporan[index].totalSpt} ",
                ),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text(
                  "${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(double.parse(laporan[index].totalPajak).toInt())}",
                ),
              ),
            ),
          ],
        ));
      }
    }
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.symmetric(horizontal: PdfPageFormat.cm * 1),
        header: (context) => buildHeader(selectedDate, selectedDate_akhir),
        footer: (context) => buildFooter(),
        maxPages: 100,
        build: (context) {
          return List<pw.Widget>.generate(rows.keys.length, (index) {
            return pw.Column(
              children: [
                pw.Table(
                  border:
                      pw.TableBorder.all(color: PdfColor.fromHex("#000000")),
                  children: rows[index]!,
                ),
              ],
            );
          });
        },
      ),
    );

    // pdf.addPage(MultiPage(
    //   build: (context) => [
    //     SizedBox(height: 0.8 * PdfPageFormat.cm),
    //     Stack(children: [
    //       Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    //         Container(width: 88.w, height: 88.h, child: svgImage),
    //         SizedBox(width: 10.w),
    //       ]),
    //       Positioned(
    //           left: 77.r,
    //           child: Container(
    //             width: 13.4 * PdfPageFormat.cm,
    //             child: Column(
    //               children: [
    //                 SizedBox(height: 15.h),
    //                 Text("LHP Pajak Bulan Desember",
    //                     style: TextStyle(fontSize: 18.sp)),
    //                 Text("BADAN PENDAPATAN DAERAH",
    //                     style: TextStyle(fontSize: 18.sp)),
    //                 Text(
    //                     "Jl. MH. Thamrin RT. 05 No. 14 Telpon (0548) 21301, 21152 Fax. (0548) 21152",
    //                     style: TextStyle(fontSize: 9.5.sp)),
    //                 //Text("BONTANG", style: TextStyle(fontSize: 13))
    //               ],
    //             ),
    //           ))
    //     ]),
    //     Stack(children: [
    //       Center(
    //           child: Column(children: [
    //         SizedBox(height: 30.h),
    //         Container(
    //             width: 600.w,
    //             height: 600.h,
    //             child: Opacity(opacity: 0.1, child: svgImage2))
    //       ])),
    //       Container(
    //           child: Column(children: [
    //         Divider(),
    //         SizedBox(height: 1 * PdfPageFormat.cm),
    //         buildBody(laporan),
    //       ]))
    //     ]),
    //   ],
    //   margin: EdgeInsets.symmetric(horizontal: 50.w),
    //   footer: (context) => buildFooter(),
    // ));

    return PdfHelper.saveDocument(name: 'CetakLaporan_1.pdf', pdf: pdf);
  }

  static Widget buildHeader(
          DateTime? selectedDate, DateTime? selectedDate_akhir) =>
      Center(
          child: Container(
              child: Column(
        children: [
          SizedBox(height: 15.h),
          Text("Laporan Jumlah Pajak yang dilaporkan melalui \nBapenda Etam",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold)),
          Text(
              "Periode : ${DateFormat('dd-MM-yyyy').format(selectedDate!)} - ${DateFormat('dd-MM-yyyy').format(selectedDate_akhir!)}",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          //Text("BONTANG", style: TextStyle(fontSize: 13))
        ],
      )));

  static Widget buildFooter() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              Text(
                  "Laporan ini dibuat secara sistem oleh Aplikasi Bapenda Etam dan diakui resmi oleh Bapenda Kota Bontang",
                  style: TextStyle(fontSize: 9.sp)),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              Text("Download PDF ini untuk menyimpannya kedalam Ponsel",
                  style: TextStyle(fontSize: 9.sp)),
            ],
          ),
          SizedBox(height: 2 * PdfPageFormat.mm),
        ],
      );
}
