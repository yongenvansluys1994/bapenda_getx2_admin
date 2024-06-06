import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/app/modules/pendaftaran_detail/controllers/pelaporan_history_controller.dart';
import 'package:bapenda_getx2_admin/app/modules/pendaftaran_detail/views/histori_pajak.dart';
import 'package:bapenda_getx2_admin/app/modules/pendaftaran_detail/views/histori_pajak2.dart';
import 'package:bapenda_getx2_admin/app/modules/pendaftaran_detail/views/histori_pajak3.dart';
import 'package:bapenda_getx2_admin/app/modules/pendaftaran_detail/views/histori_pajak4.dart';
import 'package:bapenda_getx2_admin/app/modules/pendaftaran_detail/views/histori_pajak5.dart';
import 'package:bapenda_getx2_admin/app/routes/app_pages.dart';
import 'package:bapenda_getx2_admin/widgets/easythrottle.dart';
import 'package:bapenda_getx2_admin/widgets/getdialog.dart';
import 'package:bapenda_getx2_admin/widgets/shimmer.dart';
import 'package:bapenda_getx2_admin/widgets/snackbar.dart';
import 'package:bapenda_getx2_admin/widgets/texts.dart';
import 'package:bapenda_getx2_admin/widgets/theme/app_theme.dart';
import 'package:bapenda_getx2_admin/widgets/utils/helper/responsive_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';

import '../controllers/pendaftaran_detail_controller.dart';

class PendaftaranDetailView extends StatefulWidget {
  const PendaftaranDetailView({Key? key}) : super(key: key);

  @override
  _PendaftaranDetailViewState createState() => _PendaftaranDetailViewState();
}

class _PendaftaranDetailViewState extends State<PendaftaranDetailView> {
  final controller = Get.find<PendaftaranDetailController>();

  bool buttonsalin = false;

  @override
  void initState() {
    super.initState();
  }

