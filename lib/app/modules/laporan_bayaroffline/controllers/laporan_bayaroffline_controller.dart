import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/app/core/pdf/pdf_Laporan2.dart';
import 'package:bapenda_getx2_admin/app/modules/laporan_2/models/laporan_2_model.dart';
import 'package:bapenda_getx2_admin/core/pdf/pdf_helper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LaporanBayarOfflineController extends GetxController {
  Api api;
  LaporanBayarOfflineController(this.api);
  DateTime? selectedDate;
  DateTime? selectedDate_akhir;
  var FinalDate;
  var FinalDate_akhir;
  String? valueJenisPajak;
  bool displayResult = false;
  RxList<ModelLaporan2> datalist = <ModelLaporan2>[].obs;
  bool isLoading = false;
  bool isEmpty = false;

  @override
  void onInit() {
    super.onInit();
  }

  String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return text.substring(0, maxLength) + "...";
    }
  }

  void date_picker_awal(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate:
          DateTime.now(), // The initial date when the date picker is opened.
      firstDate: DateTime(2021), // The earliest date that can be selected.
      lastDate: DateTime(2025), // The latest date that can be selected.
    ).then((date) {
      if (date != null) {
        selectedDate = date;
        var ubahyear = DateFormat('dd-MM-yyyy').format(selectedDate!);
        FinalDate = ubahyear.toString();
        update();
      }
    });
    update();
  }

  void date_picker_akhir(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate:
          DateTime.now(), // The initial date when the date picker is opened.
      firstDate: DateTime(2021), // The earliest date that can be selected.
      lastDate: DateTime(2025), // The latest date that can be selected.
    ).then((date) {
      if (date != null) {
        selectedDate_akhir = date;
        var ubahyear = DateFormat('dd-MM-yyyy').format(selectedDate_akhir!);
        FinalDate_akhir = ubahyear.toString();
        update();
      }
    });
    update();
  }

  void updateValueDropdown(String value) async {
    valueJenisPajak =
        value; //value kode_rekening  sesuai jenis pajak yg dipilih
    update();
  }

  // Function to manually add values to the datalist
  void populateDatalist() async {
    displayResult = false;
    isLoading = true;
    update();
    datalist.clear();
    //EasyLoading.show();
    final data_mentah = await api.getLaporanBayarOffline(
        masa_awal: selectedDate, masa_akhir: selectedDate_akhir);
    //print(data_mentah);
    if (data_mentah == null) {
      isLoading = false;
      isEmpty = true;
      update();
    } else if (data_mentah.isEmpty) {
      isLoading = false;
      isEmpty = true;
      update();
    } else {
      datalist.addAll(data_mentah);
      isLoading = false;
      isEmpty = false;
      displayResult = true;
      update();
    }
    //EasyLoading.dismiss();
    update();
  }

  Future cetakLHP() async {
    final pdfFile =
        await PdfLaporan2.generate(datalist, selectedDate, selectedDate_akhir);
    PdfHelper.openFile(pdfFile);
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
