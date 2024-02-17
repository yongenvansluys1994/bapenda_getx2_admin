import 'dart:convert';

import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan/controllers/pendataan_controller.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan/models/model_getpelaporan.dart';
import 'package:bapenda_getx2_admin/app/modules/pendataan_detail/models/model_rekpajak.dart';
import 'package:bapenda_getx2_admin/core/push_notification/push_notif_single.dart';
import 'package:bapenda_getx2_admin/widgets/getdialog.dart';
import 'package:bapenda_getx2_admin/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class PendataanDetailPpjController extends GetxController {
  final pendataanController = Get.find<PendataanController>();
  late ModelGetpelaporan dataArgument;
  TextEditingController jam = TextEditingController();
  TextEditingController hari = TextEditingController();
  TextEditingController persentase = TextEditingController();
  String? id_wajib_pajak;
  String? id_pelaporan;
  String? id_rekening;
  int tarif_rp = 0;
  double rumus = 0;
  String? nama_rekening;
  String? kode_rekening;
  String? npwpd;
  String? masa_pajak2;
  String? masa_akhir2;
  String? status;
  String? nik_user;
  String? nama_usaha;
  String? alamat_usaha;
  String? kec_usaha;
  String? kel_usaha;
  String? rt_usaha;
  String? kota_usaha;
  int pendapatan = 0;
  double kwh = 0;
  String? bukti;
  String? tarif_persen;
  int pajak = 0;
  String? PPJ;
  List data_dropdown = []; //edited line
  String? valuejenispajak;
  List<modelRekPajak> dataRekPajak = [];
  bool hitungPajak = true;
  String jenisPerhitungan = 'Omset';
  bool isChecked = false;
  bool isLoadingPembayaran = false;
  Map<String, dynamic> responsePembayaran = {};
  String? metodePembayaran;
  String $id_institution_qris = "230714011";
  String $id_institution_va =
      "0292"; //4 digit id_institution khusus VA dari BPD

  @override
  void onInit() {
    super.onInit();
    dataArgument = Get.arguments;
    fetchdatadetail();
    if (dataArgument.tanggalLunas != "0") {
      CheckPembayaranQRIS();
    }
    if (dataArgument.status == "0") {
      getSWData();
      hitungPajak = false;
    }
    loadRekening();
    update();
  }

  // Load and parse the JSON data from the file
  Future<void> loadRekening() async {
    final jsonString =
        await rootBundle.loadString('assets/models/auth_model.json');
    final jsonData = json.decode(jsonString);
    dataRekPajak =
        (jsonData as List).map((item) => modelRekPajak.fromJson(item)).toList();

    //print(jsonEncode(dataRekPajak.toList()));
  }

  modelRekPajak getRekPajakByKode(String kodeRekening) {
    return dataRekPajak.firstWhere(
      (rekPajak) => rekPajak.kodeRekening == kodeRekening,
      orElse: () => modelRekPajak('', '', '', '', ''),
    );
  }

  Future<String> getSWData() async {
    //print(dataArgument.idRekening);
    var res = await http.get(
        Uri.parse(
            "${URL_APP_API}/get_rekening/index_ppj.php?id_rekening=${dataArgument.idRekening}&id_daftarwp=${dataArgument.idDaftarwp}"),
        headers: {"Accept": "application/json"});
    print(json.decode(res.body));
    var resBody = json.decode(res.body);
    data_dropdown = resBody;
    update();
    // print(resBody);
    return "Sucess";
  }

  void updateValueDropdown(String value) async {
    jenisPerhitungan = "Omset";
    valuejenispajak =
        value; //value kode_rekening  sesuai jenis pajak yg dipilih
    final selectedRekPajak = await getRekPajakByKode(value);
    // print(selectedRekPajak.rumus);
    pajak = (pendapatan * double.parse(selectedRekPajak.rumus) / 100)
        .toInt(); //menghitung pajak yg sesuai jenis pajak yg dipilih
    rumus = double.parse(selectedRekPajak
        .rumus); //ganti dengan rumus yg sesuai jenis pajak yg dipilih
    tarif_persen =
        '${selectedRekPajak.rumus}%'; //ganti dengan tarif yg sesuai jenis pajak yg dipilih
    tarif_rp = int.parse(selectedRekPajak
        .tarif); //ganti dengan tarif yg sesuai jenis pajak yg dipilih
    id_rekening =
        '${selectedRekPajak.idRekening}'; //ganti id_rekening sesuai jenis pajak yg dipilih
    hitungPajak = true; //agar nilai pajak tampil di UI
    update();
  }

  void fetchdatadetail() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    var response = await http.get(Uri.parse(
        "${URL_APP_API}/get_pelaporan_admin/detail.php?id_pelaporan=${dataArgument.idPelaporan}"));

    List data = json.decode(response.body);

    id_wajib_pajak = data[0]["ID_WAJIB_PAJAK"];
    id_pelaporan = data[0]["ID_PELAPORAN"];
    id_rekening = data[0]["ID_REKENING"];
    nama_rekening = data[0]["NAMA_REKENING"];
    kode_rekening = data[0]["KODE_REKENING"];
    npwpd = data[0]["NPWPD"];
    masa_pajak2 = data[0]["MASA_PAJAK2"];
    masa_akhir2 = data[0]["MASA_AKHIR2"];
    status = data[0]["STATUS"];
    nik_user = data[0]["NIK_USER"];
    nama_usaha = data[0]["NAMA_USAHA"];
    alamat_usaha = data[0]["ALAMAT_USAHA"];
    kec_usaha = data[0]["KEC_USAHA"];
    kel_usaha = data[0]["KEL_USAHA"];
    rt_usaha = data[0]["RT_USAHA"];
    kota_usaha = data[0]["KOTA_USAHA"];
    pendapatan = int.parse(data[0]["PENDAPATAN"]);
    kwh = double.parse(data[0]["KWH"]);
    bukti = data[0]["BUKTI"];
    tarif_persen = data[0]["TARIF_PERSEN"];
    pajak = int.parse(data[0]["PAJAK"]);
    EasyLoading.dismiss();
    update();
  }

  Future VerifLaporan() async {
    //Awal Loading Disini-------------------------------
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    var request = http.MultipartRequest(
        "POST", Uri.parse("${URL_APP_API}/admin/verifikasi_pelaporan_ppj.php"));
    request.fields['id_wajib_pajak'] = id_wajib_pajak!;
    request.fields['id_pelaporan'] = id_pelaporan!;
    request.fields['id_rekening'] = id_rekening!;
    request.fields['tarif_rp'] = '${tarif_rp}';
    request.fields['tarif_persen'] = '${rumus}';
    request.fields['kode_rekening'] = kode_rekening!;
    request.fields['nama_rekening'] = nama_rekening!;
    request.fields['npwpd'] = npwpd!;
    request.fields['masa_pajak'] = masa_pajak2!;
    request.fields['masa_akhir'] = masa_akhir2!;
    request.fields['nik_user'] = nik_user!;
    request.fields['nama_usaha'] = nama_usaha!;
    request.fields['alamat_usaha'] = alamat_usaha!;
    request.fields['kec_usaha'] = kec_usaha!;
    request.fields['kel_usaha'] = kel_usaha!;
    request.fields['rt_usaha'] = rt_usaha!;
    request.fields['kota_usaha'] = kota_usaha!;
    request.fields['pendapatan'] = '${pendapatan}';
    request.fields['pajak'] = '${pajak}';
    request.fields['PPJ'] = '${PPJ}';
    request.fields['jam'] = '${jam.text}';
    request.fields['hari'] = '${hari.text}';
    request.fields['persentase'] = '${persentase.text}';
    request.fields['nik_admin'] =
        Get.parameters['authModel_nik']!; //Get.parameters['authModel_nik']!;
    request.fields['securitydouble'] = '${isChecked}';

    var response = await request.send();
    final responseData = await response.stream.toBytes();
    final respStr = String.fromCharCodes(responseData);
    EasyLoading.dismiss();
    print(respStr);

    if (response.statusCode == 200) {
      if (respStr == "Success") {
        Get.back();
        Get.back();
        DocumentSnapshot snap = await FirebaseFirestore.instance
            .collection("UserTokens")
            .doc(dataArgument.nikUser)
            .get();
        String token = snap['token'];
        sendPushMessage(
            token,
            "Pelaporan Pajak telah diverifikasi Admin, anda dapat melakukan pembayaran dengan E-Billing",
            "Buka Aplikasi untuk melihat Detailnya",
            "pelaporan_diverif");
        getDefaultDialog().onFix(
            title: "Berhasil Menyimpan Data", desc: " ", kategori: "success");
        pendataanController.refreshData();
      } else if (respStr == "sudah_ada") {
        getDefaultDialog().onFix(
            title: "Data Pelaporan Pajak ini Sudah Ada",
            desc:
                "Data Pelaporan Pajak ini Sudah Ada di Database Simpatda / Pelaporan dilakukan manual dengan menggunakan SKPD di aplikasi Simpatda",
            kategori: "error");
      } else {
        RawSnackbar_top(message: "${respStr}", kategori: "error", duration: 2);
      }
    } else {
      RawSnackbar_top(
          message: "Gagal Menyimpan Data", kategori: "error", duration: 2);
    }
  }

  Future Dikembalikan() async {
    EasyLoading.show();
    var request = http.MultipartRequest(
        "POST", Uri.parse("${baseUrlApi}/admin/dikembalikan_pelaporan.php"));
    request.fields['id_pelaporan'] = dataArgument.idPelaporan;
    request.fields['nama_usaha'] = dataArgument.namaUsaha;
    request.fields['nik'] = Get.parameters['authModel_nik']!;

    var response = await request.send();
    //final responseData = await response.stream.toBytes();
    //final respStr = String.fromCharCodes(responseData);
    if (response.statusCode == 200) {
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection("UserTokens")
          .doc(dataArgument.nikUser)
          .get();
      String token = snap['token'];
      sendPushMessage(
          token,
          "Pelaporan Pajak Anda Ditolak/Dikembalikan, disebabkan kesalahan penginputan oleh Wajib Pajak",
          "Mohon untuk Menginput Ulang Pelaporan Pajak dengan benar atau berkordinasi dengan Admin. Terima Kasih",
          "pelaporan_dikembalikan");
      EasyLoading.dismiss();
      Get.back();
      RawSnackbar_top(
          message: "Berhasil Kembalikan/Menolak Data Pelaporan Pajak",
          kategori: "success",
          duration: 2);
      pendataanController.refreshData();
    } else {
      RawSnackbar_top(
          message: "Gagal proses Penolakan Data",
          kategori: "error",
          duration: 2);
    }
  }

  void changejenisPerhitungan(String value) {
    if (value == "Omset") {
      pajak = (pendapatan * rumus / 100).toInt();
      jam.clear();
      hari.clear();
      persentase.clear();
    } else {
      double rawResult = ((kwh * tarif_rp) *
          (jam.text.isNotEmpty ? int.parse(jam.text) : 1) *
          (hari.text.isNotEmpty ? int.parse(hari.text) : 1) *
          (persentase.text.isNotEmpty ? int.parse(persentase.text) / 100 : 1) *
          rumus /
          100);

// Melakukan pembulatan ke atas sebelum dikonversi menjadi integer
      pajak = rawResult.ceil().toInt();

// ...

// Gunakan pajak2 sesuai kebutuhan Anda
      print(pajak);
    }
    jenisPerhitungan = value;

    update();
  }

  onChangedJam(valueJam) {
    pajak = ((kwh * tarif_rp) *
            int.parse(valueJam) *
            (hari.text.isNotEmpty ? int.parse(hari.text) : 1) *
            (persentase.text.isNotEmpty
                ? int.parse(persentase.text) / 100
                : 1) *
            rumus /
            100)
        .toInt();
    update();
  }

  onChangedHari(valueHari) {
    pajak = ((kwh * tarif_rp) *
            (jam.text.isNotEmpty ? int.parse(jam.text) : 1) *
            int.parse(valueHari) *
            (persentase.text.isNotEmpty
                ? int.parse(persentase.text) / 100
                : 1) *
            rumus /
            100)
        .toInt();
    update();
  }

  onChangedPersentase(valuePersentase) {
    pajak = ((kwh * tarif_rp) *
            (jam.text.isNotEmpty ? int.parse(jam.text) : 1) *
            (hari.text.isNotEmpty ? int.parse(hari.text) : 1) *
            (int.parse(valuePersentase) / 100) *
            rumus /
            100)
        .toInt();
    update();
  }

  Future CheckPembayaranQRIS() async {
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
            "kd_tagihan": "${dataArgument.nomorKohir}",
            "institusi": "${$id_institution_qris}"
          };
          var url = Uri.parse(
              "https://qris-pemda.bankaltimtara.co.id/api/qrismpm/transaction/status");
          var response =
              await http.post(url, headers: headers, body: jsonEncode(body));
          var data_QRIS = json.decode(response.body);
          if (data_QRIS['message'] == "success") {
            //jika berhasil GET REPORT STATUS PEMBAYARAN QRIS BPD SUDAH LUNAS
            responsePembayaran = json.decode(response.body);
            metodePembayaran = "qris";
            print("${data_QRIS}");
            isLoadingPembayaran = false;
            update();
            print("Pembayaran QRIS Lunas");
          } else {
            //jika GET REPORT STATUS PEMBAYARAN QRIS BPD BELUM LUNAS
            print("${data_QRIS}");
            update();
            print("QRIS Tidak ada");
          }
        } else {
          print("Gagal Perbaharui Token ke API bapenda ETAM");
          isLoadingPembayaran = false;
          update();
        }
      } else {
        print("Gagal Auth API Bankaltimtara");
        CheckPembayaranVA();
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
        "kd_tagihan": "${dataArgument.nomorKohir}",
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
        metodePembayaran = "qris";
        update();
        print("Pembayaran QRIS Lunas");
      } else {
        //jika GET REPORT STATUS PEMBAYARAN QRIS BPD BELUM LUNAS
        print("${data_QRIS}");
        print("QRIS Tidak ada");
        CheckPembayaranVA();

        update();
      }
    }
  }

  Future CheckPembayaranVA() async {
    print("Check Pembayaran VA");
    isLoadingPembayaran = true;
    var url_auth =
        Uri.parse("${URL_APP_API}/vaqris/check_auth.php?kategori=va");
    var response_auth = await http.get(url_auth);
    List data_auth = json.decode(response_auth.body);
    DateTime waktu1 = DateTime.parse(data_auth[0]["created_at"]);
    DateTime waktu2 = DateTime.now();
    print(
        'selisih ${waktu2.millisecondsSinceEpoch - waktu1.millisecondsSinceEpoch}');
    var selisih = waktu2.millisecondsSinceEpoch - waktu1.millisecondsSinceEpoch;
    if (selisih > 86400000) {
      //jika sudah melewati masa aktif Auth yaitu 1 Jam
      //auth ulang
      print("Auth Sudah tidak aktif, Auth Ulang");
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
        var url_update =
            Uri.parse("${URL_APP_API}/vaqris/update.php?kategori=va");
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
              "https://e-api.bankaltimtara.co.id:8083/api-pemda/va/paid/nova/${$id_institution_va}00000${dataArgument.nomorKohir}");
          var response = await http.get(url, headers: headers);
          var data_VA = json.decode(response.body);
          if (data_VA['message'] == "success") {
            //jika berhasil GET REPORT STATUS PEMBAYARAN VA BPD
            //Cek status lunas di simpatda
            print("${data_VA}");
            print("VA Lunas");
            // LUNASSSSSSSSSSSSSSSSSS
            responsePembayaran = json.decode(response.body);
            metodePembayaran = "va";
            isLoadingPembayaran = false;
            update();
            //End Proses Hit Callback
          } else {
            //jika GET REPORT STATUS PEMBAYARAN QRIS BPD BELUM LUNAS
            isLoadingPembayaran = false;
            update();
            print("VA Tidak ada");
          }
        } else {
          print("Gagal Perbaharui Token ke API bapenda ETAM");

          isLoadingPembayaran = false;
          update();
        }
      } else {
        print("Gagal Auth API Bankaltimtara");
        isLoadingPembayaran = false;
        update();
      }
    } else {
      //memproses check status pembayaran QRIS
      print("Masih Aktif, Get Report Status Pembayaran");
      //-------------------GET REPORT STATUS PEMBAYARAN QRIS------------------------------------
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${data_auth[0]["token"]}',
      };

      var url = Uri.parse(
          "https://e-api.bankaltimtara.co.id:8083/api-pemda/va/paid/nova/${$id_institution_va}00000${dataArgument.nomorKohir}");
      var response = await http.get(url, headers: headers);
      print(jsonEncode(response.body));
      var data_VA = json.decode(response.body);
      if (data_VA['message'] == "success") {
        //jika berhasil GET REPORT STATUS PEMBAYARAN VA BPD
        //Cek status lunas di simpatda
        //print("${data_VA}");
        print("VA Lunas");
        responsePembayaran = json.decode(response.body);
        metodePembayaran = "va";
        isLoadingPembayaran = false;

        update();

        //End Proses Hit Callack
      } else {
        print("VA Tidak ada");
        print("${data_VA}");

        isLoadingPembayaran = false;
        update();
      }
    }
  }

  void OpenFile(url_bukti) async {
    await launch(url_bukti, forceSafariVC: false);
    update();
  }

  void CheckSecurity(value) {
    isChecked = value;
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
