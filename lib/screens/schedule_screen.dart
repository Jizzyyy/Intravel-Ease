import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:intravel_ease/configs/font_family.dart';
import 'package:intravel_ease/providers/schedule_provider.dart';
import 'package:intravel_ease/screens/detail_schedule_screen.dart';
import 'package:intravel_ease/widgets/text_helper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../configs/app_color.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime today = DateTime.now();
  final String _dateday = DateFormat.EEEE("id_ID").format(DateTime.now());

  void _ondaySelect(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ScheduleProvider(),
      child: Consumer<ScheduleProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: CustomScrollView(slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(right: 18.w, left: 18.w),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(
                        //     height: MediaQuery.of(context).padding.top + 40.h),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     TextHelper(
                        //       text: 'Kalender',
                        //       fontSize: 28.sp,
                        //       fontFamily: FontFamily.bold,
                        //     ),
                        //   ],
                        // ),
                        TextHelper(
                          text: DateFormat.d("id_ID").format(DateTime.now()),
                          fontSize: 94.sp,
                          fontFamily: FontFamily.bold,
                          fontColor: AppColors.yellow,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextHelper(
                              text: "$_dateday, ",
                              fontSize: 20.sp,
                              fontFamily: FontFamily.bold,
                              fontColor: AppColors.textgrey,
                            ),
                            TextHelper(
                              text: DateFormat.yMMMM("id_ID")
                                  .format(DateTime.now()),
                              fontSize: 20.sp,
                              fontFamily: FontFamily.bold,
                              fontColor: AppColors.textgrey,
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10.w, right: 10.w),
                          child: TableCalendar(
                              rowHeight: 45.h,
                              calendarStyle: const CalendarStyle(
                                  selectedDecoration: BoxDecoration(
                                    color: AppColors.yellow,
                                    shape: BoxShape.circle,
                                  ),
                                  todayDecoration: BoxDecoration(
                                    color: Color.fromARGB(149, 191, 191, 191),
                                    shape: BoxShape.circle,
                                  ),
                                  isTodayHighlighted: true,
                                  rangeHighlightColor: AppColors.textgrey),
                              headerStyle: const HeaderStyle(
                                  formatButtonVisible: false,
                                  titleCentered: true),
                              availableGestures: AvailableGestures.all,
                              selectedDayPredicate: (day) =>
                                  isSameDay(day, today),
                              focusedDay: DateTime.now(),
                              firstDay: DateTime.now(),
                              lastDay: DateTime.utc(2050),
                              onDaySelected: _ondaySelect),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 40.h, right: 10.w, left: 10.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextHelper(
                                text: 'Jadwal Perjalanan',
                                fontSize: 24.sp,
                                fontFamily: FontFamily.bold,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(PageTransition(
                                        child: const DetailSchedule(),
                                        reverseDuration:
                                            const Duration(milliseconds: 200),
                                        duration:
                                            const Duration(milliseconds: 500),
                                        alignment: Alignment.bottomCenter,
                                        type: PageTransitionType.size));
                                  },
                                  child: TextHelper(
                                    text: "Lihat Semua",
                                    fontSize: 14.sp,
                                    fontColor:
                                        const Color.fromARGB(255, 63, 187, 192),
                                  )),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(top: 10.h),
                        //   child: SizedBox(
                        //     height: 110.h,
                        //     child: ListView.builder(
                        //       scrollDirection: Axis.horizontal,
                        //       itemCount: tanggalList.length,
                        //       itemBuilder: (BuildContext context, int index) {
                        //         return buildContainer(context, place[index],
                        //             colors[index], tanggalList[index]);
                        //       },
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(height: 20.h)
                      ]),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                sliver: SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(2, (index) {
                        return Container(
                          padding: EdgeInsets.all(4),
                          width: 200.w,
                          // height: 100.h,
                          margin: EdgeInsets.symmetric(horizontal: 2.w),
                          decoration: BoxDecoration(
                            color:
                                Colors.white, // Warna latar belakang container
                            border: Border.all(
                              color: AppColors.textgrey, // Warna border
                              width: 1.sp, // Ketebalan border
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Container(
                                    height: 40.sp,
                                    child: TextHelper(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      text:
                                          'contoh isisldf kldsf lksdfasdfasdfsfajl;k sadklf l;sad',
                                      fontSize: 16.sp,
                                      fontColor: AppColors.textgrey,
                                      fontFamily: FontFamily.bold,
                                    ),
                                  )),
                                  ClipOval(
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      color: AppColors.green,
                                      child: TextHelper(
                                        text: '12',
                                        fontSize: 14.sp,
                                        fontFamily: FontFamily.bold,
                                        fontColor: AppColors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 6.h),
                              ElevatedButton(
                                  style: ButtonStyle(
                                    visualDensity: VisualDensity.compact,
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets
                                            .zero), // Menghilangkan padding
                                  ),
                                  onPressed: () {},
                                  child: TextHelper(
                                    text: 'Lihat',
                                    fontSize: 16.sp,
                                    fontFamily: FontFamily.bold,
                                  ))
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
              SliverPadding(padding: EdgeInsets.only(top: 50.h)),
            ]),
          );
        },
      ),
    );
  }
}

// Container buildContainer(
//     BuildContext context, place, Color color, DateTime date) {
//   return Container(
//     width: 200.w,
//     // height: 40.h,
//     margin: EdgeInsets.symmetric(horizontal: 3.w),
//     padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(8.r),
//       border: Border.all(
//           width: 2.w, color: const Color.fromARGB(52, 113, 105, 105)),
//       color: Colors.white,
//     ),
//     child: Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             SizedBox(
//               width: 148.w,
//               child: TextHelper(
//                 text: place,
//                 fontSize: 17.sp,
//                 fontColor: Colors.grey,
//                 fontFamily: FontFamily.bold,
//               ),
//             ),
//             CircleAvatar(
//               radius: 15.r,
//               backgroundColor: color,
//               child: TextHelper(
//                   text: DateFormat('d').format(date),
//                   fontSize: 15.sp,
//                   fontColor: Colors.white),
//             ),
//           ],
//         ),
//         Align(
//           alignment: Alignment.bottomLeft, // Posisikan ke kiri bawah
//           child: SizedBox(
//             width: 70.w,
//             child: ElevatedButton(
//               onPressed: () => Navigator.of(context).push(
//                 MaterialPageRoute(builder: (context) => const DetailSchedule()),
//               ),
//               child: TextHelper(
//                 text: 'Lihat',
//                 fontSize: 13.sp,
//                 fontFamily: FontFamily.bold,
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.black,
//                 minimumSize: Size(double.infinity, 30.h),
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// List<String> place = [
//   "Pantai Prigi",
//   "Candi Borobudur",
//   "Pantai Gemah",
//   "Pantai Warna-Warni",
//   "Pantai Parangtritis",
//   "Candi Sewu"
// ];

// List<DateTime> tanggalList = [
//   DateTime.now(),
//   DateTime.now().add(const Duration(days: 1)),
//   DateTime.now().add(const Duration(days: 2)),
//   DateTime.now().add(const Duration(days: 3)),
//   DateTime.now().add(const Duration(days: 4)),
//   DateTime.now().add(const Duration(days: 5)),
//   // Tambahkan tanggal-tanggal berikutnya sesuai kebutuhan
// ];

// List<Color> colors = [
//   Colors.red,
//   Colors.green,
//   Colors.blue,
//   Colors.yellow,
//   Colors.purple,
//   Colors.orange
// ];
