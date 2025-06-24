import 'package:ecommerce_adminpanel/Screens/admin-panel/Widgets/DropDownButtons.dart';
import 'package:ecommerce_adminpanel/Screens/admin-panel/Widgets/PicUpload.dart';
import 'package:ecommerce_adminpanel/controllers/DataControllers/BrandController.dart';

import 'package:ecommerce_adminpanel/controllers/DataControllers/CategoryController.dart';
import 'package:ecommerce_adminpanel/controllers/PageController.dart';
import 'package:ecommerce_adminpanel/models/categories-model.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../controllers/DashboardControllers/growthController.dart';

class DashboardSection extends StatefulWidget {
  const DashboardSection({super.key});

  @override
  _DashboardSectionState createState() => _DashboardSectionState();
}

class _DashboardSectionState extends State<DashboardSection> {
  final GrowthController growthController = Get.put(GrowthController());
  CustomPageController customPageController = Get.find<CustomPageController>();
  // late Growth user;
  // late Growth productSold;
  // late Growth orders;
  final BrandsController brandsController = Get.find<BrandsController>();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await growthController.getUserGrowth();
    await growthController.getProductSoldGrowth();
    await growthController.getOrderGrowth();
    await growthController.getMonthlySalesRevenue();
    await growthController.getProductWiseSale();
    await growthController.getBrandWiseSale();
    growthController.isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 2,
        color: const Color(0xFFf0f1f1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Get.height * 0.05,
            ),
            Obx(
              () => Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: Get.width * 0.035),
                      // padding: const EdgeInsets.all(8.0),
                      child: Row(
                        spacing: 10,
                        children: [
                          Icon(
                            Symbols.space_dashboard,
                            size: 35,
                            fill: 1,
                            weight: 400,
                            grade: 0,
                            color: Colors.blue,
                          ),
                          Text(
                            "Dashboard",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.8),
                                fontSize: 30,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Get.width * 0.035),
                      // padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Key Business Performance Indicators",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.6), fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    growthController.isLoading.value
                        ? Center(child: CircularProgressIndicator())
                        : Padding(
                            padding: EdgeInsets.only(
                                left: Get.width * 0.03,
                                right: Get.width * 0.03),
                            // padding: const EdgeInsets.all(8.0),
                            child: Column(
                              spacing: 5,
                              children: [
                                Align(
                                  child: DashboardGrowthDropdownButton(),
                                  alignment: Alignment.topRight,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GrowthCard(
                                      growth: growthController.userGrowth.value,
                                      title: "Total Users",
                                      body: "Customer",
                                      color: Colors.red,
                                      icon: Iconsax.profile_2user,
                                    ),
                                    GrowthCard(
                                      icon: Iconsax.shopping_bag,
                                      growth: growthController
                                          .productSoldGrowth.value,
                                      title: "Products Sold",
                                      body: "Revenue Stream",
                                      color: const Color.fromARGB(
                                          255, 218, 198, 26),
                                    ),
                                    GrowthCard(
                                      icon: Iconsax.receipt,
                                      growth:
                                          growthController.orderGrowth.value,
                                      title: "Total Orders",
                                      body: "Orders Placed",
                                      color: Colors.green,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Get.width * 0.03,
                          right: Get.width * 0.03,
                          top: Get.height * 0.05),
                      // padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: customPageController.isCompact.value
                                  ? customPageController.isMenuOpen.value
                                      ? Get.width * 0.36
                                      : Get.width * 0.45
                                  : Get.width * 0.36,
                              height: Get.height * 0.83,
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      side: BorderSide(
                                        color: const Color(0xFFf0f1f1),
                                      )),
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20.0,
                                            left: 20,
                                            bottom: 10,
                                            right: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Product Wise Sells",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20)),
                                            DashboardProductWiseDropdownButton()
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        endIndent: 15,
                                        indent: 15,
                                        thickness: 2,
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                      SizedBox(
                                          width: customPageController
                                                  .isCompact.value
                                              ? customPageController
                                                      .isMenuOpen.value
                                                  ? Get.width * 0.36
                                                  : Get.width * 0.45
                                              : Get.width * 0.36,
                                          height: Get.height * 0.47,
                                          child: growthController
                                                  .isLoading.value
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator())
                                              : CategoryPieChart()),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Get.width * 0.06,
                                            right: Get.width * 0.06,
                                            top: 30),
                                        child: Column(
                                          spacing: 10,
                                          children: [
                                            Row(
                                              spacing: Get.width * 0.07,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                PieChartLabels(
                                                  color: const Color.fromARGB(
                                                          255, 255, 162, 162)
                                                      .withOpacity(0.6),
                                                  title: "Phones",
                                                ),
                                                PieChartLabels(
                                                  color: const Color.fromARGB(
                                                          255, 235, 235, 83)
                                                      .withOpacity(0.6),
                                                  title: "Televisions",
                                                ),
                                              ],
                                            ),
                                            Row(
                                              spacing: Get.width * 0.07,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                PieChartLabels(
                                                  color: const Color.fromARGB(
                                                          255, 170, 255, 214)
                                                      .withOpacity(0.6),
                                                  title: "Tablets",
                                                ),
                                                PieChartLabels(
                                                  color: const Color.fromARGB(
                                                          255, 239, 148, 255)
                                                      .withOpacity(0.6),
                                                  title: "HeadPhones",
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ))),
                          SizedBox(
                              width: customPageController.isCompact.value
                                  ? customPageController.isMenuOpen.value
                                      ? Get.width * 0.36
                                      : Get.width * 0.45
                                  : Get.width * 0.36,
                              height: Get.height * 0.83,
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      side: BorderSide(
                                        color: const Color(0xFFf0f1f1),
                                      )),
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20.0,
                                            left: 20,
                                            bottom: 10,
                                            right: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Brand Wise Sells",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20)),
                                            DashboardBrandWiseDropdownButton()
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        endIndent: 15,
                                        indent: 15,
                                        thickness: 2,
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                      SizedBox(
                                          width: customPageController
                                                  .isCompact.value
                                              ? customPageController
                                                      .isMenuOpen.value
                                                  ? Get.width * 0.36
                                                  : Get.width * 0.45
                                              : Get.width * 0.36,
                                          height: Get.height * 0.47,
                                          child: growthController
                                                  .isLoading.value
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator())
                                              : BrandPieChart()),
                                      growthController.isLoading.value
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : Padding(
                                              padding: EdgeInsets.only(
                                                  left: Get.width * 0.06,
                                                  right: Get.width * 0.06,
                                                  top: 30),
                                              child: Column(
                                                spacing: 10,
                                                children: [
                                                  Row(
                                                    spacing: Get.width * 0.07,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      PieChartLabels(
                                                        color: const Color
                                                                .fromARGB(255,
                                                                255, 162, 162)
                                                            .withOpacity(0.6),
                                                        title: brandsController
                                                            .brandsList[0]
                                                            .brandName,
                                                      ),
                                                      PieChartLabels(
                                                        color: const Color
                                                                .fromARGB(255,
                                                                235, 235, 83)
                                                            .withOpacity(0.6),
                                                        title: brandsController
                                                            .brandsList[1]
                                                            .brandName,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    spacing: Get.width * 0.07,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      PieChartLabels(
                                                        color: const Color
                                                                .fromARGB(255,
                                                                170, 255, 214)
                                                            .withOpacity(0.6),
                                                        title: brandsController
                                                            .brandsList[2]
                                                            .brandName,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                    ],
                                  ))),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Get.width * 0.03,
                          right: Get.width * 0.03,
                          top: Get.height * 0.05),
                      // padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          width: double.infinity,
                          height: Get.height * 0.54,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  side: BorderSide(
                                    color: const Color(0xFFf0f1f1),
                                  )),
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20.0,
                                        left: 20,
                                        bottom: 10,
                                        right: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Revenue",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20)),
                                        DashboardRevenueDropdownButton()
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    endIndent: 0,
                                    indent: 0,
                                    thickness: 2,
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                  SizedBox(
                                      width: double.infinity,
                                      height: Get.height * 0.35,
                                      child: growthController.isLoading.value
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : MonthlySalesChart()),
                                ],
                              ))),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
          ],
        ),
      ),
    );
  }
}

