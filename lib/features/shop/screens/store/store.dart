import 'package:clothiva_project/common/widgets/shimmers/brands_shimmer.dart';
import 'package:clothiva_project/features/shop/screens/brand/all_brands.dart';
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
import '../../controllers/brand_controller.dart';
import '../../controllers/category_controller.dart';
import 'widgets/category_tab.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark = context.isDarkMode || context.isDarkModeMedia;
    final categories = CategoryController.instance.featuredCategories;
    final brandController=Get.put(BrandController());
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: CAppBar(
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            CartCounterIcon(
              onPressed: () {},
              iconColor: dark ? CColors.lightGrey : CColors.dark,
            ),
          ],
          showActions: true,
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
                // Space between Appbar and TabBar
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(CSizes.defaultSpace / 2),
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

                      /// --- Featured Brands
                      Padding(
                        padding: const EdgeInsets.all(CSizes.sm),
                        child: SectionHeading(
                          title: 'Featured Brands',
                          onPressed: ()=>Get.to(()=>AllBrandScreen()), // AllBrandsScreen HERE!
                        ),
                      ),

                      const SizedBox(height: CSizes.spaceBtItems / 1.5),

                      /// --- Brands Grid
                      Obx((){
                        if(brandController.isLoading.value)return CBrandsShimmer();

                        if(brandController.featuredBrands.isEmpty){
                          return Center(child: Text("No Data Found",style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),),);
                        }
                        return GridLayout(
                          itemCount: brandController.featuredBrands.length,
                          mainAxisExtent: 80,
                          itemBuilder: (_, index) {
                            final brand=brandController.featuredBrands[index];
                            // -- Passing Each Brand & onPress Event from Backend
                            return CBrandCard(showBorder: true,brand: brand,);
                          },
                        );
                      }
                      ),

                      const SizedBox(height: CSizes.spaceBtSections),
                    ],
                  ),
                ),

                /// Tabs
                bottom: CTabBar(
                  tabs: categories
                      .map((category) => Tab(child: Text(category.name)))
                      .toList(),
                ),
              ),
            ];
          },

          /// Body
          body: TabBarView(
            children: categories
                .map((category) => CategoryTab(category: category))
                .toList(),
          ),
        ),
      ),
    );
  }
}
