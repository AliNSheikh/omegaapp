import 'package:carousel_slider/carousel_slider.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:omega/Constant/Components.dart';
import 'package:omega/Constant/reusable.dart';
import 'package:omega/Control/dashboardcontroller.dart';

class dashboard extends StatelessWidget {
  dashcontroller dashcon = Get.put(dashcontroller(), permanent: true);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        elevation: 0.0,
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          child: CircleAvatar(
            radius: 50,
            backgroundColor: fontcolorprimary,
            child: SvgPicture.asset(
              'assets/images/img_megaphone.svg',
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: fontcolorprimary,
              child: InkWell(
                onTap: () {},
                child: SvgPicture.asset(
                  'assets/images/img_search.svg',
                ),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: dashcon.getcategories(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              width: getwidth(context),
              height: getheight(context),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      items: [
                        buildbanner(context),
                        buildbanner(context),
                        buildbanner(context),
                        buildbanner(context),
                      ],
                      options: CarouselOptions(
                        reverse: false,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(seconds: 1),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                        viewportFraction: 1.0,
                      ),
                    ),
                    Container(
                      height: 50,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return buildlist(
                            index,
                            listcategories[index],
                            dashcon,
                          );
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: listcategories.length,
                      ),
                    ),
                    FutureBuilder(
                      future: dashcon.getproductbycategory(
                          id: listcategories[dashcon.selectedlistindex.value]
                              .id!),
                      builder:
                          (BuildContext context, AsyncSnapshot<void> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Obx(
                            () => ConditionalBuilder(
                              condition: dashcon.isLoad.isFalse,
                              builder: (context) => Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: AnimationLimiter(
                                      child: GridView.count(
                                        crossAxisCount: 2,
                                        shrinkWrap: true,
                                        physics:
                                            BouncingScrollPhysics(), //BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                        mainAxisSpacing: 10.0,
                                        crossAxisSpacing: 1.0,
                                        childAspectRatio: 1 / 1.4,
                                        children: List.generate(
                                            listproducts.length, (index) {
                                          var item = listproducts[index];
                                          return AnimationConfiguration
                                              .staggeredGrid(
                                            position: index,
                                            duration:
                                                Duration(milliseconds: 1000),
                                            columnCount: 2,
                                            child: ScaleAnimation(
                                              duration:
                                                  Duration(milliseconds: 1200),
                                              curve:
                                                  Curves.fastLinearToSlowEaseIn,
                                              child: FadeInAnimation(
                                                child: ProductList(
                                                    context,
                                                    listproducts[index],
                                                    dashcon,
                                                    item),
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              fallback: (context) => GridView.count(
                                  crossAxisCount: 2,
                                  shrinkWrap: true,
                                  physics:
                                      BouncingScrollPhysics(), //BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                  mainAxisSpacing: 10.0,
                                  crossAxisSpacing: 1.0,
                                  childAspectRatio: 1 / 1.3,

                                  // Replace with your desired number of shimmer items
                                  children: List.generate(4, (index) {
                                    return ProductListLoading(context);
                                  })),
                            ),
                          );
                        } else {
                          return GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              physics:
                                  BouncingScrollPhysics(), //BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                              mainAxisSpacing: 10.0,
                              crossAxisSpacing: 1.0,
                              childAspectRatio: 1 / 1.3,

                              // Replace with your desired number of shimmer items
                              children: List.generate(4, (index) {
                                return ProductListLoading(context);
                              }));
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container(
              width: width!,
              height: height!,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: loadingbanner(context),
                    ),
                    Container(
                      height: 25,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return loadinglist(context);
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                      ),
                    ),
                  ],
                )
              ),
            );
          }
        },
      ),
    );
  }
}