  List<Step> stepList() => [
        Step(
          state: controller.activeStepIndex <= 0
              ? StepState.editing
              : StepState.complete,
          isActive: controller.activeStepIndex >= 0,
          title: Text(
            'USAHA',
            style:
                TextStyle(fontSize: ResponsiveHelper.isTablet() ? 10.sp : null),
          ),
          content: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      offset: Offset(8, 6),
                      color: lightGreenColor.withOpacity(0.3)),
                  BoxShadow(
                      blurRadius: 10,
                      offset: Offset(-1, -5),
                      color: lightGreenColor.withOpacity(0.3))
                ]),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Texts.body2("Nama Usaha :"),
                    ),
                    Container(
                      child: TextFormField(
                        style: TextStyle(fontSize: 12.sp),
                        controller: controller.nama_usaha,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.fromLTRB(20.r, 20.r, 20.r, 0),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: '',
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: lightGreenColor, width: 2),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 164, 186, 206),
                          blurRadius: 5,
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Texts.body2("Alamat :"),
                        ],
                      ),
                    ),
                    Container(
                      child: TextFormField(
                        style: TextStyle(fontSize: 12.sp),
                        controller: controller.alamat_usaha,
                        minLines:
                            2, // any number you need (It works as the rows for the textarea)
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.fromLTRB(20.r, 20.r, 20.r, 0),
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: lightGreenColor, width: 2),
                          ),
                        ),
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return "Data harus diisi";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                      ),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 164, 186, 206),
                          blurRadius: 5,
                        ),
                      ]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Texts.body2("RT :"),
                              ),
                              Container(
                                child: TextFormField(
                                  style: TextStyle(fontSize: 12.sp),
                                  controller: controller.rt_usaha,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: '',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 251, 161, 161),
                                          width: 2.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Texts.body2("Kota :"),
                              ),
                              Container(
                                child: TextFormField(
                                  style: TextStyle(fontSize: 12.sp),
                                  controller: controller.kota_usaha,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: '',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 251, 161, 161),
                                          width: 2.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Texts.body2("Kelurahan :"),
                                  ],
                                ),
                              ),
                              Container(
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                    enabled: true,
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor:
                                        Color.fromARGB(255, 238, 238, 238),
                                    filled: true,
                                    hintText: '',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 0.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: controller.ValueKelurahan,
                                      isDense: true,
                                      isExpanded: true,
                                      onChanged: (String? newValue) {
                                        // setState(() {
                                        //   ValueKelurahan = newValue!;
                                        // });
                                      },
                                      items: <String>[
                                        'LUAR KOTA',
                                        'LOK TUAN',
                                        'BONTANG BARU',
                                        'BONTANG KUALA',
                                        'API-API',
                                        'GUNUNG ELAI',
                                        'GUNTUNG',
                                        'TANJUNG LAUT',
                                        'SATIMPO',
                                        'BERBAS TENGAH',
                                        'BERBAS PANTAI',
                                        'BONTANG LESTARI',
                                        'TJ. LAUT INDAH',
                                        'BELIMBING',
                                        'TELIHAN',
                                        'KANAAN',
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(fontSize: 10.5.sp),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Texts.body2("Kecamatan :"),
                                  ],
                                ),
                              ),
                              Container(
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                    enabled: true,
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor:
                                        Color.fromARGB(255, 238, 238, 238),
                                    filled: true,
                                    hintText: '',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 0.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: controller.ValueKecamatan,
                                      isDense: true,
                                      isExpanded: true,
                                      onChanged: (String? newValue) {
                                        // setState(() {
                                        //   ValueKecamatan = newValue!;
                                        // });
                                      },
                                      items: <String>[
                                        'LUAR KOTA',
                                        'BONTANG UTARA',
                                        'BONTANG SELATAN',
                                        'BONTANG BARAT',
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(fontSize: 10.5.sp),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Texts.body2("No HP :"),
                              ),
                              Container(
                                child: TextFormField(
                                  style: TextStyle(fontSize: 12.sp),
                                  controller: controller.nohp_usaha,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: '',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 251, 161, 161),
                                          width: 2.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Texts.body2("Email :"),
                              ),
                              Container(
                                child: TextFormField(
                                  style: TextStyle(fontSize: 12.sp),
                                  controller: controller.email_usaha,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: '',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 251, 161, 161),
                                          width: 2.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Step(
          state: controller.activeStepIndex <= 1
              ? StepState.editing
              : StepState.complete,
          isActive: controller.activeStepIndex >= 1,
          title: Text('PEMILIK',
              style: TextStyle(
                  fontSize: ResponsiveHelper.isTablet() ? 10.sp : null)),
          content: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      offset: Offset(8, 6),
                      color: lightGreenColor.withOpacity(0.3)),
                  BoxShadow(
                      blurRadius: 10,
                      offset: Offset(-1, -5),
                      color: lightGreenColor.withOpacity(0.3))
                ]),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Texts.body2("Nama Pemilik/Pengelola :"),
                        ),
                      ],
                    ),
                    Container(
                      child: TextFormField(
                        style: TextStyle(fontSize: 12.sp),
                        controller: controller.nama_pemilik,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.fromLTRB(20.r, 20.r, 20.r, 0),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: '',
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: lightGreenColor, width: 2),
                          ),
                        ),
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return "Data harus diisi";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                      ),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 164, 186, 206),
                          blurRadius: 5,
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Texts.body2("Pekerjaan/Jabatan :"),
                    ),
                    Container(
                      child: TextFormField(
                        style: TextStyle(fontSize: 12.sp),
                        controller: controller.pekerjaan_pemilik,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.fromLTRB(20.r, 20.r, 20.r, 0),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: '',
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 251, 161, 161),
                                width: 2.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: lightGreenColor, width: 2),
                          ),
                        ),
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return "Data harus diisi";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                      ),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 164, 186, 206),
                          blurRadius: 5,
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Texts.body2("Alamat :"),
                        ],
                      ),
                    ),
                    Container(
                      child: TextFormField(
                        style: TextStyle(fontSize: 12.sp),
                        controller: controller.alamat_pemilik,
                        minLines:
                            3, // any number you need (It works as the rows for the textarea)
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.fromLTRB(12.r, 12.r, 12.r, 0),
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: lightGreenColor, width: 2),
                          ),
                        ),
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return "Data harus diisi";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                      ),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 164, 186, 206),
                          blurRadius: 5,
                        ),
                      ]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Texts.body2("RT"),
                              ),
                              Container(
                                child: TextFormField(
                                  style: TextStyle(fontSize: 12.sp),
                                  controller: controller.rt_pemilik,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: '',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 251, 161, 161),
                                          width: 2.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Texts.body2("Kota :"),
                              ),
                              Container(
                                child: TextFormField(
                                  style: TextStyle(fontSize: 12.sp),
                                  controller: controller.kota_pemilik,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: '',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 251, 161, 161),
                                          width: 2.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Texts.body2("Kelurahan :"),
                                  ],
                                ),
                              ),
                              Container(
                                child: TextFormField(
                                  style: TextStyle(fontSize: 12.sp),
                                  controller: controller.kel_pemilik,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 0.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return "Data harus diisi";
                                  //   } else {
                                  //     return null;
                                  //   }
                                  // },
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Texts.body2("Kecamatan :"),
                                  ],
                                ),
                              ),
                              Container(
                                child: TextFormField(
                                  style: TextStyle(fontSize: 12.sp),
                                  controller: controller.kec_pemilik,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 0.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return "Data harus diisi";
                                  //   } else {
                                  //     return null;
                                  //   }
                                  // },
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Texts.body2("No HP :"),
                              ),
                              Container(
                                child: TextFormField(
                                  style: TextStyle(fontSize: 12.sp),
                                  controller: controller.nohp_pemilik,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: '',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 251, 161, 161),
                                          width: 2.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Texts.body2("Email :"),
                              ),
                              Container(
                                child: TextFormField(
                                  style: TextStyle(fontSize: 12.sp),
                                  controller: controller.email_pemilik,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.r, 20.r, 20.r, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: '',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 251, 161, 161),
                                          width: 2.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Center(child: Texts.body2("Upload KTP :")),
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.DETAIL_SCREEN,
                                    arguments:
                                        controller.dataArgument.imageKtp);
                              },
                              child: ClipRRect(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "${URL_APP}/upload/${controller.dataArgument.imageKtp}",
                                  width: 80,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      ShimmerWidget.rectangular(
                                    width: 80.h,
                                    height: 60.h,
                                    baseColor: shadowColor,
                                  ),
                                  errorWidget: ((context, url, error) =>
                                      Image.asset(
                                        'images/image.png',
                                        fit: BoxFit.cover,
                                        width: 80.h,
                                        height: 60.h,
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child:
                                    Center(child: Texts.body2("Upload NPWP :")),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.DETAIL_SCREEN,
                                      arguments:
                                          controller.dataArgument.imageNpwp);
                                },
                                child: ClipRRect(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "${URL_APP}/upload/${controller.dataArgument.imageNpwp}",
                                    width: 80,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        ShimmerWidget.rectangular(
                                      width: 80.h,
                                      height: 60.h,
                                      baseColor: shadowColor,
                                    ),
                                    errorWidget: ((context, url, error) =>
                                        Image.asset(
                                          'images/image.png',
                                          fit: BoxFit.cover,
                                          width: 80.h,
                                          height: 60.h,
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Step(
          state: StepState.complete,
          isActive: controller.activeStepIndex >= 2,
          title: Text('LOKASI',
              style: TextStyle(
                  fontSize: ResponsiveHelper.isTablet() ? 10.sp : null)),
          content: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      offset: Offset(8, 6),
                      color: lightGreenColor.withOpacity(0.3)),
                  BoxShadow(
                      blurRadius: 10,
                      offset: Offset(-1, -5),
                      color: lightGreenColor.withOpacity(0.3))
                ]),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    "Titik Lokasi Objek Pajak ",
                    style: TextStyle(
                        color: MainColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  GetBuilder<PendaftaranDetailController>(
                    init: PendaftaranDetailController(),
                    builder: (controller) {
                      return SizedBox(
                        height: 400.h,
                        child: controller.lat == null
                            ? SizedBox()
                            : GoogleMap(
                                markers: controller.markers2,
                                mapType: MapType.hybrid,
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                      controller.lat == null
                                          ? 0.13295280196348974
                                          : controller.lat!,
                                      controller.long == null
                                          ? 117.47944742888573
                                          : controller.long!),
                                  zoom: 18,
                                ),
                                onMapCreated:
                                    (GoogleMapController controllers) {
                                  controller.addMarkers();
                                },
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        )
      ];
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        extendBodyBehindAppBar: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: MainColor //change your color here
              ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Data Wajib Pajak",
            style: TextStyle(
                color: MainColor,
                fontSize: ResponsiveHelper.isTablet() ? 11.sp : null),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 7),
              child: PopupMenuButton(
                  // add icon, by default "3 dot" icon
                  icon: const Icon(
                    Icons.account_circle,
                    color: textColor,
                    size: 41,
                  ),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem<int>(
                        value: 0,
                        child: Text("My Profile"),
                      ),
                      PopupMenuItem<int>(
                        value: 1,
                        child: Text("Logout"),
                      ),
                    ];
                  },
                  onSelected: (value) {
                    if (value == 0) {
                      print("My account menu is selected.");
                    } else if (value == 1) {}
                  }),
            ),
          ],
        ),
        body: GestureDetector(
          child: PageView(
            controller: controller.pageController,
            onPageChanged: (int page) {
              controller.currentPage = page;
              controller.swipePage();
            },
            children: [
              Stack(
                children: [
                  GetBuilder<PendaftaranDetailController>(
                    init: PendaftaranDetailController(),
                    builder: (controller) {
                      return Stepper(
                        type: StepperType.horizontal,
                        currentStep: controller.activeStepIndex,
                        steps: stepList(),
                        onStepContinue: () {
                          if (controller.activeStepIndex <
                              (stepList().length - 1)) {
                            setState(() {
                              controller.activeStepIndex += 1;
                            });
                          } else {
                            print('Submited');
                          }
                        },
                        onStepCancel: () {
                          if (controller.activeStepIndex == 0) {
                            return;
                          }
                          setState(() {
                            controller.activeStepIndex -= 1;
                          });
                        },
                        onStepTapped: (int index) {
                          setState(() {
                            controller.activeStepIndex = index;
                          });
                        },
                        controlsBuilder:
                            (BuildContext context, ControlsDetails controls) {
                          final isLastStep = controller.activeStepIndex ==
                              stepList().length - 1;
                          return Container(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    (isLastStep)
                                        ? controller.dataArgument.status == "1"
                                            ? SizedBox()
                                            : controller.authModel_no_hp !=
                                                    "admin"
                                                ? SizedBox()
                                                : SizedBox(
                                                    width: 150.w,
                                                    height: Get.height * 0.04,
                                                    child: ElevatedButton(
                                                        onPressed: () {
                                                          if (controller
                                                                      .rt_usaha
                                                                      .text ==
                                                                  "" ||
                                                              controller
                                                                      .kota_usaha
                                                                      .text ==
                                                                  "" ||
                                                              controller
                                                                      .nohp_usaha
                                                                      .text ==
                                                                  "" ||
                                                              controller
                                                                      .email_usaha
                                                                      .text ==
                                                                  "" ||
                                                              controller
                                                                      .pekerjaan_pemilik
                                                                      .text ==
                                                                  "" ||
                                                              controller
                                                                      .kec_pemilik
                                                                      .text ==
                                                                  "" ||
                                                              controller
                                                                      .kel_pemilik
                                                                      .text ==
                                                                  "" ||
                                                              controller
                                                                      .alamat_pemilik
                                                                      .text ==
                                                                  "" ||
                                                              controller
                                                                      .rt_pemilik
                                                                      .text ==
                                                                  "" ||
                                                              controller
                                                                      .kota_pemilik
                                                                      .text ==
                                                                  "" ||
                                                              controller
                                                                      .nohp_pemilik
                                                                      .text ==
                                                                  "" ||
                                                              controller
                                                                      .email_pemilik
                                                                      .text ==
                                                                  "") {
                                                            RawSnackbar_top(
                                                                message:
                                                                    'Semua Form Wajib diisi! \nSilahkan Periksa Kembali',
                                                                kategori:
                                                                    "error",
                                                                duration: 2);
                                                          } else {
                                                            getDefaultDialog()
                                                                .onConfirm(
                                                                    title:
                                                                        "Verifikasi Data Wajib Pajak",
                                                                    desc:
                                                                        "Pastikan anda telah memastikan data sudah benar",
                                                                    kategori:
                                                                        "warning",
                                                                    handler:
                                                                        () {
                                                                      Get.back();
                                                                      easyThrottle(
                                                                        handler:
                                                                            () {
                                                                          controller
                                                                              .ValidasiDaftar();
                                                                        },
                                                                      );
                                                                    });
                                                            //controller.ValidasiDaftar();
                                                          }
                                                        },
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                                      lightBlueColor),
                                                        ),
                                                        child: Text(
                                                          'Setujui Pendaftaran',
                                                          style: TextStyle(
                                                            fontSize:
                                                                ResponsiveHelper
                                                                        .isTablet()
                                                                    ? 11.sp
                                                                    : null,
                                                          ),
                                                        )),
                                                  )
                                        : SizedBox(
                                            width: Get.width * 0.3,
                                            height: Get.height * 0.04,
                                            child: ElevatedButton(
                                                onPressed:
                                                    controls.onStepContinue,
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          lightBlueColor),
                                                ),
                                                child: Text(
                                                  'Selanjutnya',
                                                  style: TextStyle(
                                                      fontSize: ResponsiveHelper
                                                              .isTablet()
                                                          ? 11.5.sp
                                                          : null),
                                                )),
                                          ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    if (controller.activeStepIndex > 0)
                                      SizedBox(
                                        width: Get.width * 0.3,
                                        height: Get.height * 0.04,
                                        child: ElevatedButton(
                                            onPressed: controls.onStepCancel,
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      veryLightTextColor),
                                            ),
                                            child: Text(
                                              'Kembali',
                                              style: TextStyle(
                                                  fontSize: ResponsiveHelper
                                                          .isTablet()
                                                      ? 11.sp
                                                      : null),
                                            )),
                                      ),
                                  ],
                                ),
                                (isLastStep)
                                    ? controller.dataArgument.status == "1"
                                        ? SizedBox()
                                        : SizedBox(
                                            width: 160.w,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  controller.Dikembalikan();
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Color.fromARGB(255,
                                                              247, 207, 30)),
                                                ),
                                                child: Text(
                                                  'Dikembalikan/Ditolak',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                )),
                                          )
                                    : SizedBox()
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  swipeLeft(controller: controller),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       controller.visibleswpe();
                  //     },
                  //     child: Text("Test"))
                ],
              ),
              HistoryPembayaran(
                  idWajibPajak: controller.dataArgument.idWajibPajak,
                  controller1: controller),
            ],
          ),
        ),
      ),
    );
  }
}

