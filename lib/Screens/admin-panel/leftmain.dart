import 'package:ecommerce_adminpanel/Screens/admin-panel/ProfileScreen/PersonalInfoScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconsax/iconsax.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../controllers/PageController.dart';
import '../auth-ui/SignScreen.dart';

class LeftMain extends StatefulWidget {
  const LeftMain({super.key});

  @override
  State<LeftMain> createState() => _LeftMainState();
}

class _LeftMainState extends State<LeftMain> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CustomPageController pageController = Get.find<CustomPageController>();
    return Container(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14.0),
        // padding: const EdgeInsets.all(8.0),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.15,
              child: Center(
                child: Text(
                  "Shopify",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            Spacer(),
            ListView(
              // physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              children: [
                GestureDetector(
                  onTap: () {
                    pageController.SelectedPage.value =
                        9; // Use the original index for selection
                  },
                  child: HoverableRow(
                      title: "Dashboard",
                      icon: Symbols.space_dashboard,
                      iconColor: Colors.white,
                      index: 9),
                ),
                GestureDetector(
                  onTap: () {
                    pageController.SelectedPage.value =
                        0; // Use the original index for selection
                  },
                  child: HoverableRow(
                      title: "Categories",
                      icon: Iconsax.category,
                      iconColor: Colors.white,
                      index: 0),
                ),
                GestureDetector(
                  onTap: () {
                    pageController.SelectedPage.value =
                        2; // Use the original index for selection
                  },
                  child: HoverableRow(
                      title: "Brands",
                      icon: Iconsax.shop,
                      iconColor: Colors.white,
                      index: 2),
                ),
                GestureDetector(
                  onTap: () {
                    pageController.SelectedPage.value =
                        4; // Use the original index for selection
                  },
                  child: HoverableRow(
                      title: "Products",
                      icon: Iconsax.shopping_bag,
                      iconColor: Colors.white,
                      index: 4),
                ),
                GestureDetector(
                  onTap: () {
                    pageController.SelectedPage.value =
                        6; // Use the original index for selection
                  },
                  child: HoverableRow(
                      title: "Users",
                      icon: Iconsax.profile_2user,
                      iconColor: Colors.white,
                      index: 6),
                ),
                GestureDetector(
                  onTap: () {
                    pageController.SelectedPage.value =
                        7; // Use the original index for selection
                  },
                  child: HoverableRow(
                      title: "Orders",
                      icon: Iconsax.receipt,
                      iconColor: Colors.white,
                      index: 7),
                ),
                GestureDetector(
                  onTap: () {
                    pageController.SelectedPage.value =
                        8; // Use the original index for selection
                  },
                  child: HoverableRow(
                      title: "Promotions",
                      icon: Iconsax.tag,
                      iconColor: Colors.white,
                      index: 8),
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialog(
                            title: "Logout",
                            content: "Are you sure ?",
                            onCancel: () {
                              Navigator.of(context).pop();
                            },
                            onConfirm: () async {
                              Navigator.of(context).pop();
                              final FirebaseAuth auth = FirebaseAuth.instance;
                              GoogleSignIn googleSignIn = GoogleSignIn();

                              await auth.signOut();

                              await googleSignIn.signOut();

                              Get.offAll(() => const SignScreen());
                            });
                      });
                },
                child: Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.logout_outlined,
                      color: Colors.white,
                    ),
                    Text(
                      "Logout",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HoverableRow extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final int index;

  const HoverableRow({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.index,
    super.key,
  });

  @override
  _HoverableRowState createState() => _HoverableRowState();
}

class _HoverableRowState extends State<HoverableRow>
    with SingleTickerProviderStateMixin {
  CustomPageController pageController = Get.put(CustomPageController());
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
          _controller.forward();
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
          _controller.reverse();
        });
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _isHovered ? _scaleAnimation.value : 1.0,
            child: Obx(
              () => Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color:
                          pageController.SelectedPage.value == widget.index ||
                                  (pageController.SelectedPage.value ==
                                          widget.index + 1 &&
                                      pageController.SelectedPage.value < 7)
                              ? Colors.white.withOpacity(0.25)
                              : Colors.transparent,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                      // border: Border.all(
                      //     color: const Color.fromARGB(255, 168, 207, 233),
                      //     width: pageController.SelectedPage.value == widget.index
                      //         ? 3
                      //         : 1),
                    ),
                    height: MediaQuery.of(context).size.width * 0.04,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      // padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(widget.icon, color: Colors.white)
                              .paddingOnly(left: 10),
                          const SizedBox(width: 15),
                          Text(
                            widget.title,
                            softWrap: true,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.white,
                              fontWeight: _isHovered ? FontWeight.bold : null,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    endIndent: 30,
                    indent: 30,
                    height: 2,
                    thickness: 1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