class PieChartLabels extends StatelessWidget {
  final String title;
  final Color color;
  const PieChartLabels({super.key, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: color),
        ),
        Text(title,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14)),
      ],
    );
  }
}

class CategoryPieChart extends StatefulWidget {
  const CategoryPieChart({super.key});

  @override
  State<StatefulWidget> createState() => CategoryPieChartState();
}

class CategoryPieChartState extends State {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  pieTouchResponse == null ||
                  pieTouchResponse.touchedSection == null) {
                touchedIndex = -1;
                return;
              }
              touchedIndex =
                  pieTouchResponse.touchedSection!.touchedSectionIndex;
            });
          },
        ),
        borderData: FlBorderData(
          show: false,
        ),
        sectionsSpace: 5,
        centerSpaceRadius: 40,
        sections: showingSections(),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 19.0 : 15.0;
      final radius = isTouched ? 90.0 : 80.0;
      final widgetSize = isTouched ? 80.0 : 60.0;
      final GrowthController growthController = Get.put(GrowthController());
      switch (i) {
        case 0:
          return PieChartSectionData(
              color: const Color.fromARGB(255, 255, 162, 162).withOpacity(0.6),
              value: growthController.phoneCategoryRate.value,
              title:
                  '${(growthController.phoneCategoryRate.value * 100).toStringAsFixed(0)}%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 156, 14, 4),
              ),
              badgeWidget: _Badge(
                'assets/icons/ophthalmology-svgrepo-com.svg',
                size: widgetSize,
                borderColor:
                    const Color.fromARGB(255, 255, 162, 162).withOpacity(0.6),
                categoryName: "Mobile Phones",
              ),
              badgePositionPercentageOffset: .99,
              titlePositionPercentageOffset: .3);
        case 1:
          return PieChartSectionData(
              color: const Color.fromARGB(255, 238, 238, 103).withOpacity(0.6),
              value: growthController.televisionCategoryRate.value,
              title:
                  "${(growthController.televisionCategoryRate.value * 100).toStringAsFixed(0)}%",
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 194, 174, 0),
              ),
              badgeWidget: _Badge(
                'assets/icons/librarian-svgrepo-com.svg',
                size: widgetSize,
                borderColor:
                    const Color.fromARGB(255, 235, 235, 83).withOpacity(0.6),
                categoryName: "Televisions",
              ),
              badgePositionPercentageOffset: .99,
              titlePositionPercentageOffset: .3);

        case 2:
          return PieChartSectionData(
              color: const Color.fromARGB(255, 170, 255, 214).withOpacity(0.6),
              value: growthController.tabletsCategoryRate.value,
              title:
                  '${(growthController.tabletsCategoryRate.value * 100).toStringAsFixed(0)}%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 5, 73, 7),
              ),
              badgeWidget: _Badge(
                'assets/icons/fitness-svgrepo-com.svg',
                size: widgetSize,
                borderColor:
                    const Color.fromARGB(255, 170, 255, 214).withOpacity(0.6),
                categoryName: "Tablets",
              ),
              badgePositionPercentageOffset: .99,
              titlePositionPercentageOffset: .3);
        case 3:
          return PieChartSectionData(
              color: const Color.fromARGB(255, 239, 148, 255).withOpacity(0.6),
              value: growthController.headphoneCategoryRate.value,
              title:
                  '${(growthController.headphoneCategoryRate.value * 100).toStringAsFixed(0)}%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 48, 12, 110),
              ),
              badgeWidget: _Badge(
                'assets/icons/worker-svgrepo-com.svg',
                size: widgetSize,
                categoryName: "Headphones",
                borderColor:
                    const Color.fromARGB(255, 239, 148, 255).withOpacity(0.6),
              ),
              badgePositionPercentageOffset: .99,
              titlePositionPercentageOffset: .3);
        default:
          throw Exception('Oh no');
      }
    });
  }
}

