import 'dart:io';

import 'package:bapenda_getx2_admin/app/modules/laporan_2/models/laporan_2_model.dart';
import 'package:bapenda_getx2_admin/core/pdf/pdf_helper.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfLaporan2 {
  static Future<File> generate(RxList<ModelLaporan2> laporan,
      DateTime? selectedDate, DateTime? selectedDate_akhir) async {
    final pdf = Document();

    const pageSize = 32;

    Map<int, List<pw.TableRow>> rows = {};

    final numberOfPages = (laporan.length / pageSize).ceil();
    String truncateText(String text, int maxLength) {
      if (text.length <= maxLength) {
        return text;
      } else {
        return text.substring(0, maxLength) + "..";
      }
    }

    for (var page = 0; page < numberOfPages; page++) {
      rows[page] = [
        pw.TableRow(
          children: [
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("No.",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("Tgl Penetapan",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("Jatuh Tempo",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("Kode Rekening",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("Nama Rekening",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("No Kohir",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("Nama WP",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("NPWPD",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("Pajak",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("Denda",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("Dibayar",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("Masa Pajak",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("Metode Bayar",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
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
                child: pw.Text("${index + 1}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("${laporan[index].tglPenetapan}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("${laporan[index].batasBayar}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("${laporan[index].kodeRekening}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text(
                    "${truncateText(laporan[index].namaRekening, 20)}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("${laporan[index].nomorKohir}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("${truncateText(laporan[index].namaWp, 20)}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("${laporan[index].npwpd}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text(
                    "${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(laporan[index].jumlahPajak)}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text(
                    "${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(laporan[index].denda)}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text(
                    "${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(laporan[index].telahDibayar)}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("${laporan[index].masaPajak}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("${laporan[index].uraianH2H}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
              ),
            ),
          ],
        ));
      }
    }
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat(
          PdfPageFormat.a4.height,
          PdfPageFormat.a4.width,
        ),
        margin: pw.EdgeInsets.symmetric(horizontal: PdfPageFormat.cm * 0.5),
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

    return PdfHelper.saveDocument(name: 'CetakLaporan_2.pdf', pdf: pdf);
  }

  static Widget buildHeader(
          DateTime? selectedDate, DateTime? selectedDate_akhir) =>
      Center(
          child: Container(
              child: Column(
        children: [
          SizedBox(height: 15.h),
          Text("Laporan Realisasi 2 ",
              style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.bold)),
          Text("By Bapenda Etam App",
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)),
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
                  style: TextStyle(fontSize: 7.5)),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              Text("Download PDF ini untuk menyimpannya kedalam Ponsel",
                  style: TextStyle(fontSize: 7.5)),
            ],
          ),
          SizedBox(height: 2 * PdfPageFormat.mm),
        ],
      );
}
