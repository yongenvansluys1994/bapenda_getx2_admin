import 'package:bapenda_getx2_admin/app/core/api/api.dart';
import 'package:bapenda_getx2_admin/app/routes/app_pages.dart';
import 'package:bapenda_getx2_admin/widgets/easythrottle.dart';
import 'package:bapenda_getx2_admin/widgets/getdialog.dart';
import 'package:bapenda_getx2_admin/widgets/shimmer.dart';
import 'package:bapenda_getx2_admin/widgets/snackbar.dart';
import 'package:bapenda_getx2_admin/widgets/texts.dart';
import 'package:bapenda_getx2_admin/widgets/theme/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
          title: const Text('USAHA'),
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
          title: const Text('PEMILIK'),
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
          title: const Text('LOKASI'),
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
            "Lengkapi Data Wajib Pajak",
            style: TextStyle(color: MainColor),
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
        body: GetBuilder<PendaftaranDetailController>(
          init: PendaftaranDetailController(),
          builder: (controller) {
            return Stepper(
              type: StepperType.horizontal,
              currentStep: controller.activeStepIndex,
              steps: stepList(),
              onStepContinue: () {
                if (controller.activeStepIndex < (stepList().length - 1)) {
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
                final isLastStep =
                    controller.activeStepIndex == stepList().length - 1;
                return Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (isLastStep)
                              ? controller.dataArgument.status == "1"
                                  ? SizedBox()
                                  : SizedBox(
                                      width: 150.w,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            if (controller
                                                        .rt_usaha.text ==
                                                    "" ||
                                                controller
                                                        .kota_usaha.text ==
                                                    "" ||
                                                controller
                                                        .nohp_usaha.text ==
                                                    "" ||
                                                controller
                                                        .email_usaha.text ==
                                                    "" ||
                                                controller
                                                        .pekerjaan_pemilik.text ==
                                                    "" ||
                                                controller
                                                        .kec_pemilik.text ==
                                                    "" ||
                                                controller
                                                        .kel_pemilik.text ==
                                                    "" ||
                                                controller.alamat_pemilik.text ==
                                                    "" ||
                                                controller.rt_pemilik.text ==
                                                    "" ||
                                                controller.kota_pemilik.text ==
                                                    "" ||
                                                controller.nohp_pemilik.text ==
                                                    "" ||
                                                controller.email_pemilik.text ==
                                                    "") {
                                              RawSnackbar_top(
                                                  message:
                                                      'Semua Form Wajib diisi! \nSilahkan Periksa Kembali',
                                                  kategori: "error",
                                                  duration: 2);
                                            } else {
                                              getDefaultDialog().onConfirm(
                                                  title:
                                                      "Verifikasi Data Wajib Pajak",
                                                  desc:
                                                      "Pastikan anda telah memastikan data sudah benar",
                                                  kategori: "warning",
                                                  handler: () {
                                                    Get.back();
                                                    easyThrottle(
                                                      handler: () {
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
                                                MaterialStateProperty.all<
                                                    Color>(lightBlueColor),
                                          ),
                                          child: Text(
                                            'Setujui Pendaftaran',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                            ),
                                          )),
                                    )
                              : SizedBox(
                                  width: 140,
                                  child: ElevatedButton(
                                      onPressed: controls.onStepContinue,
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                lightBlueColor),
                                      ),
                                      child: Text(
                                        'Selanjutnya',
                                        style: TextStyle(fontSize: 14),
                                      )),
                                ),
                          const SizedBox(
                            width: 10,
                          ),
                          if (controller.activeStepIndex > 0)
                            SizedBox(
                              width: 100,
                              child: ElevatedButton(
                                  onPressed: controls.onStepCancel,
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            veryLightTextColor),
                                  ),
                                  child: Text(
                                    'Kembali',
                                    style: TextStyle(fontSize: 14),
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
                                            MaterialStateProperty.all<Color>(
                                                Color.fromARGB(
                                                    255, 247, 207, 30)),
                                      ),
                                      child: Text(
                                        'Dikembalikan/Ditolak',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.black),
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
      ),
    );
  }
}
