import 'dart:io';

import 'package:bapenda_getx2_admin/app/core/pdf/pdf_helper.dart';
import 'package:bapenda_getx2_admin/app/modules/laporan_2/models/laporan_2_model.dart';
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

    List<pw.TableRow> rows = [];

    String truncateText(String text, int maxLength) {
      if (text.length <= maxLength) {
        return text;
      } else {
        return text.substring(0, maxLength) + "..";
      }
    }

    rows.add(
      pw.TableRow(
        children: [
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("No.",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("Tgl Penetapan",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("Jatuh Tempo",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("Kode Rekening",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("Nama Rekening",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("No Kohir",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("Nama WP",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("NPWPD",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("Pajak",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("Denda",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("Dibayar",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("Masa Pajak",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("Metode Bayar",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 7.5)),
            ),
          ),
        ],
      ),
    );

    for (var index = 0; index < laporan.length; index++) {
      rows.add(
        pw.TableRow(
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
        ),
      );
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.landscape,
        margin: pw.EdgeInsets.symmetric(horizontal: PdfPageFormat.cm * 0.5),
        header: (context) => buildHeader(selectedDate, selectedDate_akhir),
        footer: (context) => buildFooter(),
        maxPages: 200, // Explicitly setting a higher maxPages limit
        build: (context) {
          return [
            pw.Table(
              border: pw.TableBorder.all(color: PdfColor.fromHex("#000000")),
              children: rows,
            ),
          ];
        },
      ),
    );

    return PdfHelper.saveDocument(name: 'CetakLaporan_2.pdf', pdf: pdf);
  }

  static pw.Widget buildHeader(
          DateTime? selectedDate, DateTime? selectedDate_akhir) =>
      pw.Center(
        child: pw.Container(
          child: pw.Column(
            children: [
              pw.SizedBox(height: 15.h),
              pw.Text("LHP Pajak ",
                  style: pw.TextStyle(
                      fontSize: 17.sp, fontWeight: pw.FontWeight.bold)),
              pw.Text("By Bapenda Etam App",
                  style: pw.TextStyle(
                      fontSize: 15.sp, fontWeight: pw.FontWeight.bold)),
              pw.Text(
                  "Periode : ${DateFormat('dd-MM-yyyy').format(selectedDate!)} - ${DateFormat('dd-MM-yyyy').format(selectedDate_akhir!)}",
                  style: pw.TextStyle(
                      fontSize: 14.sp, fontWeight: pw.FontWeight.bold)),
              pw.Divider(),
              pw.SizedBox(height: 2 * PdfPageFormat.mm),
            ],
          ),
        ),
      );

  static pw.Widget buildFooter() => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Divider(),
          pw.SizedBox(height: 2 * PdfPageFormat.mm),
          pw.Row(
            mainAxisSize: pw.MainAxisSize.min,
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(
                  "LHP ini adalah resmi dikeluarkan oleh Aplikasi Bapenda Etam dan diakui oleh Badan Pendapatan Daerah Kota Bontang",
                  style: pw.TextStyle(fontSize: 9.sp)),
            ],
          ),
          pw.SizedBox(height: 1 * PdfPageFormat.mm),
          pw.Row(
            mainAxisSize: pw.MainAxisSize.min,
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text("Download PDF ini untuk menyimpannya kedalam Ponsel",
                  style: pw.TextStyle(fontSize: 9.sp)),
            ],
          ),
          pw.SizedBox(height: 2 * PdfPageFormat.mm),
        ],
      );
}
