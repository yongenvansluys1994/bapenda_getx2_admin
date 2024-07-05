import 'dart:convert';

import 'package:bapenda_getx2_admin/app/modules/laporan_va/models/model_laporan_va.dart';
import 'package:bapenda_getx2_admin/widgets/getdialog.dart';
import 'package:bapenda_getx2_admin/widgets/logger.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LapDetailVaController extends GetxController {
  bool isLoading = false;
  String ket_loading = "Sedang Memproses VA";
  RxList<ModelLaporanVa> datalist = <ModelLaporanVa>[].obs;
  String valueBulan = "0";
  int? totalAmount;

  @override
  void onInit() {
    super.onInit();
    FetchLaporan();
    if (Get.parameters['bulan'] == "December") {
      valueBulan = "12";
    } else if (Get.parameters['bulan'] == "November") {
      valueBulan = "11";
    } else if (Get.parameters['bulan'] == "October") {
      valueBulan = "10";
    } else if (Get.parameters['bulan'] == "September") {
      valueBulan = "09";
    } else if (Get.parameters['bulan'] == "August") {
      valueBulan = "08";
    } else if (Get.parameters['bulan'] == "July") {
      valueBulan = "07";
    } else if (Get.parameters['bulan'] == "June") {
      valueBulan = "06";
    } else if (Get.parameters['bulan'] == "May") {
      valueBulan = "05";
    } else if (Get.parameters['bulan'] == "April") {
      valueBulan = "04";
    } else if (Get.parameters['bulan'] == "March") {
      valueBulan = "03";
    } else if (Get.parameters['bulan'] == "February") {
      valueBulan = "02";
    } else if (Get.parameters['bulan'] == "January") {
      valueBulan = "01";
    }
    update();
  }

  Future FetchLaporan() async {
    isLoading = true;
    var url_auth = Uri.parse(
        "http://simpatda.bontangkita.id/api_ver2/vaqris/check_auth.php?kategori=va");
    var response_auth = await http.get(url_auth);
    List data_auth = json.decode(response_auth.body);
    logValue(data_auth[0]["token"]);
    DateTime waktu1 = DateTime.parse(data_auth[0]["created_at"]);
    DateTime waktu2 = DateTime.now();
    logValue(
        'selisih ${waktu2.millisecondsSinceEpoch - waktu1.millisecondsSinceEpoch}');
    var selisih = waktu2.millisecondsSinceEpoch - waktu1.millisecondsSinceEpoch;
    if (selisih > 86400000) {
      //jika sudah melewati masa aktif Auth yaitu 1 Jam
      //auth ulang
      logInfo("Auth Sudah tidak aktif, Auth Ulang");
      var headers = {
        'Content-Type': 'application/json',
      };
      final body = {"username": "btgpdl23", "password": "ByrPjkBtg#23!"};
      var url = Uri.parse(
          "https://e-api.bankaltimtara.co.id:8083/api-pemda/user/auth");
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      var data = json.decode(response.body);
      //memproses check status pembayaran QRIS
      if (data['message'] == "success") {
        //jika berhasil auth dengan API bankaltimtara
        ket_loading = "Sedang Proses Auth";
        var url_update = Uri.parse(
            "http://simpatda.bontangkita.id/api_ver2/vaqris/update.php?kategori=va");
        var response = await http.post(url_update, body: {
          "username": "btgpdl23",
          "password": "ByrPjkBtg#23!",
          "token": "${data['token']}",
        });
        var data_update = json.decode(response.body);
        if (data_update == "Success") {
          //jika berhasil perbaharui Token di table auth_vaqris Bapenda Rumahweb
          //-------------------GET REPORT STATUS PEMBAYARAN QRIS------------------------------------
          var headers = {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${data['token']}',
          };

          var url = Uri.parse(
              "https://e-api.bankaltimtara.co.id:8083/api-pemda/va/paid/monthly/2024$valueBulan");
          var response = await http.get(url, headers: headers);
          var data_VA = json.decode(response.body);

          if (data_VA['message'] == "success") {
            ket_loading = "Tunggu sebentar lagi";
            List datalist_mentah =
                (json.decode(response.body) as Map<String, dynamic>)["data"];
            datalist.addAll(datalist_mentah
                .map((e) => ModelLaporanVa.fromJson(e))
                .toList());
            List<String> numbers =
                datalist.map((model) => model.number).toList();
            String encodedData =
                numbers.map(Uri.encodeQueryComponent).join(',');

            var simpatdaUrl = Uri.parse(
                "http://simpatda.bontangkita.id/simpatda/api_mobile2/fetchSPTlaporan?json=$encodedData");
            var simpatdaResponse = await http.get(simpatdaUrl);
            List simpatdaList = json.decode(simpatdaResponse.body);

            for (var item in datalist) {
              var matchingData = simpatdaList.firstWhere(
                  (element) => element["NOMOR_KOHIR"] == item.number,
                  orElse: () => null);

              if (matchingData != null) {
                item.reference = matchingData["NAMA_USAHA"];
                item.jenisPajak = matchingData["JENISPAJAK"];
              }
            }
            sumAmountInDatalist();
            isLoading = false;
            update();
            logInfo("check status lunas di simpatda");
          }
        } else {
          logInfo("Gagal Perbaharui Token ke API bapenda ETAM");
          getDefaultDialog().onFix(
              title: "Tidak ada Transaksi di bulan ini",
              desc:
                  "Data ini adalah data Integrasi Realtime dari Bankaltimtara dengan Bapenda Etam",
              kategori: "error");
          isLoading = false;
          update();
        }
      } else {
        logInfo("Gagal Auth API Bankaltimtara");
        isLoading = false;
        update();
      }
    } else {
      //memproses check status pembayaran QRIS
      logInfo("Get Report Status Pembayaran Bankaltim");
      //-------------------GET REPORT STATUS PEMBAYARAN QRIS------------------------------------
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${data_auth[0]["token"]}',
      };

      var url = Uri.parse(
          "https://e-api.bankaltimtara.co.id:8083/api-pemda/va/paid/monthly/2024$valueBulan");
      var response = await http.get(url, headers: headers);
      logValue(jsonEncode(response.body));

      var data_VA = json.decode(response.body);
      if (data_VA['message'] == "success") {
        ket_loading = "Tunggu sebentar lagi";
        List datalist_mentah =
            (json.decode(response.body) as Map<String, dynamic>)["data"];
        datalist.addAll(
            datalist_mentah.map((e) => ModelLaporanVa.fromJson(e)).toList());
        List<String> numbers = datalist.map((model) => model.number).toList();
        String encodedData = numbers.map(Uri.encodeQueryComponent).join(',');

        var simpatdaUrl = Uri.parse(
            "http://simpatda.bontangkita.id/simpatda/api_mobile2/fetchSPTlaporan?json=$encodedData");
        var simpatdaResponse = await http.get(simpatdaUrl);
        List simpatdaList = json.decode(simpatdaResponse.body);

        for (var item in datalist) {
          var matchingData = simpatdaList.firstWhere(
              (element) => element["NOMOR_KOHIR"] == item.number,
              orElse: () => null);

          if (matchingData != null) {
            item.reference = matchingData["NAMA_USAHA"];
            item.jenisPajak = matchingData["JENISPAJAK"];
          }
        }
        sumAmountInDatalist();
        isLoading = false;
        update();
      } else {
        logInfo("Gagal get status pembayaran BPD");
        logInfo("${data_VA}");
        getDefaultDialog().onFix(
            title: "Tidak ada Transaksi di bulan ini",
            desc:
                "Data ini adalah data Integrasi Realtime dari Bankaltimtara dengan Bapenda Etam",
            kategori: "error");
        isLoading = false;
        update();
      }
    }
  }

  void sumAmountInDatalist() {
    totalAmount = datalist.fold<int>(
      0,
      (previousValue, element) => previousValue + int.parse(element.amount),
    );
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
