// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolmanager/constant/app_colors.dart';
import 'package:get/get.dart';
import 'package:schoolmanager/constant/constant.dart';
import 'package:schoolmanager/vacation_module/views/bottom_nav_controller/pages/home/view_image.dart';
import 'package:schoolmanager/vacation_module/views/widgets/details_heading_description.dart';
import 'package:schoolmanager/vacation_module/views/widgets/violetButton.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:velocity_x/velocity_x.dart';

class DetailsScreen extends StatefulWidget {
  final Map detailsData;
  const DetailsScreen({super.key, required this.detailsData});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  var authCredential = firebaseAuth.currentUser;

  RxBool isLoading = false.obs;

  String payingphone = "";
  bool _isLoading = false;
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    

                    Builder(builder: (context) {
                      //list of image urls

                      final pImages = widget.detailsData['list_images'];

                      List<CarouselItem> itemList = [];

                      List<String>? productImages;
                      if (pImages is List<dynamic>) {
                        productImages = pImages.cast<String>().toList();

                        for (var element in productImages) {
                          print(element);

                          CarouselItem item = CarouselItem(
                            image: NetworkImage(
                              element,
                            ),
                            boxDecoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: FractionalOffset.bottomCenter,
                                end: FractionalOffset.topCenter,
                                colors: [
                                  const Color.fromARGB(255, 3, 105, 28)
                                      .withOpacity(1),
                                  Colors.black.withOpacity(.3),
                                ],
                                stops: const [0.0, 1.0],
                              ),
                            ),
                            title: "Travel Agency",
                            titleTextStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            leftSubtitle: 'Book your slot',
                            rightSubtitle: DateTime.now().toString().substring(0,16),
                            rightSubtitleTextStyle: const TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 236, 234, 234),
                            ),
                            onImageTap: (i) {
                              print('$i image tapped');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyImageWidget(
                                    imageUrl: element,
                                  ),
                                ),
                              );
                            },
                          );

                          itemList.add(item);
                        }
                      }

                      return CustomCarouselSlider(
                        items: itemList,
                        height: 300,
                        subHeight: 50,
                        width: MediaQuery.of(context).size.width * .9,
                        autoplay: true,
                        animationDuration: const Duration(seconds: 3),
                        showText: true,
                      );
                    }),

                    // CarouselSlider(
                    //   options: CarouselOptions(
                    //     autoPlay: true,
                    //     enlargeCenterPage: true,
                    //     height: 300,
                    //     aspectRatio: 16 / 9,
                    //     viewportFraction: 1.0,
                    //   ),
                    //   items: widget.detailsData['list_images'].map((image) {
                    //     return Padding(
                    //       padding: const EdgeInsets.only(top: 20.0),
                    //       child: CachedNetworkImage(
                    //         imageUrl: image,
                    //         width: double.infinity,
                    //         fit: BoxFit.cover,
                    //         filterQuality: FilterQuality.high,
                    //         placeholder: (context, url) => const Center(
                    //           child: CircularProgressIndicator(
                    //             color: Colors.blue,
                    //           ),
                    //         ),
                    //         errorWidget: (context, url, error) =>
                    //             const Icon(Icons.error),
                    //       ),
                    //     );
                    //   }),
                    // ),

                    Padding(
                      padding: const EdgeInsets.only(
                          top: 30.0, left: 10.0, right: 10.0, bottom: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.detailsData['list_destination'].toString(),
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '\$ ${widget.detailsData['list_cost']}\/day',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          detailsHeadingDescription(
                            title: "Description".tr,
                            description: widget.detailsData['list_description'],
                          ),
                          detailsHeadingDescription(
                            title: "Facilites".tr,
                            description: widget.detailsData['list_facilities'],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: AppColors.scaffoldColor,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Obx(() {
                            return VioletButton(
                              isLoading: isLoading.value,
                              title: "Book This Package".tr,
                              onAction: () async {
                                print("........ " +
                                    widget.detailsData.toString());
                                isLoading(true);
                                await BookTravel(context, widget.detailsData);
                                isLoading(false);
                                //Get.back();
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          widget.detailsData['list_owner_name'],
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                launchUrl(
                                  Uri.parse(
                                      "tel: ${widget.detailsData['list_phone']}"),
                                );
                              },
                              icon: Icon(Icons.call_outlined),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            IconButton(
                              onPressed: () {
                                launchUrl(
                                  Uri.parse(
                                      "sms:${widget.detailsData['list_phone']}"),
                                );
                              },
                              icon: Icon(Icons.message_outlined),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BookTravel(BuildContext context, Map detailsData) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: ((context, setState) {
            return AlertDialog(
              scrollable: true,
              actionsAlignment: MainAxisAlignment.center,
              alignment: Alignment.center,
              icon: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                ),
              ),
              title: Text(
                "Please proceed with payment ?",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              content: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _isLoading == true
                        ? Center(
                            child: Column(
                              children: [
                                Text(
                                  "Processing payment...",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor),
                              ],
                            ),
                          )
                        : TextField(
                            onChanged: (val) {
                              setState(() {
                                if (val.isNotEmpty) {
                                  quantity = int.parse(val);
                                } else {
                                  quantity = 1;
                                }
                              });
                            },
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 16,
                                  fontStyle: FontStyle.normal,
                                ),
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: 'How many days do you want to book',
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor),
                                    borderRadius: BorderRadius.circular(20)),
                                errorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(20)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor),
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                    const SizedBox(height: 10),
                    //paying phone number
                    _isLoading == true
                        ? Container()
                        : TextField(
                            onChanged: (val) {
                              setState(() {
                                payingphone = val;
                              });
                            },
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 16,
                                  fontStyle: FontStyle.normal,
                                ),
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: 'Ecocash Phone Number',
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor),
                                    borderRadius: BorderRadius.circular(20)),
                                errorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(20)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor),
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                    const SizedBox(height: 10),
                    //total amount
                    Text(
                      "Total Amount: \$" +
                          (widget.detailsData['list_cost'] * quantity)
                              .toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text("Proceed To Payment"),
                    ),
                  ],
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () async {
                    if (payingphone.length < 10 || payingphone.length > 10) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Invalid Phone Number \nuse format 077xxxxxxxx'),
                        ),
                      );
                      return;
                    }

                    if (payingphone != "0771111111" &&
                        payingphone != "0772222222" &&
                        payingphone != "0773333333" &&
                        payingphone != "0774444444") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'This application is using paynow in test mode . Please use paynow test numbers'),
                        ),
                      );

                      return;
                    }

                    if (payingphone == "0774444444") {
                      setState(() {
                        _isLoading = true;
                      });
                      await Future.delayed(const Duration(seconds: 20 ~/ 2));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'There are insufficient funds in your account'),
                        ),
                      );

                      setState(() {
                        _isLoading = false;
                      });

                      Navigator.of(context).pop();

                      return;
                    }

                    if (payingphone == "0773333333") {
                      setState(() {
                        _isLoading = true;
                      });
                      await Future.delayed(const Duration(seconds: 20 ~/ 2));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Payment Failed . User canceled'),
                        ),
                      );

                      setState(() {
                        _isLoading = false;
                      });

                      Navigator.of(context).pop();

                      return;
                    }

                    if (payingphone != "0771111111" ||
                        payingphone != "0772222222") {
                      setState(() {
                        _isLoading = true;
                      });

                      double amount =double.parse( (widget.detailsData['list_cost'] * quantity).toString());

                      await Future.delayed(const Duration(seconds: 20 ~/ 2));

                      int hrs = 24 * quantity;

                      DateTime endDte =
                          DateTime.now().add(Duration(hours: hrs));

                      CollectionReference data =
                          firestore.collection("VacationBookings");

                      data.doc().set(
                        {
                          "owner_name": widget.detailsData['list_owner_name'],
                          "description": widget.detailsData['list_destination'],
                          "cost": widget.detailsData['list_cost'],
                          "total_cost": amount,
                          "approved": true,
                          "forYou": true,
                          "topPlaces": widget.detailsData['list_topPlaces'],
                          "economy": widget.detailsData['list_economy'],
                          "luxury": widget.detailsData['list_luxury'],
                          "end_date": endDte,
                          "paid": true,
                          "payment_method": "Ecocash",
                          "facilities": widget.detailsData['list_facilities'],
                          "destination": widget.detailsData['list_destination'],
                          "phone": widget.detailsData['list_phone'],
                          "uid": firebaseAuth.currentUser!.uid,
                          'date_time': DateTime.now(),
                          "gallery_img": widget.detailsData['list_images'],
                          
                        },
                      ).whenComplete(() {
                        Get.snackbar("Successful",
                            "Vacation Place booked Successfully.");
                      });

                      setState(() {
                        _isLoading = false;
                      });

                      Get.back();

                      // Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //     builder: (context) => const TaxHome()));

                      return;
                    }

                    // setState(() {
                    //   _isLoading = true;
                    // });

                    // Paynow paynow = Paynow(
                    //     integrationKey: "ffa05013-9376-496f-aa51-524d6ae11351",
                    //     integrationId: "17003",
                    //     returnUrl: "https://google.com",
                    //     resultUrl: "https://google.com");
                    // Payment payment = paynow.createPayment(
                    //     "user", "lazarousderedza99@gmail.com");

                    // final cartItem = PaynowCartItem(
                    //     title: "Vehicle Rental Payment", amount: amount);

                    // // add to cart
                    // payment.addToCart(cartItem);

                    // // add to cart with specific quantity
                    // // payment.addToCart(cartItem, quantity: 5);

                    // // Initiate Mobile Payment
                    // await paynow
                    //     .sendMobile(
                    //         payment, payingphone, MobilePaymentMethod.ecocash)
                    //     .then((InitResponse response) async {
                    //   // display results
                    //   log("Response.....");
                    //   log(response().toString());
                    //   await Future.delayed(const Duration(seconds: 20 ~/ 2));
                    // Check Transaction status from pollUrl
                    // paynow
                    //     .checkTransactionStatus(response.pollUrl)
                    //     .then((StatusResponse status) {
                    //   print(status.paid);
                    // // });
                    // if (response.instructions ==
                    //     "This+is+a+test+transaction.+Test+Case%3a+Success") {
                    //   print("Testing payment successful");

                    // String? message =
                    //     response.instructions!.replaceAll("+", " ");

                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //     content: Text(message.replaceAll("%3", " ")),
                    //   ),
                    // );

                    // setState(() {
                    //   _isLoading = false;
                    // });
                    // Navigator.of(context).pop();
                    // });
                  },
                  child: Image.asset(
                    'assets/images/pay_with_ecocash.png',
                    width: 150,
                  ),
                ),
              ],
            );
          }));
        });
  }
}
