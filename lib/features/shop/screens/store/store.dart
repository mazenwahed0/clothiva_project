import 'package:clothiva_project/utils/helpers/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/brands/brand_card.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import 'widgets/category_tab.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark = context.isDarkMode || context.isDarkModeMedia;
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: CAppBar(
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [CartCounterIcon(onPressed: () {}, iconColor: CColors.dark)],
          showActions: false,
          showSkipButton: false,
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext _, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: dark ? CColors.black : CColors.white,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(CSizes.sm),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      /// --- Search bar
                      const SizedBox(height: CSizes.spaceBtItems),

                      const SearchContainer(
                        text: 'Search in Store',
                        showborder: true,
                        showBackground: false,
                        // padding: EdgeInsets.zero,
                      ),

                      const SizedBox(height: CSizes.spaceBtSections),

                      /// FUTURED BRAND
                      Padding(
                        padding: const EdgeInsets.all(CSizes.sm),
                        child: SectionHeading(
                          title: 'Featured Brands',
                          onPressed: () {},
                        ),
                      ),

                      const SizedBox(height: CSizes.spaceBtItems / 1.5),

                      /// --- Grid Layout
                      GridLayout(
                        itemCount: 4,
                        mainAxisExtent: 80,
                        itemBuilder: (_, index) {
                          return const CBrandCard(showBorder: false);
                        },
                      ),

                      const SizedBox(height: CSizes.spaceBtSections),
                    ],
                  ),
                ),

                /// Tabs
                bottom: const CTabBar(
                  tabs: [
                    Tab(child: Text('Sports')),
                    Tab(child: Text('Furniture')),
                    Tab(child: Text('Electronics')),
                    Tab(child: Text('Clothes')),
                    Tab(child: Text('Cosmetics')),
                  ],
                ),
              ),
            ];
          },

          /// Body
          body: const TabBarView(
            children: [
              CategoryTab(),
              CategoryTab(),
              CategoryTab(),
              CategoryTab(),
              CategoryTab(),
            ],
          ),
        ),
      ),
    );
  }
}
