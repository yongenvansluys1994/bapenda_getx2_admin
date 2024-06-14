import 'dart:convert';

import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/app/modules/laporan_daftaruser/models/model_lapdaftaruser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LaporanDaftaruserController extends GetxController {
  Api api;
  LaporanDaftaruserController(this.api);
  DateTime? selectedDate;
  DateTime? selectedDate_akhir;
  var FinalDate;
  var FinalDate_akhir;
  String? valueJenisPajak;
  bool displayResult = false;
  RxList<ModelLapDaftarUser> datalist = <ModelLapDaftarUser>[].obs;
  bool isLoading = false;
  bool isEmpty = false;


  @override
  void onInit() {
    super.onInit();

  }

  void populateDatalist() async {
    isLoading = true;
    update();
    datalist.clear();
    //EasyLoading.show();
    final data_mentah = await api.getLapDaftarUser(
        masa_awal: selectedDate, masa_akhir: selectedDate_akhir, jenispajak: valueJenisPajak);
    print(jsonEncode(data_mentah));
    if (data_mentah == null) {
      isEmpty = true;
      isLoading = false;
      update();
    } else if (data_mentah.isEmpty) {
      isEmpty = true;
      isLoading = false;
      update();
    } else {
      datalist.addAll(data_mentah);
      //print(jsonEncode(data_mentah));
      isEmpty = false;
      isLoading = false;
      displayResult = true;
      update();
    }
    //EasyLoading.dismiss();
    update();
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

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

   
}
