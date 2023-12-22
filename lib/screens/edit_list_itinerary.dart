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
import 'package:intravel_ease/providers/edit_list_provider.dart';
import 'package:intravel_ease/public_providers/public_two_provider%20.dart';
import 'package:intravel_ease/screens/detail_schedule_screen.dart';
import 'package:intravel_ease/widgets/messages_snackbar.dart';
import 'package:intravel_ease/widgets/text_helper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditItinerary extends StatefulWidget {
  const EditItinerary({super.key});

  @override
  State<EditItinerary> createState() => _EditItineraryState();
}

class _EditItineraryState extends State<EditItinerary> {
  List<Color> colors = [Colors.green, Colors.red, Colors.blue];
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _tglController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  int _selectedColor = 0;
  DateTime _selectedDate = DateTime.now();
  String? _agendaDeskripsi;

  void _getDeskripsiFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? deskripsi = prefs.getString('agenda_deskripsi');
    setState(() {
      _agendaDeskripsi = deskripsi;
    });
  }

  Time _time = Time(hour: 11, minute: 30);
  Time _time2 = Time(hour: 11, minute: 30);

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

  @override
  void initState() {
    super.initState();
    setState(() {
      _getDeskripsiFromSharedPreferences();
    });
  }

  AgendaModel? modelAgenda;
  void updateList(BuildContext context) async {
    final test = Provider.of<PublicTwoProvider>(context, listen: false);
    AgendaModel agendaModel = AgendaModel(
        id: test.one,
        kategori: '1',
        namaWisata: test.two,
        deskripsi: _deskripsiController.text,
        tanggal: DateFormat.yMd("id_ID").format(_selectedDate),
        jamMulai: _time.toString(),
        jamSelesai: _time2.toString(),
        warna: _selectedColor.toString());
    // AgendaModel.updateItinerary(0, agendaModel);
  }

  _validateDate() async {
    if (_deskripsiController.toString().isNotEmpty) {
      await EasyLoading.show(
        status: 'memuat...',
        maskType: EasyLoadingMaskType.clear,
      );
      await Future.delayed(const Duration(seconds: 1));
      EasyLoading.dismiss();
      // setState(() {
      updateList(context);
      // });
      AnimatedSnackBar.material(
        'Agenda Berhasil Di Update',
        type: AnimatedSnackBarType.success,
        duration: const Duration(seconds: 4),
        desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
      ).show(context);
      Navigator.pop(context);
    } else if (_deskripsiController.toString().isEmpty) {
      AnimatedSnackBar.material(
        'Isi Semua Field !',
        type: AnimatedSnackBarType.warning,
        duration: const Duration(seconds: 4),
        desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    EditListProvider initProvider = EditListProvider();

    return ChangeNotifierProvider.value(
        value: initProvider,
        child: Consumer(builder: (context, provider, child) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  padding: EdgeInsets.only(left: 20.w),
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Container(
                  padding: EdgeInsets.only(left: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextHelper(
                          text: "Edit List Itinerary",
                          fontSize: 18.sp,
                          fontColor: Colors.black,
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                ),
              ),
              body: FutureBuilder(builder: (context, snapshot) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 50.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextHelper(text: "Tandai", fontSize: 16.sp),
                            SizedBox(width: 5.w),
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
                        SizedBox(height: 30.h),
                        TextHelper(text: "Edit Deskripsi", fontSize: 18.sp),
                        SizedBox(height: 5.h),
                        SizedBox(
                          height: 55.h,
                          width: 130.w,
                          child: TextFormField(
                            controller: _deskripsiController,
                            style: TextStyle(
                                fontSize: 17.sp, color: AppColors.black),
                            decoration: InputDecoration(
                                hintText: _agendaDeskripsi,
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 16.h),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.r),
                                  borderSide: const BorderSide(),
                                )),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Container(
                            alignment: Alignment.topLeft,
                            child:
                                TextHelper(text: "Tanggal", fontSize: 18.sp)),
                        SizedBox(height: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 55.h,
                              width: 175.w,
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
                        SizedBox(height: 30.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                alignment: Alignment.topLeft,
                                child: TextHelper(
                                    text: "Jam Mulai", fontSize: 16.sp)),
                            Container(
                                alignment: Alignment.topLeft,
                                child: TextHelper(
                                    text: "Jam Selesai", fontSize: 16.sp)),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
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
                        SizedBox(height: 30.h),
                        Container(
                          height: 65.h,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 12.w),
                          padding: EdgeInsets.only(top: 15.h),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r)),
                            child: ElevatedButton(
                              onPressed: () {
                                // updateList(context);
                                setState(() {
                                  _validateDate();
                                  // _validateDate();
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                child: TextHelper(
                                    text: 'Ubah Agenda',
                                    fontSize: 18.sp,
                                    fontFamily: FontFamily.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }));
        }));
  }
}
