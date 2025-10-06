import 'package:clothiva_project/data/repositories/banners/banner_repository.dart';
import 'package:clothiva_project/data/repositories/categories/category_repository.dart';
import 'package:clothiva_project/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/list_tiles/settings_menu_tile.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';

class LoadData extends StatelessWidget {
  const LoadData({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = CategoryRepository.instance;
    final bannerController = BannerRepository.instance;
    return Scaffold(
      appBar: CAppBar(
        title: Text(
          'Upload Data',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
        showActions: false,
        showSkipButton: false,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: CSizes.defaultSpace,
          vertical: CSizes.sm,
        ),
        child: Column(
          children: [
            SectionHeading(title: 'Main Record', showActionButton: false),
            SizedBox(height: CSizes.spaceBtItems),
            SettingsMenuTile(
              icon: Iconsax.category,
              title: 'Upload Categories',
              subtitle: 'Upload Categories to Cloudinary & Firestore',
              onTap: () {
                categoryController.uploadCategories(CDummyData.categories);
              },
              trailing: Icon(Iconsax.arrow_circle_up),
            ),
            SettingsMenuTile(
              icon: Iconsax.battery_charging,
              title: 'Upload Banners',
              subtitle: 'Upload Banners to Cloudinary & Firestore',
              onTap: () {
                bannerController.uploadBanners(CDummyData.banner);
              },
              trailing: Icon(Iconsax.arrow_circle_up),
            ),
            SettingsMenuTile(
              icon: Iconsax.barcode,
              title: 'Upload Products',
              subtitle: 'Upload Banners to Cloudinary & Firestore',
              onTap: () {
                // productController.uploadProducts(CDummyData.products);
              },
              trailing: Icon(Iconsax.arrow_circle_up),
            ),
            SettingsMenuTile(
              icon: Iconsax.personalcard,
              title: 'Upload Products',
              subtitle: 'Upload Banners to Cloudinary & Firestore',
              onTap: () {
                // brandsController.uploadBrands(CDummyData.brands);
              },
              trailing: Icon(Iconsax.arrow_circle_up),
            ),
          ],
        ),
      ),
    );
  }
}
