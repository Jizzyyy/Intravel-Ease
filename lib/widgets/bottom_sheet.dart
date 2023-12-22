import 'dart:async';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:intravel_ease/configs/app_color.dart';
import 'package:intravel_ease/configs/font_family.dart';
import 'package:intravel_ease/models/model_shared_preferences/agenda_model.dart';
import 'package:intravel_ease/models/wisatas/wisata_model_detail.dart';
import 'package:intravel_ease/public_providers/public_two_provider%20.dart';
import 'package:intravel_ease/widgets/text_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListBottomSheet extends StatefulWidget {
  const ListBottomSheet({super.key});

  @override
  State<ListBottomSheet> createState() => _ListBottomSheetState();
}

class _ListBottomSheetState extends State<ListBottomSheet> {
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _tglController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  int _selectedColor = 0;
  DateTime _selectedDate = DateTime.now();
  Time _time = Time(hour: 7, minute: 0);
  Time _time2 = Time(hour: 8, minute: 0);

  String? _validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Deskripsi tidak boleh kosong';
    } else if (value.length > 150) {
      return 'Deskripsi maksimal 150 huruf';
    }
    return null;
  }

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
    });
  }

  void onTimeChanged2(Time newTime) {
    setState(() {
      _time2 = newTime;
    });
  }

  // Method

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2030));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String dateString = _pickerDate.toString();
    prefs.setString('selected_date', dateString);

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      ("Error!");
    }
  }

  _validateDate() async {
    if (_descController.text.isNotEmpty ||
        _tglController.text.isNotEmpty ||
        _startTimeController.text.isNotEmpty ||
        _endTimeController.text.isNotEmpty) {
      addListItinerary(context);
      await EasyLoading.show(
        status: 'Tunggu Yaa..',
        maskType: EasyLoadingMaskType.clear,
      );
      await Future.delayed(const Duration(seconds: 1));
      EasyLoading.dismiss();
      await EasyLoading.showSuccess('Berhasil Menambahkan Agenda',
          duration: const Duration(seconds: 1));
      // await Future.delayed(const Duration(seconds: 2));
      Navigator.pop(context);
    } else if (_descController.text.isEmpty ||
        _tglController.text.isEmpty ||
        _startTimeController.text.isEmpty ||
        _endTimeController.text.isEmpty) {
      AnimatedSnackBar.material(
        'Isi Semua Field !',
        type: AnimatedSnackBarType.warning,
        duration: const Duration(seconds: 4),
        desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
      ).show(context);
    }
  }

  WisataModelDetail? modelDetail;
  AgendaModel? modelAgenda;
  void addListItinerary(BuildContext context) async {
    final test = Provider.of<PublicTwoProvider>(context, listen: false);
    AgendaModel agendaModel = AgendaModel(
      // id:modelAgenda?.id.toString(),
      id: test.one,
      kategori: '1',
      namaWisata: test.two,
      deskripsi: _descController.text,
      tanggal: DateFormat.yMd("id_ID").format(_selectedDate),
      jamMulai: '${_time.hour}:${_time.minute}',
      jamSelesai: '${_time2.hour}:${_time2.minute}',
      warna: _selectedColor.toString(),
    );
    AgendaModel.saveItinerary(agendaModel);
    // if (scaffoldKey.currentContext != null) {
    //   MessagesSnacbar.success(context, 'Berhasil Menambahkan List Andaaa');
    // }
  }

  //List Warna
  List<Color> colors = [Colors.green, Colors.red, Colors.blue];
  //

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextHelper(
                      text: "Tambah Jadwal Anda",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      fontColor: const Color.fromARGB(255, 63, 187, 192),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextHelper(text: "Tandai", fontSize: 16.sp),
                        Wrap(
                          children: List.generate(3, (int index) {
                            return GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    _selectedColor = index;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 2.w),
                                  child: CircleAvatar(
                                      radius: 13,
                                      backgroundColor: colors[index],
                                      child: _selectedColor == index
                                          ? const Icon(
                                              Icons.done,
                                              color: Colors.white,
                                              size: 16,
                                            )
                                          : Container()),
                                ));
                          }),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(top: 10.h, left: 18.w),
                        child: TextHelper(
                            text: "Tambahkan Deskripsi", fontSize: 16.sp)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: 4.h, left: 18.w, right: 18.w),
                          height: 55.h,
                          width: 350.w,
                          child: TextFormField(
                            controller: _descController,
                            style: TextStyle(
                                fontSize: 17.sp, color: AppColors.black),
                            decoration: InputDecoration(
                              hintText: "Maksimal 150 Huruf",
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 16.h),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.r),
                                borderSide: const BorderSide(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(top: 15.h, left: 18.w),
                        child: TextHelper(text: "Tanggal", fontSize: 16.sp)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: 4.h, left: 18.w, right: 18.w),
                          height: 55.h,
                          width: 200.w,
                          child: TextFormField(
                            readOnly: true,
                            controller: _tglController,
                            style: TextStyle(
                                fontSize: 17.sp, color: AppColors.black),
                            decoration: InputDecoration(
                                hintText: DateFormat.yMd("id_ID")
                                    .format(_selectedDate),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 16.h),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.r),
                                  borderSide: const BorderSide(),
                                ),
                                suffixIcon: const Icon(
                                  Icons.calendar_month,
                                  size: 20,
                                )),
                            onTap: () {
                              _getDateFromUser();
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(
                                  top: 15.h, left: 18.w, right: 18.w),
                              child: TextHelper(
                                  text: "Jam Mulai", fontSize: 16.sp)),
                          Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(
                                  top: 15.h, left: 18.w, right: 18.w),
                              child: TextHelper(
                                  text: "Jam Selesai", fontSize: 16.sp)),
                        ],
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 4.h, left: 18.w, right: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 55.h,
                            width: 130.w,
                            child: TextFormField(
                              readOnly: true,
                              controller: _startTimeController,
                              style: TextStyle(
                                  fontSize: 17.sp, color: AppColors.black),
                              decoration: InputDecoration(
                                  hintText: "${_time.hour}:${_time.minute}",
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 16.h),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.r),
                                    borderSide: const BorderSide(),
                                  ),
                                  suffixIcon: const Icon(
                                    Icons.punch_clock,
                                    size: 20,
                                  )),
                              onTap: () {
                                Navigator.of(context).push(
                                  showPicker(
                                    showSecondSelector: true,
                                    context: context,
                                    value: _time,
                                    onChange: onTimeChanged,
                                    minuteInterval: TimePickerInterval.FIVE,

                                    // Optional onChange to receive value as DateTime
                                    onChangeDateTime: (DateTime dateTime) {
                                      // print(dateTime);
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                          Image.asset(
                            "assets/images/line.png",
                            width: 18.w,
                            height: 18.h,
                          ),
                          SizedBox(
                            height: 55.h,
                            width: 130.w,
                            child: TextFormField(
                              readOnly: true,
                              controller: _endTimeController,
                              style: TextStyle(
                                  fontSize: 17.sp, color: AppColors.black),
                              decoration: InputDecoration(
                                  hintText: "${_time2.hour}:${_time2.minute}",
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 16.h),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.r),
                                    borderSide: const BorderSide(),
                                  ),
                                  suffixIcon: const Icon(
                                    Icons.punch_clock,
                                    size: 20,
                                  )),
                              onTap: () {
                                Navigator.of(context).push(
                                  showPicker(
                                    showSecondSelector: true,
                                    context: context,
                                    value: _time,
                                    onChange: onTimeChanged2,
                                    minuteInterval: TimePickerInterval.FIVE,
                                    // Optional onChange to receive value as DateTime
                                    onChangeDateTime: (DateTime dateTime) {
                                      // print(dateTime);
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      height: 65.h,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 12.w),
                      padding: EdgeInsets.only(top: 15.h),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                        child: ElevatedButton(
                          onPressed: () {
                            // addListItinerary(context);
                            _validateDate();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: TextHelper(
                                text: 'Tambah Agenda',
                                fontSize: 18.sp,
                                fontFamily: FontFamily.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 80.h)
              ],
            ),
          )),
    );
  }
}