class swipeLeft extends StatelessWidget {
  final PendaftaranDetailController controller;
  const swipeLeft({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PendaftaranDetailController>(
      init: PendaftaranDetailController(),
      builder: (controller) {
        return Positioned(
          right: 0,
          bottom: 35.r,
          child: AnimatedOpacity(
            curve: Curves.linear,
            opacity: controller.isVisibleSwipe ? 1.0 : 0.0,
            duration: Duration(milliseconds: 700),
            child: Container(
              height: 110.h,
              width: 130.w,
              child: Stack(
                children: [
                  Positioned(
                    top: 30.h,
                    right: 0,
                    child: Container(
                      height: Get.width * 0.085,
                      width: 125.w,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: gradientColor),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(48),
                            bottomLeft: Radius.circular(48),
                            bottomRight: Radius.circular(7),
                            topRight: Radius.circular(7),
                          ),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 7,
                                offset: Offset(5, 5),
                                color: lightBlueColor.withOpacity(0.4)),
                            BoxShadow(
                                blurRadius: 7,
                                offset: Offset(-2, -2),
                                color: lightBlueColor.withOpacity(0.4))
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Texts.captionSm("Riwayat",
                                  textAlign: TextAlign.right,
                                  color: Colors.white),
                              Texts.captionSm("Pembayaran ",
                                  textAlign: TextAlign.right,
                                  color: Colors.white),
                            ],
                          ),
                          SizedBox(
                            width: 3.w,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 7.r,
                    left: 7.r,
                    child: SizedBox(
                        child: Lottie.asset('assets/lottie/swipeleft.json',
                            fit: BoxFit.fill, height: 65.h)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class HistoryPembayaran extends StatelessWidget {
  final PendaftaranDetailController controller1;
  final String idWajibPajak;
  const HistoryPembayaran(
      {super.key, required this.idWajibPajak, required this.controller1});

  @override
  Widget build(BuildContext context) {
    double initialX = 0.0;
    return GetBuilder<PelaporanHistoryController>(
        init: PelaporanHistoryController(Get.find<Api>()),
        builder: (controller) {
          final List<Tab> Tabs = <Tab>[
            //5 tahun terakhir
            Tab(
              child: Text(
                "${controller.tahunhistory[0]}",
                style: TextStyle(fontSize: 11.sp), // Ubah ukuran font di sini
              ),
            ),
            Tab(
              child: Text(
                "${controller.tahunhistory[1]}",
                style: TextStyle(fontSize: 11.sp), // Ubah ukuran font di sini
              ),
            ),
            Tab(
              child: Text(
                "${controller.tahunhistory[2]}",
                style: TextStyle(fontSize: 11.sp), // Ubah ukuran font di sini
              ),
            ),
            Tab(
              child: Text(
                "${controller.tahunhistory[3]}",
                style: TextStyle(fontSize: 11.sp), // Ubah ukuran font di sini
              ),
            ),
            Tab(
              child: Text(
                "${controller.tahunhistory[4]}",
                style: TextStyle(fontSize: 11.sp), // Ubah ukuran font di sini
              ),
            ),
          ];
          return SingleChildScrollView(
            child: DefaultTabController(
              length: 5, // Number of tabs
              child: Builder(builder: (BuildContext context) {
                final TabController tabController =
                    DefaultTabController.of(context);
                return Column(
                  children: [
                    TabBar(
                      labelColor: lightBlueColor,
                      unselectedLabelColor: MainColor,
                      indicatorColor: lightBlueColor,
                      //isScrollable: true,
                      tabs: Tabs,
                    ),
                    SizedBox(
                      height: (Get.height * 0.135) *
                          12, // Adjust the height as needed
                      child: Listener(
                        onPointerDown: (PointerDownEvent event) {
                          initialX = event.position.dx;
                        },
                        onPointerUp: (PointerUpEvent event) {
                          double dx = event.position.dx - initialX;
                          if (dx > 0) {
                            // If dx is negative, it's a swipe left
                            if (tabController.index == 0) {
                              controller1.pageController.previousPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            }
                          }
                        },
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            HistoryPajak(id_wajib_pajak: idWajibPajak),
                            HistoryPajak2(id_wajib_pajak: idWajibPajak),
                            HistoryPajak3(id_wajib_pajak: idWajibPajak),
                            HistoryPajak4(id_wajib_pajak: idWajibPajak),
                            HistoryPajak5(id_wajib_pajak: idWajibPajak),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          );
        });
  }
}
