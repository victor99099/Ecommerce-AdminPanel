import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../controllers/SearchController.dart';
// import '../../controllers/SearchController.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget({super.key});
  final TextEditingController search = TextEditingController();
  final SearcherController searchController = Get.put(SearcherController());
  @override
  Widget build(BuildContext context) {
    final getTheme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(top: 4),
      width: Get.width * 0.3,
      height: Get.height * 0.075,
      child: TextFormField(
        // onTap: ()=>Get.to(()=>SearchScreen()),
        controller: search,
        onChanged: (value) {
          searchController.searchText.value = value;
          searchController.filterList();
        },
        cursorColor: getTheme.colorScheme.primary,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: getTheme.colorScheme.onTertiary),
          filled: true, // Enable filling
          fillColor: getTheme.colorScheme.surface,
          hintText: "Search By Name or Id",
          prefixIcon: Icon(Iconsax.search_normal, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: getTheme.colorScheme.surface),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey), // Default border color
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: getTheme
                    .colorScheme.onTertiary), // Border color when focused
          ),
          contentPadding: const EdgeInsets.only(top: 2.0, left: 8.0),
        ),
      ).pOnly(bottom: 0),
    );
  }
}
