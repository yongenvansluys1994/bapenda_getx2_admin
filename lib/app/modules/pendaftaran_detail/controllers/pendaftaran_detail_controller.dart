import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/app/modules/pendaftaran/controllers/pendaftaran_controller.dart';
import 'package:bapenda_getx2_admin/app/modules/pendaftaran/models/model_getpendaftaran.dart';
import 'package:bapenda_getx2_admin/core/push_notification/push_notif_single.dart';
import 'package:bapenda_getx2_admin/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class PendaftaranDetailController extends GetxController {
  final daftarController = Get.find<PendaftaranController>();
  late ModelGetPendaftaran dataArgument;

  double? lat;
  double? long;
  int activeStepIndex = 0;
  XFile? imageFileKTP = null;
  XFile? imageFileNPWP = null;

  TextEditingController nama_usaha = TextEditingController();
  TextEditingController alamat_usaha = TextEditingController();
  TextEditingController rt_usaha = TextEditingController();
  TextEditingController kota_usaha = TextEditingController();
  TextEditingController nohp_usaha = TextEditingController();
  TextEditingController email_usaha = TextEditingController();
  TextEditingController nama_pemilik = TextEditingController();
  TextEditingController pekerjaan_pemilik = TextEditingController();
  TextEditingController alamat_pemilik = TextEditingController();
  TextEditingController rt_pemilik = TextEditingController();
  TextEditingController kota_pemilik = TextEditingController();
  TextEditingController nohp_pemilik = TextEditingController();
  TextEditingController email_pemilik = TextEditingController();
  TextEditingController kel_pemilik = TextEditingController();
  TextEditingController kec_pemilik = TextEditingController();

  Set<Marker> markers2 = <Marker>{};

  void addMarkers() {
    var latm = lat == null ? 0.13295280196348974 : lat!;
    var longm = long == null ? 0.13295280196348974 : long!;
    markers2 = <Marker>{
      Marker(
        markerId: MarkerId('1'),
        position: LatLng(latm, longm),
      ),
    };
    update();
  }

  bool buttonsalin = false;
  String? ValueKelurahan;
  String? ValueKecamatan;

  Future<void> salin() async {
    buttonsalin = true;
    rt_pemilik.text = rt_usaha.text;
    kota_pemilik.text = kota_usaha.text;
    nohp_pemilik.text = nohp_usaha.text;
    email_pemilik.text = email_usaha.text;
    update();
  }

  Future<void> hapussalin() async {
    buttonsalin = false;
    rt_pemilik.text = "";
    kota_pemilik.text = "";
    nohp_pemilik.text = "";
    email_pemilik.text = "";
    update();
  }

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    dataArgument = Get.arguments;
    nama_usaha.text = dataArgument.namaUsaha;
    alamat_usaha.text = dataArgument.alamatUsaha;
    rt_usaha.text = dataArgument.rtUsaha;
    kota_usaha.text = dataArgument.kotaUsaha;
    nohp_usaha.text = dataArgument.nohpUsaha;
    email_usaha.text = dataArgument.emailUsaha;
    nama_pemilik.text = dataArgument.namaPemilik;
    pekerjaan_pemilik.text = dataArgument.pekerjaanPemilik;
    alamat_pemilik.text = dataArgument.alamatPemilik;
    rt_pemilik.text = dataArgument.rtPemilik;
    kota_pemilik.text = dataArgument.kotaPemilik;
    nohp_pemilik.text = dataArgument.nohpPemilik;
    email_pemilik.text = dataArgument.emailPemilik;
    kel_pemilik.text = dataArgument.kelPemilik;
    kec_pemilik.text = dataArgument.kecPemilik;
    ValueKelurahan = dataArgument.kelUsaha;
    ValueKecamatan = dataArgument.kecUsaha;
    lat = double.parse(dataArgument.lat);
    long = double.parse(dataArgument.lng);
    update();
  }

  Future ValidasiDaftar() async {
    //Awal Loading Disini-------------------------------
    EasyLoading.show();
    var request = http.MultipartRequest(
        "POST", Uri.parse("${baseUrlApi}/admin/validasi_daftar.php"));
    request.fields['id_daftarwp'] = dataArgument.idDaftarwp;
    request.fields['id_wajib_pajak'] = dataArgument.idWajibPajak;
    request.fields['nik'] = dataArgument.nikUser;
    request.fields['npwpd'] = dataArgument.npwpd;
    request.fields['nama_usaha'] = dataArgument.namaUsaha;
    request.fields['alamat_usaha'] = dataArgument.alamatUsaha;
    request.fields['rt_usaha'] = dataArgument.rtUsaha;
    request.fields['kel_usaha'] = dataArgument.kelUsaha;
    request.fields['kec_usaha'] = dataArgument.kecUsaha;
    request.fields['kota_usaha'] = dataArgument.kotaUsaha;
    request.fields['nohp_usaha'] = dataArgument.nohpUsaha;
    request.fields['email_usaha'] = dataArgument.emailUsaha;
    request.fields['jenispajak'] = dataArgument.jenispajak;
    request.fields['nama_pemilik'] = dataArgument.namaPemilik;
    request.fields['pekerjaan_pemilik'] = dataArgument.pekerjaanPemilik;
    request.fields['alamat_pemilik'] = dataArgument.alamatPemilik;
    request.fields['rt_pemilik'] = dataArgument.rtPemilik;
    request.fields['kel_pemilik'] = dataArgument.kelPemilik;
    request.fields['kec_pemilik'] = dataArgument.kecPemilik;
    request.fields['kota_pemilik'] = dataArgument.kotaPemilik;
    request.fields['nohp_pemilik'] = dataArgument.nohpPemilik;
    request.fields['email_pemilik'] = dataArgument.emailPemilik;
    request.fields['lat'] = dataArgument.lat;
    request.fields['long'] = dataArgument.lng;
    request.fields['status'] = dataArgument.status;
    request.fields['nik_admin'] = Get.parameters['authModel_nik']!;

    var response = await request.send();
    final responseData = await response.stream.toBytes();
    final respStr = String.fromCharCodes(responseData);
    EasyLoading.dismiss();

    if (response.statusCode == 200) {
      if (respStr == "Success_Lama") {
        DocumentSnapshot snap = await FirebaseFirestore.instance
            .collection("UserTokens")
            .doc(dataArgument.nikUser)
            .get();
        String token = snap['token'];
        sendPushMessage(
            token,
            "Pendaftaran Wajib Pajak telah Divalidasi Petugas Bapenda Bontang",
            "Buka Aplikasi untuk melihat Detailnya",
            "pendaftaran_diverif");
        Get.back();
        RawSnackbar_top(
            message: "Berhasil Verifikasi Data Wajib Pajak",
            kategori: "success",
            duration: 2);
        daftarController.refreshData();
      } else if (respStr == "Success") {
        DocumentSnapshot snap = await FirebaseFirestore.instance
            .collection("UserTokens")
            .doc(dataArgument.nikUser)
            .get();
        String token = snap['token'];
        sendPushMessage(
            token,
            "Pendaftaran Wajib Pajak telah Divalidasi Petugas Bapenda Bontang",
            "Buka Aplikasi untuk melihat Detailnya",
            "pendaftaran_diverif");
        Get.back();
        RawSnackbar_top(
            message: "Berhasil Verifikasi Data Wajib Pajak",
            kategori: "success",
            duration: 2);
        daftarController.refreshData();
      } else {
        RawSnackbar_top(message: respStr, kategori: "error", duration: 2);
      }
    } else {
      RawSnackbar_top(
          message: "Gagal Menyimpan Data", kategori: "error", duration: 2);
    }
  }

  Future Dikembalikan() async {
    EasyLoading.show();
    var request = http.MultipartRequest(
        "POST", Uri.parse("${baseUrlApi}/admin/dikembalikan_daftar.php"));
    request.fields['id_daftarwp'] = dataArgument.idDaftarwp;
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
          "Pendaftaran Wajib Pajak Anda Ditolak/Dikembalikan, disebabkan kesalahan penginputan oleh Wajib Pajak",
          "Mohon untuk Memperbaiki data yang belum lengkap atau salah, Terima kasih.",
          "pendaftaran_dikembalikan");
      EasyLoading.dismiss();
      Get.back();
      RawSnackbar_top(
          message: "Berhasil Kembalikan/Menolak Data Wajib Pajak",
          kategori: "success",
          duration: 2);
      daftarController.refreshData();
    } else {
      RawSnackbar_top(
          message: "Gagal proses Penolakan Data",
          kategori: "error",
          duration: 2);
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
