import 'dart:io';
import 'package:bapenda_getx2_admin/app/core/pdf/pdf_helper.dart';
import 'package:bapenda_getx2_admin/app/modules/laporan_2/models/laporan_2_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfLaporanOnline {
  static Future<File> generate(RxList<ModelLaporan2> laporan,
      DateTime? selectedDate, DateTime? selectedDate_akhir) async {
    final pdf = pw.Document();

    const pageSize = 32;
    const rowsPerPage = 40; // Adjust the number of rows per page as needed

    // Hitung total jumlah `telahDibayar`
final totalDibayar = laporan.fold<double>(
  0.0, (sum, item) => sum + item.telahDibayar,
);

    // Function to generate a single page of the PDF
    pw.Widget generatePage(List<ModelLaporan2> pageData, int pageIndex) {
      List<pw.TableRow> rows = [];

      // Add header row
      rows.add(
        pw.TableRow(
          children: [
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("No.",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7.5)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("Tgl Penetapan",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7.5)),
              ),
            ),
            pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("Jatuh Tempo",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7.5)),
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("Kode Rekening",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7.5)),
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("Nama Rekening",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7.5)),
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("No Kohir",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7.5)),
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("Nama WP",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7.5)),
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("NPWPD",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7.5)),
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("Pajak",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7.5)),
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("Denda",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7.5)),
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("Dibayar",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7.5)),
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("Masa Pajak",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7.5)),
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("Metode Bayar",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7.5)),
            ),
          ),
            // Add more columns here as needed
          ],
        ),
      );

      // Add data rows
      for (var index = 0; index < pageData.length; index++) {
        rows.add(
          pw.TableRow(
            children: [
              pw.Container(
                height: 20.h,
                child: pw.Center(
                  child: pw.Text("${index + 1 + (pageIndex * rowsPerPage)}",
                      style: pw.TextStyle(fontSize: 7.5)),
                ),
              ),
              pw.Container(
                height: 20.h,
                child: pw.Center(
                  child: pw.Text("${pageData[index].tglPenetapan}",
                      style: pw.TextStyle(fontSize: 7.5)),
                ),
              ),
              pw.Container(
                height: 20.h,
                child: pw.Center(
                  child: pw.Text("${pageData[index].batasBayar}",
                      style: pw.TextStyle(fontSize: 7.5)),
                ),
              ),
              pw.Container(
                height: 20.h,
                child: pw.Center(
                  child: pw.Text("${pageData[index].kodeRekening}",
                      style: pw.TextStyle(fontSize: 7.5)),
                ),
              ),
              pw.Container(
                height: 20.h,
                child: pw.Center(
                  child: pw.Text("${pageData[index].kodeRekening}",
                      style: pw.TextStyle(fontSize: 7.5)),
                ),
              ),
              pw.Container(
                height: 20.h,
                child: pw.Center(
                  child: pw.Text("${pageData[index].nomorKohir}",
                      style: pw.TextStyle(fontSize: 7.5)),
                ),
              ),
               pw.Container(
                height: 20.h,
                child: pw.Center(
                  child: pw.Text("${pageData[index].namaWp}",
                      style: pw.TextStyle(fontSize: 7.5)),
                ),
              ),
              pw.Container(
                height: 20.h,
                child: pw.Center(
                  child: pw.Text("${pageData[index].npwpd}",
                      style: pw.TextStyle(fontSize: 7.5)),
                ),
              ),
              pw.Container(
                height: 20.h,
                child: pw.Center(
                  child: pw.Text("${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(laporan[index].jumlahPajak)}",
                      style: pw.TextStyle(fontSize: 7.5)),
                ),
              ),
              pw.Container(
                height: 20.h,
                child: pw.Center(
                  child: pw.Text("${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(laporan[index].denda)}",
                      style: pw.TextStyle(fontSize: 7.5)),
                ),
              ),
              pw.Container(
                height: 20.h,
                child: pw.Center(
                  child: pw.Text("${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(laporan[index].telahDibayar)}",
                      style: pw.TextStyle(fontSize: 7.5)),
                ),
              ),
              pw.Container(
                height: 20.h,
                child: pw.Center(
                  child: pw.Text("${pageData[index].masaPajak}",
                      style: pw.TextStyle(fontSize: 7.5)),
                ),
              ),
              pw.Container(
                height: 20.h,
                child: pw.Center(
                  child: pw.Text("${pageData[index].uraianH2H}",
                      style: pw.TextStyle(fontSize: 7.5)),
                ),
              ),
              // Add more columns here as needed
            ],
          ),
        );
      }

      // Add total row at the bottom of the last page
  if (pageIndex == (laporan.length / rowsPerPage).ceil() - 1) {
    rows.add(
      pw.TableRow(
        children: [
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("Total",
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 7.5)),
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("",
                  style: pw.TextStyle(fontSize: 7.5)), // Empty cells
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("",
                  style: pw.TextStyle(fontSize: 7.5)), // Empty cells
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("",
                  style: pw.TextStyle(fontSize: 7.5)), // Empty cells
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("",
                  style: pw.TextStyle(fontSize: 7.5)), // Empty cells
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("",
                  style: pw.TextStyle(fontSize: 7.5)), // Empty cells
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("",
                  style: pw.TextStyle(fontSize: 7.5)), // Empty cells
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("",
                  style: pw.TextStyle(fontSize: 7.5)), // Empty cells
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("",
                  style: pw.TextStyle(fontSize: 7.5)), // Empty cells
            ),
          ),
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text("",
                  style: pw.TextStyle(fontSize: 7.5)), // Empty cells
            ),
          ),
          // Other empty columns here as needed
          pw.Container(
            height: 20.h,
            child: pw.Center(
              child: pw.Text(
                "${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(totalDibayar)}",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

      return pw.Table(
        border: pw.TableBorder.all(color: PdfColor.fromHex("#000000")),
        children: rows,
      );
    }

    // Split the data into pages and add each page to the PDF
    int pageCount = (laporan.length / rowsPerPage).ceil();
    for (int i = 0; i < pageCount; i++) {
      final pageData = laporan.skip(i * rowsPerPage).take(rowsPerPage).toList();
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4.landscape,
          margin: pw.EdgeInsets.symmetric(horizontal: PdfPageFormat.cm * 0.5),
          header: (context) => conditionalHeader(context, selectedDate, selectedDate_akhir),
          footer: (context) => buildFooter(),
          build: (context) => [generatePage(pageData, i)],
        ),
      );
    }

    return PdfHelper.saveDocument(name: 'LapPembayaranOffline.pdf', pdf: pdf);
  }

  static pw.Widget conditionalHeader(pw.Context context, DateTime? selectedDate, DateTime? selectedDate_akhir) {
    if (context.pageNumber == 1) {
      return buildHeader(selectedDate, selectedDate_akhir);
    } else {
      return pw.Container(
        child: pw.Column(
          children: [pw.SizedBox(height: 15.h), pw.SizedBox(height: 2 * PdfPageFormat.mm)]
        )
      );
    }
  }

  static pw.Widget buildHeader(DateTime? selectedDate, DateTime? selectedDate_akhir) => pw.Center(
    child: pw.Container(
      child: pw.Column(
        children: [
          pw.SizedBox(height: 15.h),
          pw.Text("Laporan Pembayaran Offline/Teller",
              style: pw.TextStyle(fontSize: 9.sp, fontWeight: pw.FontWeight.bold)),
          pw.Text("By Bapenda Etam App",
              style: pw.TextStyle(fontSize: 9.sp, fontWeight: pw.FontWeight.bold)),
          pw.Text(
              "Periode : ${DateFormat('dd-MM-yyyy').format(selectedDate!)} - ${DateFormat('dd-MM-yyyy').format(selectedDate_akhir!)}",
              style: pw.TextStyle(fontSize: 9.sp, fontWeight: pw.FontWeight.bold)),
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
              style: pw.TextStyle(fontSize: 8.sp)),
        ],
      ),
      pw.SizedBox(height: 1 * PdfPageFormat.mm),
      pw.Row(
        mainAxisSize: pw.MainAxisSize.min,
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        children: [
          pw.Text("Download PDF ini untuk menyimpannya kedalam Ponsel",
              style: pw.TextStyle(fontSize: 8.sp)),
        ],
      ),
      pw.SizedBox(height: 2 * PdfPageFormat.mm),
    ],
  );
}
