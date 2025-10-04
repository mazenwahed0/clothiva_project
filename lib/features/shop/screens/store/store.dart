import 'package:clothiva_project/common/widgets/brands/brand_cart.dart';
import 'package:clothiva_project/features/shop/screens/store/widgets/category_tab.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/images/circular_image.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products.cart/cart_menu_icon.dart';
import '../../../../common/widgets/texts/brand_title_text_with_verified_icon.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: CAppBar(
          title: Text('Store', style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [CartCounterIcon(onPressed: () {}, iconColor: CColors.dark,
            ),
          ],
        ),

        body: NestedScrollView(
          headerSliverBuilder: (BuildContext _, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: CHelperFunctions.isDarkMode(context) ? CColors.black : CColors.white,
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
                        showBorder: true,
                        showBackground: false,
                        padding: EdgeInsets.zero,
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
                          return const BrandCard(showBorder: false);

                        },
                      ),

                      const SizedBox(height: CSizes.spaceBtSections),
                    ],
                  ),
                ),
                /// Tabs
                bottom: const TTabBar(
                  tabs: [
                    Tab(child:  Text('Sports')),
                    Tab(child:  Text('Furniture')),
                    Tab(child:  Text('Electronics')),
                    Tab(child:  Text('Clothes')),
                    Tab(child:  Text('Cosmetics')),
                  ]
                )
              ),
            ];
          },
          /// Body
          body: const TabBarView(
            children: [TCategoryTab(),TCategoryTab(),TCategoryTab(),TCategoryTab(),TCategoryTab(),],
          ),
        ),
      ),
    );
  }
}