class BrandPieChart extends StatefulWidget {
  const BrandPieChart({super.key});

  @override
  State<StatefulWidget> createState() => BrandPieChartState();
}

class BrandPieChartState extends State {
  int touchedIndex = 0;
  final GrowthController growthController = Get.find<GrowthController>();
  final BrandsController brandsController = Get.find<BrandsController>();

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  pieTouchResponse == null ||
                  pieTouchResponse.touchedSection == null) {
                touchedIndex = -1;
                return;
              }
              touchedIndex =
                  pieTouchResponse.touchedSection!.touchedSectionIndex;
            });
          },
        ),
        borderData: FlBorderData(
          show: false,
        ),
        sectionsSpace: 5,
        centerSpaceRadius: 40,
        sections: showingSections(),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(growthController.brandRates.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 19.0 : 15.0;
      final radius = isTouched ? 90.0 : 80.0;
      final widgetSize = isTouched ? 80.0 : 60.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
              color: const Color.fromARGB(255, 255, 162, 162).withOpacity(0.6),
              value: growthController
                  .brandRates[brandsController.brandsList[0].brandName],
              title:
                  '${(growthController.brandRates[brandsController.brandsList[0].brandName]! * 100).toStringAsFixed(0)}%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 156, 14, 4),
              ),
              badgeWidget: _BrandBadge(
                'assets/icons/ophthalmology-svgrepo-com.svg',
                size: widgetSize,
                borderColor:
                    const Color.fromARGB(255, 255, 162, 162).withOpacity(0.6),
                brandImg: brandsController.brandsList[0].brandImage,
              ),
              badgePositionPercentageOffset: .99,
              titlePositionPercentageOffset: .3);
        case 1:
          return PieChartSectionData(
              color: const Color.fromARGB(255, 238, 238, 103).withOpacity(0.6),
              value: growthController
                  .brandRates[brandsController.brandsList[1].brandName],
              title:
                  "${(growthController.brandRates[brandsController.brandsList[1].brandName]! * 100).toStringAsFixed(0)}%",
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 194, 174, 0),
              ),
              badgeWidget: _BrandBadge(
                'assets/icons/librarian-svgrepo-com.svg',
                size: widgetSize,
                borderColor:
                    const Color.fromARGB(255, 235, 235, 83).withOpacity(0.6),
                brandImg: brandsController.brandsList[1].brandImage,
              ),
              badgePositionPercentageOffset: .99,
              titlePositionPercentageOffset: .3);

        case 2:
          return PieChartSectionData(
              color: const Color.fromARGB(255, 170, 255, 214).withOpacity(0.6),
              value: growthController
                  .brandRates[brandsController.brandsList[2].brandName],
              title:
                  '${(growthController.brandRates[brandsController.brandsList[2].brandName]! * 100).toStringAsFixed(0)}%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 5, 73, 7),
              ),
              badgeWidget: _BrandBadge('assets/icons/fitness-svgrepo-com.svg',
                  size: widgetSize,
                  borderColor:
                      const Color.fromARGB(255, 170, 255, 214).withOpacity(0.6),
                  brandImg: brandsController.brandsList[2].brandImage),
              badgePositionPercentageOffset: .99,
              titlePositionPercentageOffset: .3);
        case 3:
          return PieChartSectionData(
              color: const Color.fromARGB(255, 239, 148, 255).withOpacity(0.6),
              value: growthController
                  .brandRates[brandsController.brandsList[3].brandName],
              title:
                  '${(growthController.brandRates[brandsController.brandsList[3].brandName]! * 100).toStringAsFixed(0)}%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 48, 12, 110),
              ),
              badgeWidget: _BrandBadge(
                'assets/icons/worker-svgrepo-com.svg',
                size: widgetSize,
                brandImg: brandsController.brandsList[3].brandImage,
                borderColor:
                    const Color.fromARGB(255, 239, 148, 255).withOpacity(0.6),
              ),
              badgePositionPercentageOffset: .99,
              titlePositionPercentageOffset: .3);
        default:
          throw Exception('Oh no');
      }
    });
  }
}

