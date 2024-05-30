import 'package:flutter/material.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
            child: Image.asset(
              'assets/image/UAJY-LOGOGRAM.png',
              height: 20.h,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
            child: Text(
              "Atma Kitchen",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.w),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
            child: Text(
              loremIpsum(paragraphs: 1, words: 60),
              textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/image/pastry.jpg',
                    height: 33.w,
                    width: 33.w,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 42.w,
                    child: Column(
                      children: [
                        Text("Misi Kami",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 2.5.h)),
                        Text(
                          loremIpsum(paragraphs: 1, words: 30),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 42.w,
                    child: Column(
                      children: [
                        Text("Visi Kami",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 2.5.h)),
                        Text(
                          loremIpsum(paragraphs: 1, words: 30),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/image/pastry.jpg',
                      height: 33.w,
                      width: 33.w,
                      fit: BoxFit.cover,
                    )),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
