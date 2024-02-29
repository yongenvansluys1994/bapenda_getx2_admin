import 'dart:convert';

import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/app/modules/laporan_qris/models/model_laporan_qris.dart';
import 'package:bapenda_getx2_admin/widgets/getdialog.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LapDetailQrisController extends GetxController {
  bool isLoading = false;
  String ket_loading = "Sedang Memproses VA";
  RxList<ModelLaporanQris> datalist = <ModelLaporanQris>[].obs;
  int? totalAmount;
  bool isLoadingPembayaran = false;
  String $id_institution_qris = "230714011";
  Map<String, dynamic> responsePembayaran = {};
  String? statusPembayaran;

  @override
  void onInit() {
    super.onInit();
    FetchLaporan();
  }

  Future FetchLaporan() async {
    isLoading = true;
    var headers = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse(
        "https://yongen-bisa.com/bapenda_app/api_ver2/vaqris/laporan_qris.php");
    var response = await http.get(url, headers: headers);

    ket_loading = "Tunggu sebentar lagi";
    var jsonData = json.decode(response.body);
    if (jsonData is List) {
      List newItems = jsonData;
      final list = newItems
          .map<ModelLaporanQris>((json) => ModelLaporanQris.fromJson(json));
      datalist.addAll(list);
      // Use dataList as needed, for example:

      List<String> numbers = datalist.map((model) => model.kdTagihan).toList();
      String encodedData = numbers.map(Uri.encodeQueryComponent).join(',');

      var simpatdaUrl = Uri.parse(
          "http://simpatda.bontangkita.id/simpatda/api_mobile2/fetchSPTlaporan?json=$encodedData");
      var simpatdaResponse = await http.get(simpatdaUrl);
      List simpatdaList = json.decode(simpatdaResponse.body);

      for (var item in datalist) {
        var matchingData = simpatdaList.firstWhere(
            (element) => element["NOMOR_KOHIR"] == item.kdTagihan,
            orElse: () => null);

        if (matchingData != null) {
          item.namaUsaha = matchingData["NAMA_USAHA"];
          item.jenispajak = matchingData["JENISPAJAK"];
          item.tanggalLunas = matchingData["TANGGAL_LUNAS"];
          item.uraian = matchingData["URAIAN"];
          item.pajak = "";
        }
      }
    }
    //sumAmountInDatalist();
    isLoading = false;
    update();
    print("check status lunas di simpatda");
  }

  void sumAmountInDatalist() {
    totalAmount = datalist.fold<int>(
      0,
      (previousValue, element) => previousValue + int.parse(element.pajak),
    );
  }

  void openDialog(String kdTagihan) {
    CheckPembayaranQRIS(kdTagihan);
    update();
  }

  Future CheckPembayaranQRIS(String nomor_kohir) async {
    isLoadingPembayaran = true;
    var url_auth =
        Uri.parse("${URL_APP_API}/vaqris/check_auth.php?kategori=qris");
    var response_auth = await http.get(url_auth);
    List data_auth = json.decode(response_auth.body);
    DateTime waktu1 = DateTime.parse(data_auth[0]["created_at"]);
    DateTime waktu2 = DateTime.now();
    var selisih = waktu2.millisecondsSinceEpoch - waktu1.millisecondsSinceEpoch;
    if (selisih > 800000) {
      //jika sudah melewati masa aktif Auth yaitu 15 Menit
      //auth ulang
      print("Auth Sudah tidak aktif, Auth Ulang");
      var headers = {
        'Content-Type': 'application/json',
      };
      final body = {"username": "PDLBONTANG", "password": "PDLBONTANG"};
      var url = Uri.parse(
          "https://qris-pemda.bankaltimtara.co.id/api/qrismpm/user/auth");
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      var data = json.decode(response.body);
      //memproses check status pembayaran QRIS
      if (data['message'] == "success") {
        //jika berhasil auth dengan API bankaltimtara
        var url_update =
            Uri.parse("${URL_APP_API}/vaqris/update.php?kategori=qris");
        var response = await http.post(url_update, body: {
          "username": "PDLBONTANG",
          "password": "PDLBONTANG",
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
          final body = {
            "kd_tagihan": "${nomor_kohir}",
            "institusi": "${$id_institution_qris}"
          };
          var url = Uri.parse(
              "https://qris-pemda.bankaltimtara.co.id/api/qrismpm/transaction/status");
          var response =
              await http.post(url, headers: headers, body: jsonEncode(body));
          var data_QRIS = json.decode(response.body);
          print(jsonEncode(data_QRIS));
          if (data_QRIS['message'] == "success") {
            //jika berhasil GET REPORT STATUS PEMBAYARAN QRIS BPD SUDAH LUNAS
            responsePembayaran = json.decode(response.body);
            getDefaultDialog().onConfirmWithoutIcon(
              title: "QRIS telah dibayarkan",
              desc: "QRIS ini telah dibayarkan, Proses Callback manual?",
              handler: () async {
                //Proses Hit Callack
                var headers = {
                  'Content-Type': 'application/json',
                };
                final body = {
                  "kd_tagihan": "${data_QRIS['kd_tagihan']}",
                  "institusi": "230714011",
                  "bill_number": "${data_QRIS['bill_number']}",
                  "trx_date": "${data_QRIS['trx_date']}",
                  "rrn": "${data_QRIS['rrn']}"
                };
                var url = Uri.parse(
                    "http://simpatda.bontangkita.id/simpatda/api/qrismpm/transaction/callback");
                //await http.post(url, headers: headers, body: jsonEncode(body));
                var responsecallback = await http.post(url,
                    headers: headers, body: jsonEncode(body));
                var data_callback = json.decode(responsecallback.body);
                print(data_callback['message']);
                Get.back();
                if (data_callback['message'] == "success") {
                  print("success hit callback");

                  EasyLoading.showSuccess('Berhasil hit callback');
                }
                //End Proses Hit Callack
              },
            );
            print("${data_QRIS}");
            isLoadingPembayaran = false;
            update();
            print("Pembayaran QRIS Lunas 1");
          } else {
            print("${data_QRIS}");
            //jika GET REPORT STATUS PEMBAYARAN QRIS BPD BELUM LUNAS
            if (data_QRIS['code'] == 500) {
              getDefaultDialog().onFixWithoutIcon(
                  title: "${"Auth QRIS Expired Token"}", desc: "${""}");
            } else {
              getDefaultDialog().onFixWithoutIcon(
                  title: "${"QRIS belum dibayarkan"}",
                  desc: "${"QRIS ini belum dibayarkan oleh WP"}");
              print("QRIS Tidak ada");
            }

            update();
          }
        } else {
          print("Gagal Perbaharui Token ke API bapenda ETAM");
          isLoadingPembayaran = false;
          update();
        }
      } else {
        print("Gagal Auth API Bankaltimtara");
        update();
      }
    } else {
      print("Auth Masih Aktif, Auth Ulang");
      //memproses check status pembayaran QRIS
      print("Get Report Status Pembayaran Bankaltim");
      //-------------------GET REPORT STATUS PEMBAYARAN QRIS------------------------------------
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${data_auth[0]["token"]}',
      };
      final body = {
        "kd_tagihan": "${nomor_kohir}",
        "institusi": "${$id_institution_qris}"
      };
      var url = Uri.parse(
          "https://qris-pemda.bankaltimtara.co.id/api/qrismpm/transaction/status");
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      var data_QRIS = json.decode(response.body);
      if (data_QRIS['message'] == "success") {
        //jika berhasil GET REPORT STATUS PEMBAYARAN QRIS BPD
        //Cek status lunas di simpatda
        print("${data_QRIS}");

        isLoadingPembayaran = false;
        responsePembayaran = json.decode(response.body);
        getDefaultDialog().onConfirmWithoutIcon(
          title: "QRIS telah dibayarkan",
          desc: "QRIS ini telah dibayarkan, Proses Callback manual?",
          handler: () async {
            //Proses Hit Callack
            var headers = {
              'Content-Type': 'application/json',
            };
            final body = {
              "kd_tagihan": "${data_QRIS['kd_tagihan']}",
              "institusi": "230714011",
              "bill_number": "${data_QRIS['bill_number']}",
              "trx_date": "${data_QRIS['trx_date']}",
              "rrn": "${data_QRIS['rrn']}"
            };
            var url = Uri.parse(
                "http://simpatda.bontangkita.id/simpatda/api/qrismpm/transaction/callback");
            //await http.post(url, headers: headers, body: jsonEncode(body));
            var responsecallback =
                await http.post(url, headers: headers, body: jsonEncode(body));
            var data_callback = json.decode(responsecallback.body);
            print(data_callback['message']);
            Get.back();
            if (data_callback['message'] == "success") {
              print("success hit callback");
              EasyLoading.showSuccess('Berhasil hit callback');
            }
            //End Proses Hit Callack
          },
        );
        update();
        print("Pembayaran QRIS Lunas 2");
      } else {
        //jika GET REPORT STATUS PEMBAYARAN QRIS BPD BELUM LUNAS
        print("${data_QRIS}");
        if (data_QRIS['code'] == 500) {
          getDefaultDialog().onFixWithoutIcon(
              title: "${"Auth QRIS Expired Token"}", desc: "${""}");
        } else {
          getDefaultDialog().onFixWithoutIcon(
              title: "${"QRIS belum dibayarkan"}",
              desc: "${"QRIS ini belum dibayarkan oleh WP"}");
          print("QRIS Tidak ada");
        }

        update();
      }
    }
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