class _BrandBadge extends StatelessWidget {
  _BrandBadge(this.svgAsset,
      {required this.size, required this.borderColor, required this.brandImg});
  final String svgAsset;
  final String brandImg;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: .5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .05),
      child: Center(
          child: ClipOval(
        child: Image.network(
          brandImg,
          fit: BoxFit.cover,
        ),
      )),
    );
  }
}

class _Badge extends StatelessWidget {
  _Badge(this.svgAsset,
      {required this.size,
      required this.borderColor,
      required this.categoryName});
  final String svgAsset;
  final String categoryName;
  final double size;
  final Color borderColor;

  final CategoriesController categoriesController =
      Get.find<CategoriesController>();
  @override
  Widget build(BuildContext context) {
    final CategoriesModel category =
        categoriesController.categoriesList.firstWhere((category) {
      return category.categoryName == categoryName;
    });
    // print(category.categoryName);

    // print(category.categoryImage ?? "");
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: .5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .05),
      child: Center(
          child: Image.network(
        category.categoryImage,
        fit: BoxFit.cover,
      )),
    );
  }
}

class MonthlySalesChart extends StatelessWidget {
  MonthlySalesChart();
  final GrowthController growthController = Get.find<GrowthController>();

  double _roundInterval(double value) {
    if (value <= 1000) return 1000;
    if (value <= 2000) return 2000;
    if (value <= 5000) return 5000;
    if (value <= 10000) return 10000;
    return 20000;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      growthController.getMonthlySalesRevenue();
      if (growthController.monthlySales.isEmpty) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      // Determine the highest available month
      int highestMonth = growthController.monthlySales.keys.isNotEmpty
          ? growthController.monthlySales.keys.reduce((a, b) => a > b ? a : b)
          : 0;
      double maxY = growthController.monthlySales.values
          .fold(0.0, (prev, el) => el > prev ? el : prev);
      double yInterval = _roundInterval((maxY / 5).ceilToDouble());
      double adjustedMaxY = yInterval * 4;
      // Ensure all months up to highestMonth have at least 0 value
      List<BarChartGroupData> barGroups = List.generate(highestMonth, (index) {
        int monthIndex = index + 1;
        double revenue = growthController.monthlySales[monthIndex] ?? 0.0;

        return BarChartGroupData(
          x: monthIndex,
          barRods: [
            BarChartRodData(
              toY: revenue,
              color: Colors.blue,
              width: 4,
              borderRadius: BorderRadius.circular(1),
            ),
          ],
        );
      });

      return Padding(
        padding: const EdgeInsets.only(left: 24.0, top: 20),
        child: BarChart(
          BarChartData(
            maxY: adjustedMaxY,
            // groupsSpace: 60,
            minY: 0,
            // alignment: BarChartAlignment.spaceBetween,
            barGroups: barGroups,
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                drawBelowEverything: true,
                sideTitles: SideTitles(
                    interval: yInterval,
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      int intValue = value.toInt(); // Convert to integer

                      // Convert to "K" format and remove ".0" if whole number
                      String formattedValue = (intValue % 1000 == 0)
                          ? "\$${intValue ~/ 1000}K"
                          : "\$${(value / 1000).round()}K";

                      return Text(
                        formattedValue,
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      );
                    }),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 42,
                  getTitlesWidget: (value, meta) {
                    return SideTitleWidget(
                      space: 16,
                      meta: meta,
                      child: Text(
                        _monthName(value.toInt()),
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles:
                    SideTitles(showTitles: false), // Removes right-side labels
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: false), // Removes top labels (1, 2, 3)
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawHorizontalLine: true, // Enable horizontal lines
              drawVerticalLine: false, // Disable vertical lines
              horizontalInterval: yInterval - 10, // Adjust spacing for readability
              getDrawingHorizontalLine: (value) => FlLine(
                color: Colors.grey.withOpacity(0.5),
                strokeWidth: 1,
                // dashArray: [5, 5], // Optional: Dashed lines
              ),
              checkToShowHorizontalLine: (value) => value % 10 == 0,
            ),
          ),
        ),
      );
    });
  }

  // Helper function to convert month index to short name
  String _monthName(int monthIndex) {
    List<String> months = [
      "",
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[monthIndex];
  }
}

