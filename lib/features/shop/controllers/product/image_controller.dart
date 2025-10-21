import 'package:cached_network_image/cached_network_image.dart';
import 'package:clothiva_project/features/shop/models/product_model.dart';
import 'package:clothiva_project/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageController extends GetxController{
  static ImageController get instance=> Get.find();

  //Vars
  RxString selectedProductImage=''.obs;


  //Get all images from product and variations
  List<String>getAllProductImages(ProductModel product) {
    //Use set to add unique images
    Set<String>images = {};

    //Load thumbnail
    images.add(product.thumbnail);

    //Assign thumbnail as selected image
    selectedProductImage.value = product.thumbnail;

    //Get all images from Product model
    if (product.images != null) {
      images.addAll(product.images!);
    }

    //Get all images from product variation
    if (product.productVariations != null||product.productVariations!.isNotEmpty) {
      images.addAll(product.productVariations!.map((variation)=>variation.image));
    }
    return images.toList();
  }
  //show images popup
  void showEnlargedImage(String image){
    Get.to(
      fullscreenDialog: true,
        ()=>Dialog.fullscreen(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: CSizes.defaultSpace*2,horizontal: CSizes.defaultSpace),
                  child: CachedNetworkImage(imageUrl: image),
              ),
              SizedBox(
                height: CSizes.spaceBtSections,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 150,
                  child: OutlinedButton(onPressed: ()=>Get.back(), child: Text("Close")),
                ),
              )
            ],
          ),
        )
    );
  }
}