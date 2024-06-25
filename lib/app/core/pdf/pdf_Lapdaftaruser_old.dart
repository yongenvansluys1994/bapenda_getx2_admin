import 'dart:io';
import 'package:bapenda_getx2_admin/app/core/pdf/pdf_helper.dart';
import 'package:bapenda_getx2_admin/app/modules/laporan_daftaruser/models/model_lapdaftaruser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfLapWPBelummuktahir {
  static Future<File> generate(RxList<ModelLapDaftarUser> laporan,
      DateTime? selectedDate, DateTime? selectedDate_akhir) async {
    final pdf = pw.Document();

    const pageSize = 32;
    const rowsPerPage = 21; // Adjust the number of rows per page as needed

    // Function to generate a single page of the PDF
    pw.Widget generatePage(List<ModelLapDaftarUser> pageData, int pageIndex) {
      List<pw.TableRow> rows = [];

      // Add header row
      rows.add(
        pw.TableRow(
          children: [
            pw.Container(
              height: 20.h,
              width: 30.w,
              child: pw.Center(
                child: pw.Text("No.",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 6)),
              ),
            ),
            pw.Container(
              height: 20.h,
              width: 110.w,
              child: pw.Center(
                child: pw.Text("NPWPD",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 6)),
              ),
            ),
            pw.Container(
              height: 20.h,
              width: 130.w,
              child: pw.Center(
                child: pw.Text("NAMA USAHA",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 6)),
              ),
            ),
            pw.Container(
              height: 20.h,
              width: 150.w,
              child: pw.Center(
                child: pw.Text("ALAMAT USAHA",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 6)),
              ),
            ),
            pw.Container(
              height: 20.h,
              width: 50.w,
              child: pw.Center(
                child: pw.Align(
                    alignment: pw.Alignment.center,
                    child: pw.Text("RT USAHA",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 6))),
              ),
            ),
            pw.Container(
              height: 20.h,
              width: 100.w,
              child: pw.Center(
                child: pw.Text("NO.HP USAHA",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 6)),
              ),
            ),
            pw.Container(
              height: 20.h,
              width: 150.w,
              child: pw.Center(
                child: pw.Text("EMAIL USAHA",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 6)),
              ),
            ),
            pw.Container(
              height: 20.h,
              width: 130.w,
              child: pw.Center(
                child: pw.Text("NAMA PEMILIK",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 6)),
              ),
            ),
            pw.Container(
              height: 20.h,
              width: 100.w,
              child: pw.Center(
                child: pw.Align(
                    alignment: pw.Alignment.center,
                    child: pw.Text("PEKERJAAN PEMILIK",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 6))),
              ),
            ),
            pw.Container(
              height: 20.h,
              width: 100.w,
              child: pw.Center(
                child: pw.Text("NO. HP PEMILIK",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 6)),
              ),
            ),
            pw.Container(
              height: 20.h,
              width: 150.w,
              child: pw.Center(
                child: pw.Text("EMAIL PEMILIK",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 6)),
              ),
            ),
            pw.Container(
              height: 20.h,
              width: 120.w,
              child: pw.Center(
                child: pw.Text("KOORDINAT",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 6)),
              ),
            ),
            pw.Container(
              height: 20.h,
              width: 120.w,
              child: pw.Center(
                child: pw.Text("TGL PERUBAHAN",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 6)),
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
                      style: pw.TextStyle(fontSize: 6)),
                ),
              ),
              pw.Container(
                height: 20.h,
                child: pw.Center(
                    child: pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text("${pageData[index].npwpd}",
                      style: pw.TextStyle(fontSize: 6)),
                )),
              ),
              pw.Container(
                height: 20.h,
                child: pw.Center(
                  child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text("${pageData[index].namaUsaha}",
                          style: pw.TextStyle(fontSize: 6))),
                ),
              ),
              pw.Container(
                height: 20.h,
                child: pw.Center(
                  child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text("${pageData[index].alamatUsaha}",
                          style: pw.TextStyle(fontSize: 6))),
                ),
              ),
              pw.Container(
                height: 20.h,
                child: pw.Center(
                  child: pw.Align(
                      alignment: pw.Alignment.center,
                      child: pw.Text("${pageData[index].rtUsaha}",
                          style: pw.TextStyle(fontSize: 6))),
                ),
              ),
              pw.Container(
                height: 20.h,
                
                child: pw.Center(
                  child: pw.Align(
                      alignment: pw.Alignment.center,
                      child: pw.Text("${pageData[index].nohpUsaha}",
                          style: pw.TextStyle(fontSize: 6))),
                ),
              ),
              pw.Container(
                height: 20.h,
                
                child: pw.Center(
                  child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text("${pageData[index].emailUsaha}",
                          style: pw.TextStyle(fontSize: 6))),
                ),
              ),
              pw.Container(
                height: 20.h,
                child: pw.Center(
                  child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text("${pageData[index].namaPemilik}",
                          style: pw.TextStyle(fontSize: 6))),
                ),
              ),
              pw.Container(
                height: 20.h,
                
                child: pw.Center(
                  child: pw.Align(
                      alignment: pw.Alignment.center,
                      child: pw.Text("${pageData[index].pekerjaanPemilik}",
                          style: pw.TextStyle(fontSize: 6))),
                ),
              ),
              pw.Container(
                height: 20.h,
                
                child: pw.Center(
                  child: pw.Align(
                      alignment: pw.Alignment.center,
                      child: pw.Text("${pageData[index].nohpPemilik}",
                          style: pw.TextStyle(fontSize: 6))),
                ),
              ),
              pw.Container(
                height: 20.h,
                
                child: pw.Center(
                  child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text("${pageData[index].emailPemilik}",
                          style: pw.TextStyle(fontSize: 6))),
                ),
              ),
              pw.Container(
                height: 20.h,
                
                child: pw.Center(
                  child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text("${pageData[index].koordinat}",
                          style: pw.TextStyle(fontSize: 6))),
                ),
              ),
              pw.Container(
                height: 20.h,
                
                child: pw.Center(
                  child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text("${pageData[index].date}",
                          style: pw.TextStyle(fontSize: 6))),
                ),
              ),
              // Add more columns here as needed
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
          header: (context) =>
              conditionalHeader(context, selectedDate, selectedDate_akhir),
          footer: (context) => buildFooter(),
          build: (context) => [generatePage(pageData, i)],
        ),
      );
    }

    return PdfHelper.saveDocument(
        name: 'LaporanWP_SebelumTermuktahir.pdf', pdf: pdf);
  }

  static pw.Widget conditionalHeader(pw.Context context, DateTime? selectedDate,
      DateTime? selectedDate_akhir) {
    if (context.pageNumber == 1) {
      return buildHeader(selectedDate, selectedDate_akhir);
    } else {
      return pw.Container(
          child: pw.Column(children: [
        pw.SizedBox(height: 15.h),
        pw.SizedBox(height: 2 * PdfPageFormat.mm)
      ]));
    }
  }

  static pw.Widget buildHeader(
          DateTime? selectedDate, DateTime? selectedDate_akhir) =>
      pw.Center(
        child: pw.Container(
            child: pw.Column(
          children: [
            pw.Column(
              children: [
                pw.SizedBox(height: 15.h),
                pw.Text("Laporan WP Sebelum Termuktahir",
                    style: pw.TextStyle(
                        fontSize: 14.sp, fontWeight: pw.FontWeight.bold)),
                pw.Text("By Bapenda Etam App",
                    style: pw.TextStyle(
                        fontSize: 13.sp, fontWeight: pw.FontWeight.bold)),
                pw.Text(
                    "Periode : ${DateFormat('dd-MM-yyyy').format(selectedDate!)} - ${DateFormat('dd-MM-yyyy').format(selectedDate_akhir!)}",
                    style: pw.TextStyle(
                        fontSize: 12.sp, fontWeight: pw.FontWeight.bold)),
              ],
            ),
            pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: pw.Text("Warna hijau adalah data yang diperbaharui",
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(fontSize: 9.5.sp)),
            ),
            pw.Divider(),
            pw.SizedBox(height: 2 * PdfPageFormat.mm),
          ],
        )),
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
