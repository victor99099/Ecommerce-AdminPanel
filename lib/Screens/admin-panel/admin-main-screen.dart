import 'package:ecommerce_adminpanel/Screens/admin-panel/ProfileScreen/Profilescreen.dart';
import 'package:ecommerce_adminpanel/Screens/admin-panel/Widgets/SearchWidget.dart';
import 'package:ecommerce_adminpanel/Screens/admin-panel/leftmain.dart';
import 'package:ecommerce_adminpanel/controllers/PageController.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  // State to track menu visibility
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0), // Slide in from right
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _fadeAnimation = Tween<double>(
      begin: 0.0, // Start fully transparent
      end: 1.0,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final CustomPageController pageController = Get.put(CustomPageController());

  @override
  Widget build(BuildContext context) {
    // final getTheme = Theme.of(context);
    return Scaffold(
      // backgroundColor: getTheme.colorScheme.secondary,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    pageController.isCompact.value =
                        constraints.maxWidth < 1200;
                    return Obx(() {
                      return Row(
                        children: [
                          // Menu Drawer or LeftMain
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.fastOutSlowIn,
                            width: pageController.isCompact.value
                                ? (pageController.isMenuOpen.value
                                    ? MediaQuery.of(context).size.width * 0.2
                                    : 0)
                                : MediaQuery.of(context).size.width * 0.2,
                            child: pageController.isCompact.value
                                ? (pageController.isMenuOpen.value
                                    ? const LeftMain()
                                    : null)
                                : const LeftMain(),
                          ),
                          if (pageController.isCompact.value &&
                              !pageController.isMenuOpen.value)
                            InkWell(
                              onTap: () {
                                pageController.isMenuOpen.value = true;
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                ),
                                width: MediaQuery.of(context).size.width * 0.03,
                                height: double.infinity,
                                child: const Center(
                                  child: Icon(
                                    Ionicons.caret_forward,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ),
                          if (pageController.isCompact.value &&
                              pageController.isMenuOpen.value)
                            InkWell(
                              onTap: () {
                                pageController.isMenuOpen.value = false;
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                ),
                                width: MediaQuery.of(context).size.width * 0.03,
                                height: double.infinity,
                                child: const Center(
                                  child: Icon(
                                    Ionicons.caret_back,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                ),
                              ),
                            ),
                          // const Opacity(
                          //   opacity: 0.5,
                          //   child: VerticalDivider(
                          //     color: Colors.white,
                          //     indent: 0,
                          //     endIndent: 0,
                          //     thickness: 2,
                          //   ),
                          // ),
                          Flexible(
                            child: Obx(() {
                              _controller.forward(from: 0);
                              return Column(
                                children: [
                                  Container(
                                      color: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 25),
                                      width: double.infinity,
                                      // height: MediaQuery.of(context).size.height * 0.1,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SearchWidget(),
                                          IconButton(
                                              hoverColor:
                                                  Colors.grey.withOpacity(0.5),
                                              onPressed: () {
                                                Get.to(() => ProfileScreen());
                                              },
                                              icon: const Icon(
                                                Icons.person_2_outlined,
                                                color: Colors.grey,
                                                size: 30,
                                              ))
                                        ],
                                      )),
                                  Expanded(
                                    child: FadeTransition(
                                      opacity: _fadeAnimation,
                                      child: SlideTransition(
                                        position: _slideAnimation,
                                        child: Container(
                                          child: pageController.screens[
                                              pageController
                                                  .SelectedPage.value],
                                        ),
                                      ),
                                    ),
                                  )
                                  // Container(
                                  //     // width: double.infinity,
                                  //     // height: double.infinity,
                                  //     child: AnimatedSwitcher(
                                  //   duration: Duration(milliseconds: 500),
                                  //   transitionBuilder: (widget, animation) {
                                  //     return FadeTransition(
                                  //       opacity: animation,
                                  //       child: SlideTransition(
                                  //         position: Tween<Offset>(
                                  //           begin: Offset(1.5, 0),
                                  //           end: Offset(0, 0),
                                  //         ).animate(animation),
                                  //         child: widget,
                                  //       ),
                                  //     );
                                  //   },
                                  //   child: Container(
                                  //     key: ValueKey<int>(
                                  //         pageController.SelectedPage.value),
                                  //     child: pageController.screens[
                                  //         pageController.SelectedPage.value],
                                  //   ),
                                  // )),
                                ],
                              );
                            }),
                          ),
                        ],
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
