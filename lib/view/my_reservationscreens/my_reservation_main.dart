import 'dart:developer';

import 'package:boli_app/constants/constant_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../api_services/my_shared_preferance.dart';
import '../../controllers/book_reservation_Controller.dart';
import '../../ui_components/custom_widget.dart';
import '../../utils/bottomnavigationBar.dart';
import '../../utils/custom_dialogeBox.dart';
import '../mycart_screens/mycart_main_screen.dart';
import '../profiles_screens/edit_profile_screen.dart';

class MyReservationMain extends StatefulWidget {
  const MyReservationMain({super.key});

  @override
  State<MyReservationMain> createState() => _MyReservationMainState();
}

class _MyReservationMainState extends State<MyReservationMain> {
  final BookReservationController bookReservationController =
      Get.put(BookReservationController());
  final MySharedPreferanse mySharedPreferanse = MySharedPreferanse();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mySharedPreferanse.getUserLoginToken().then((value) {
      mySharedPreferanse.gettoken;
      log('This is Token :${mySharedPreferanse.gettoken}');
      bookReservationController.getReservation(mySharedPreferanse.gettoken);
    });
  }

  @override
  Widget build(BuildContext context) {
    CustomDialogueBox customDialogueBox = CustomDialogueBox();
    final RxBool isDelete = false.obs;

    final RxInt selectedIndex = 0.obs;
    return DefaultTabController(
      length: 2,
      child:
        Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.4.h),
            child:
            Obx(()=>
              bookReservationController.allReservation.value==null?
              Center(child: CircularProgressIndicator(color: ConstantColors.greenColor,),):  Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getVerSpace(5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Get.to(() => const BottomNavBar(
                                      commingIndex: 0,
                                    ));
                              },
                              icon: Icon(Icons.arrow_back_ios_sharp,
                                  size: 18.px, color: const Color(0xff444444))),
                          Text(
                            'My Reservation',
                            style: TextStyle(
                                fontSize: 16.px,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'segoeui',
                                color: const Color(0xff444444)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const MyCartMainScreen());
                            },
                            child: Container(
                                height: 4.h,
                                width: 4.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      offset: const Offset(0, 2),
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                    )
                                  ],
                                ),
                                child: getSvgImage('cart.svg')),
                          ),
                          getHorSpace(1.h),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const EditProfileScreen());
                            },
                            child: CircleAvatar(
                              radius: 16.px,
                              backgroundImage:
                                  const AssetImage('assets/jpgs/profile.jpg'),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  getVerSpace(2.h),
                  Obx(
                    () => TabBar(
                        dividerColor: ConstantColors.textFieldGrey,
                        dividerHeight: 2.5,
                        indicatorWeight: 2.0,
                        labelPadding: EdgeInsets.symmetric(vertical: 1.h),
                        indicatorColor: ConstantColors.greenColor,
                        indicatorSize: TabBarIndicatorSize.tab,
                        padding: EdgeInsets.symmetric(horizontal: 6.h),
                        onTap: (value) {
                          selectedIndex.value = value;
                        },
                        tabs: [
                          Text(
                            'Previous Reservations',
                            style: TextStyle(
                                fontSize: 10.px,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'segoeui',
                                color: selectedIndex.value == 0
                                    ? const Color(0xff00BF63)
                                    : const Color(0xffA6A6A6)),
                          ),
                          Text(
                            'Upcoming Reservations',
                            style: TextStyle(
                                fontSize: 10.px,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'segoeui',
                                color: selectedIndex.value == 1
                                    ? const Color(0xff00BF63)
                                    : const Color(0xffA6A6A6)),
                          ),
                        ]),
                  ),
                  Expanded(
                    child: TabBarView(children: [
                      Column(
                        children: [
                          getVerSpace(3.h),
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: 3,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.h),
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 1.h, horizontal: 2.h),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.px),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.1),
                                              offset: const Offset(0, 2),
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                            )
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 9.h,
                                              width: 7.h,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.px),
                                                  color: Colors.grey,
                                                  image: const DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: AssetImage(
                                                          'assets/jpgs/resturant1.jpg'))),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Reservation Details.',
                                                  style: TextStyle(
                                                      fontSize: 12.px,
                                                      fontWeight: FontWeight.w600,
                                                      fontFamily: 'segoeui',
                                                      color: const Color(
                                                          0xff444444)),
                                                ),
                                                Text(
                                                  'XYZ Restaurant',
                                                  style: TextStyle(
                                                      fontSize: 12.px,
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: 'segoeui',
                                                      color: const Color(
                                                          0xffA6A6A6)),
                                                ),
                                                Text(
                                                  'Date: 16/02/2024',
                                                  style: TextStyle(
                                                      fontSize: 12.px,
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: 'segoeui',
                                                      color: const Color(
                                                          0xffA6A6A6)),
                                                ),
                                                Text(
                                                  'Table of 1',
                                                  style: TextStyle(
                                                      fontSize: 12.px,
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: 'segoeui',
                                                      color: const Color(
                                                          0xffA6A6A6)),
                                                ),
                                                Text(
                                                  '08:00 PM',
                                                  style: TextStyle(
                                                      fontSize: 12.px,
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: 'segoeui',
                                                      color: const Color(
                                                          0xffA6A6A6)),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'Reschedule',
                                              style: TextStyle(
                                                  fontSize: 14.px,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'segoeui',
                                                  color: const Color(0xff00BF63)),
                                            ),
                                          ],
                                        ),
                                      )),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      bookReservationController.allReservation.value?.data?.isEmpty == true
                          ? Center(
                        child: Text('There are No Upcoming Reservation'),
                      )
                          : Column(
                        children: [
                          getVerSpace(2.h),
                          isDelete.value == true
                              ? Column(
                            children: [
                              getSvgImage('noreservation.svg'),
                              const Text(
                                'No Upcoming reservations!\nYou can book one if you want to.',
                                textAlign: TextAlign.center,
                              )
                            ],
                          )
                              : bookReservationController.loading.value == true
                              ? Center(
                            child: CircularProgressIndicator(
                              color: ConstantColors.greenColor,
                            ),
                          )
                              : Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: bookReservationController.allReservation.value?.data?.length ?? 0,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final reservation = bookReservationController.allReservation.value?.data?[index];
                                if (reservation == null) {
                                  return const SizedBox.shrink();
                                }
                                return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 2.h),
                                    child: Container(
                                                      alignment: Alignment.center,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 1.h,
                                                              horizontal: 2.h),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10.px),
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(0.1),
                                                            offset: const Offset(
                                                                0, 2),
                                                            spreadRadius: 2,
                                                            blurRadius: 2,
                                                          )
                                                        ],
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            height: 10.h,
                                                            width: 7.h,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(10
                                                                            .px),
                                                                color:
                                                                    Colors.grey,
                                                                image: const DecorationImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    image: AssetImage(
                                                                        'assets/jpgs/resturant1.jpg'))),
                                                          ),
                                                          getHorSpace(1.5.h),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Reservation Details.',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12.px,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontFamily:
                                                                        'segoeui',
                                                                    color: const Color(
                                                                        0xff444444)),
                                                              ),
                                                              Text(
                                                                bookReservationController.allReservation.value!.data![index].restaurant != null
                                                                    ? bookReservationController.allReservation.value!.data![index].restaurant!.name ?? 'XYZ'
                                                                    : 'XYZ',
                                                                style: TextStyle(
                                                                  fontSize: 12.px,
                                                                  fontWeight: FontWeight.w400,
                                                                  fontFamily: 'segoeui',
                                                                  color: const Color(0xffA6A6A6),
                                                                ),
                                                              ),

                                                              Text(
                                                                '${bookReservationController.allReservation.value!.data![index].date ?? '2020/12/10'}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12.px,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontFamily:
                                                                        'segoeui',
                                                                    color: const Color(
                                                                        0xffA6A6A6)),
                                                              ),
                                                              Text(
                                                                '${bookReservationController.allReservation.value!.data![index].tableFor}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12.px,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontFamily:
                                                                        'segoeui',
                                                                    color: const Color(
                                                                        0xffA6A6A6)),
                                                              ),
                                                              Text(
                                                                '${bookReservationController.allReservation.value!.data![index].time}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12.px,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontFamily:
                                                                        'segoeui',
                                                                    color: const Color(
                                                                        0xffA6A6A6)),
                                                              ),
                                                            ],
                                                          ),
                                                          Expanded(
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .topRight,
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  customDialogueBox
                                                                      .openSignOutDialog(
                                                                          title:
                                                                              'Cancel Reservation',
                                                                          description:
                                                                              'Are you sure you want to Cancel this Reservation?',
                                                                          svg:
                                                                              'cancel.svg',
                                                                          onTap:
                                                                              () {

                                                                                DateTime? reservationDate = bookReservationController.allReservation.value!.data![index].date;
                                                                                String formattedDateTime = DateFormat('yyyy-MM-dd').format(reservationDate!);
                                                                          bookReservationController.cancelReservation(
                                                                              bookReservationController.allReservation.value!.data![index].restaurant!.id.toString(),
                                                                              bookReservationController.allReservation.value!.data![index].tableFor.toString(),
                                                                              formattedDateTime,
                                                                               bookReservationController.allReservation.value!.data![index].time.toString(),
                                                                               mySharedPreferanse.gettoken,
                                                                               bookReservationController.allReservation.value!.data![index].id.toString()
                                                                          ).then((value) {
                                                                            return true;

                                                                          });
                                                                          });
                                                                },
                                                                child: Text(
                                                                  'Cancel',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14.px,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontFamily:
                                                                          'segoeui',
                                                                      color: const Color(
                                                                          0xff00BF63)),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ));
                                              },
                                            ),
                                          ),
                              ],
                            )
                    ]),
                  ),
                  getVerSpace(2.h),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: customElevatedButton(() {
                      Get.to(() => const BottomNavBar(
                            commingIndex: 0,
                          ));
                    },
                        tittle: isDelete.value == true
                            ? 'Reserve Restaurant'
                            : 'Back Home',
                        height: 4.4.h,
                        width: 30.9.h,
                        tittleColor: Colors.white,
                        borColor: ConstantColors.greenColor,
                        backColor: ConstantColors.greenColor),
                  ),
                  getVerSpace(2.4.h),
                ],
              ),
            ),
          ),
        ),

    );
  }
}