class GrowthCard extends StatelessWidget {
  const GrowthCard(
      {super.key,
      required this.growth,
      required this.body,
      required this.title,
      required this.icon,
      required this.color});

  final Growth growth;
  final String title;
  final String body;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    CustomPageController customPageController =
        Get.find<CustomPageController>();
    return Obx(
      () => SizedBox(
        width: customPageController.isCompact.value
            ? customPageController.isMenuOpen.value
                ? Get.width * 0.23
                : Get.width * 0.3
            : Get.width * 0.24,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: const Color(0xFFf0f1f1),
              )),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 10.0, bottom: 8, left: 12, right: 18),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      icon,
                      size: 30,
                      color: color,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16),
                        ),
                        Text(
                          body,
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        )
                      ],
                    ),
                    Spacer(),
                    Text(
                      growth.value.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: color,
                          fontSize: 26),
                    )
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.only(left: Get.width * 0.025),
                  // padding: const EdgeInsets.all(8.0),
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(10),
                    value: growth.rate / 100, // 60% filled
                    backgroundColor: Colors.grey[300], // Grey background
                    valueColor:
                        AlwaysStoppedAnimation<Color>(color), // Filled color
                    minHeight: 8,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.only(left: Get.width * 0.025),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Growth",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      Text(
                        "100%",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
