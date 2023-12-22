import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intravel_ease/configs/app_color.dart';
import 'package:intravel_ease/models/model_shared_preferences/agenda_model.dart';
import 'package:intravel_ease/screens/edit_list_itinerary.dart';
import 'package:intravel_ease/widgets/text_helper.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Make sure to import this if you're using flutter_screenutil.

class ListItinerary extends StatefulWidget {
  const ListItinerary({super.key});

  @override
  State<ListItinerary> createState() => _ListItineraryState();
}

class _ListItineraryState extends State<ListItinerary> {
  List<Color> colors = [Colors.green, Colors.red, Colors.blue];

  // Load Data
  final int _selectedColorIndex = 0;
  AgendaModel? modelAgenda;

  Time convertStringToTime(String timeString) {
    List<String> timeParts = timeString.split(':');
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);
    return Time(hour: hour, minute: minute);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedColorIndex;
    });
  }

  // hapus data list
  _removeTaskData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Remove the keys from SharedPreferences using the 'remove' method.
    await prefs.remove('selected_color_index');
    await prefs.remove('task_description');
    await prefs.remove('task_start_time');
    await prefs.remove('task_end_time');
  }
  //

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AgendaModel.getItinerary(),
        builder: (context, snapshot) {
          if (snapshot.data?.length == 0) {
            return Container(
              color: AppColors.white,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 100.h),
                    Image.asset('assets/images/no-content.png', height: 70.h),
                    SizedBox(height: 20.h),
                    TextHelper(
                      text: 'Agenda Tidak Ditemukan',
                      fontSize: 16.sp,
                      fontColor: AppColors.textgrey,
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 2.w),
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              height: 500.h,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  final agendaModel = snapshot.data?[index];
                  final Color color =
                      colors[int.parse(agendaModel?.warna ?? "0")];
                  return Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 4.h),
                    decoration: BoxDecoration(
                        color:
                            color, // Assuming you have a list of colors defined somewhere.
                        borderRadius: BorderRadius.all(Radius.circular(12.r))),
                    width: 300.w,
                    height: 110.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 25.h, horizontal: 10.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextHelper(
                                  text: '${snapshot.data?[index].namaWisata}',
                                  fontSize: 17.sp,
                                  fontColor: AppColors.white),
                              SizedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.lock_clock,
                                        size: 15.h, color: AppColors.white),
                                    SizedBox(width: 5.w),
                                    TextHelper(
                                        text:
                                            '${snapshot.data?[index].jamMulai}',
                                        fontSize: 13.sp,
                                        fontColor: AppColors.white),
                                    SizedBox(width: 10.w),
                                    Image.asset(
                                      "assets/images/remove.png",
                                      width: 14.w,
                                      height: 14.h,
                                    ),
                                    SizedBox(width: 10.w),
                                    TextHelper(
                                        text:
                                            '${snapshot.data?[index].jamSelesai}',
                                        fontSize: 13.sp,
                                        fontColor: AppColors.white),
                                  ],
                                ),
                              ),
                              TextHelper(
                                  overflow: TextOverflow.ellipsis,
                                  text: '${snapshot.data?[index].deskripsi}',
                                  fontSize: 16.sp,
                                  fontColor: AppColors.white),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Dialogs.materialDialog(
                                      msg: 'Yakin Ingin Menghapus Agenda Ini?',
                                      title: "Hapus Agenda",
                                      color: Colors.white,
                                      context: context,
                                      dialogWidth: 100.w,
                                      actions: [
                                        IconsOutlineButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(['Test', 'List']);
                                          },
                                          text: 'Jangan Hapus',
                                          iconData: Icons.cancel_outlined,
                                          textStyle: const TextStyle(
                                              color: Colors.grey),
                                          iconColor: Colors.grey,
                                        ),
                                        IconsButton(
                                          onPressed: () {},
                                          text: "Ya, Hapus",
                                          iconData: Icons.delete,
                                          color: Colors.red,
                                          textStyle: const TextStyle(
                                              color: Colors.white),
                                          iconColor: Colors.white,
                                        ),
                                      ]);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: AppColors
                                      .white, // Make sure AppColors is defined.
                                  size: 24.h,
                                )),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const EditItinerary()));
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: AppColors.white,
                                  size: 24.h,
                                )),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}
