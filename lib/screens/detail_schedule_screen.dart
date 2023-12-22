import 'package:flutter/material.dart';
import 'package:intravel_ease/public_providers/public_agenda_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:intravel_ease/configs/app_color.dart';
import 'package:intravel_ease/configs/font_family.dart';
import 'package:intravel_ease/providers/detail_schedule_provider.dart';
import 'package:intravel_ease/widgets/text_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'edit_list_itinerary.dart';

class DetailSchedule extends StatefulWidget {
  const DetailSchedule({Key? key}) : super(key: key);

  @override
  State<DetailSchedule> createState() => _DetailScheduleState();
}

class _DetailScheduleState extends State<DetailSchedule> {
  DetailScheduleProvider initProvider = DetailScheduleProvider();
  @override
  void initState() {
    super.initState();
    initProvider.listData();
  }

  // WisataModelDetail? modelDetail;

  Future<void> saveDeskripsiToSharedPreferences(String deskripsi) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('agenda_deskripsi', deskripsi);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: initProvider,
      child:
          Consumer<DetailScheduleProvider>(builder: (context, provider, child) {
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
              actions: [
                Center(
                  child: ElevatedButton(
                      onPressed: () => provider.resetItinerary(context),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary),
                      child: TextHelper(text: 'Reset', fontSize: 14.sp)),
                ),
                SizedBox(width: 10.w),
              ],
              title: Container(
                padding: EdgeInsets.only(left: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextHelper(
                        text: "Agenda Saya",
                        fontSize: 18.sp,
                        fontColor: Colors.black,
                        fontWeight: FontWeight.bold),
                    TextHelper(
                        text: '${provider.date}',
                        fontSize: 16.sp,
                        fontColor: Colors.grey,
                        fontWeight: FontWeight.w600),
                  ],
                ),
              )),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                    height: 130.h,
                    padding:
                        EdgeInsets.only(top: 40.h, left: 18.w, right: 18.w),
                    child: DatePicker(
                      locale: 'id_ID',
                      width: 65.w,
                      height: 65.h,
                      DateTime.now(),
                      initialSelectedDate: provider.selectedDate,
                      selectionColor: Colors.black,
                      selectedTextColor: Colors.white,
                      dateTextStyle: TextStyle(
                          fontSize: 20.sp, fontFamily: FontFamily.bold),
                      onDateChange: (date) {
                        provider.selectedDatePicker = date;
                        if (provider.selectedDatePicker !=
                            provider.selectedDate) {
                          // setState(() {
                          provider.selectedDate = provider.selectedDatePicker;
                          provider.listData();
                          // });
                        }
                      },
                    )),
                SizedBox(height: 30.h),
                const Divider(thickness: 2),
                SizedBox(height: 10.h),
                Column(
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 2.w),
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        height: 500.h,
                        child: Expanded(
                          child: ListView.builder(
                              itemCount: provider.filteredAgendaList.length,
                              itemBuilder: (context, index) {
                                final agenda =
                                    provider.filteredAgendaList[index];
                                final Color color = provider
                                    .colors[int.parse(agenda.warna ?? "0")];
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10.h, horizontal: 4.h),
                                  decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.r))),
                                  width: 300.w,
                                  height: 130.h,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 25.h, horizontal: 10.w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextHelper(
                                                overflow: TextOverflow.ellipsis,
                                                text: '${agenda.namaWisata}',
                                                fontSize: 17.sp,
                                                fontColor: AppColors.white),
                                            SizedBox(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Icon(Icons.lock_clock,
                                                      size: 15.h,
                                                      color: AppColors.white),
                                                  SizedBox(width: 5.w),
                                                  TextHelper(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      text:
                                                          '${agenda.jamMulai}',
                                                      fontSize: 13.sp,
                                                      fontColor:
                                                          AppColors.white),
                                                  SizedBox(width: 10.w),
                                                  Image.asset(
                                                    "assets/images/remove.png",
                                                    width: 14.w,
                                                    height: 14.h,
                                                  ),
                                                  SizedBox(width: 10.w),
                                                  TextHelper(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      text:
                                                          '${agenda.jamSelesai}',
                                                      fontSize: 13.sp,
                                                      fontColor:
                                                          AppColors.white),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: TextHelper(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  text: '${agenda.deskripsi}',
                                                  fontSize: 16.sp,
                                                  fontColor: AppColors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          IconButton(
                                              onPressed: () =>
                                                  provider.buttonDelete(
                                                      context, agenda.inc!),
                                              icon: Icon(
                                                Icons.delete,
                                                color: AppColors.white,
                                                size: 24.h,
                                              )),
                                          // IconButton(
                                          //     onPressed: () async {
                                          //       // provider.toUpdateScreen(
                                          //       //     context,
                                          //       //     agenda.id!,
                                          //       //     agenda.inc!,
                                          //       //     agenda.kategori!,
                                          //       //     agenda.namaWisata!,
                                          //       //     agenda.deskripsi!,
                                          //       //     agenda.tanggal!,
                                          //       //     agenda.jamMulai!,
                                          //       //     agenda.jamSelesai!,
                                          //       //     agenda.warna!);
                                          //       await saveDeskripsiToSharedPreferences(
                                          //           agenda.deskripsi ?? '');
                                          //       Navigator.of(context).push(
                                          //           MaterialPageRoute(
                                          //               builder: (context) =>
                                          //                   const EditItinerary()));
                                          //     },
                                          //     icon: Icon(
                                          //       Icons.edit,
                                          //       color: AppColors.white,
                                          //       size: 24.h,
                                          //     )),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        )),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
