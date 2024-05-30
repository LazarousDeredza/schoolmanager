import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:velocity_x/velocity_x.dart';

class SelfTourDetailsScreen extends StatelessWidget {
  final dynamic data;
  const SelfTourDetailsScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              //!---------------show slider------------
              // VxSwiper.builder(
              //   autoPlay: true,
              //   enlargeCenterPage: true,
              //   height: 200,
              //   aspectRatio: 16 / 9,
              //   viewportFraction: 1.0,
              //   itemCount: data["gallery_img"].length,
              //   itemBuilder: (context, index) {
              //     return CachedNetworkImage(
              //       imageUrl: data['gallery_img'][index],
              //       width: double.infinity,
              //       fit: BoxFit.cover,
              //       filterQuality: FilterQuality.high,
              //       placeholder: (context, url) => const Center(
              //         child: CircularProgressIndicator(
              //           color: Colors.blue,
              //         ),
              //       ),
              //       errorWidget: (context, url, error) =>
              //           const Icon(Icons.error),
              //     );
              //   },
              // ),
                CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        height: 200,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                      ),
                      items: data["gallery_img"].map((image) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: CachedNetworkImage(
                            imageUrl: image,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        );
                      }).toList(),
                    ),
              SizedBox(height: 20.h,),
              
              Padding(
                padding: EdgeInsets.all(10.h),
                child:Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      "Destination:",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    ),
    SizedBox(height: 5),
    Text(data['destination'].toString()),
    SizedBox(height: 22),
    Text(
      "Cost:",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    ),
    SizedBox(height: 5),
    Text(data['cost'].toString()),
    SizedBox(height: 22),
    Text(
      data['destination'].toString(),
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    ),
    SizedBox(height: 17),
    Text(
      "Description:",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    SizedBox(height: 5),
    Text(
      data['description'].toString(),
      textAlign: TextAlign.justify,
    ),
    SizedBox(height: 20),
    Text(
      "live:",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    SizedBox(height: 5),
    Text(
      data['live'].toString(),
      textAlign: TextAlign.justify,
    ),
    SizedBox(height: 20),
    Text(
      "How to go:",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    ),
    SizedBox(height: 5),
    Text(
      data['how_to_go'].toString(),
      textAlign: TextAlign.justify,
    ),
    SizedBox(height: 22),
  ],
),
              ),
            ],
          ),
        ),
      ),
    );
  }
}