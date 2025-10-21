import 'package:clothiva_project/features/shop/controllers/product/image_controller.dart';
import 'package:clothiva_project/features/shop/models/product_variation_model.dart';
import 'package:get/get.dart';

import '../../models/product_model.dart';

class VariationController extends GetxController{
  static VariationController get instance=>Get.find();

  //Variables
  RxMap selectedAttributes={}.obs;
  RxString variationStockStatus=''.obs;
  Rx<ProductVariationModel> selectedVariation=ProductVariationModel.empty().obs;

  void onAttributesAvailabilityInVariation(ProductModel product,attributeName,attributeValue){
    final selectedAttributes=Map<String,dynamic>.from(this.selectedAttributes);
    selectedAttributes[attributeName]=attributeValue;

    final selectedVariation=product.productVariations!.firstWhere((variation)=>_isSameAttributeValues(variation.attributeValues, selectedAttributes),
    orElse:()=>ProductVariationModel.empty()
    );

    //Show selected variation
    if(selectedVariation.image.isNotEmpty){
      ImageController.instance.selectedProductImage.value=selectedVariation.image;
    }

    this.selectedVariation.value=selectedVariation;

    getProductVariationStockStatus();
  }

  bool _isSameAttributeValues(Map<String,dynamic> variationAttributes,Map<String,dynamic> selectedAttributes){
    if(variationAttributes.length!=selectedAttributes.length){
      return false;
    }

    for(final key in variationAttributes.keys){
      if(variationAttributes[key]!=selectedAttributes[key]){
        return false;
      }
    }
    return true;
  }

  Set<String?>getAttributesAvailabilityInVariation(List<ProductVariationModel>variations,String attributeName){
    //Pass variations to check which attributes are available and stock is not 0
    final availableVariationAttributeValues=variations
        .where((variation)=>
    variation.attributeValues[attributeName]!=null&& variation.attributeValues[attributeName]!.isNotEmpty&&variation.stock>0)
        .map((variation)=>variation.attributeValues[attributeName]).toSet();
        return availableVariationAttributeValues;
  }

  void getProductVariationStockStatus(){
    variationStockStatus.value=selectedVariation.value.stock>0?'In Stock':'Out of Stock';
  }

  void resetSelectedAttributes(){
    selectedAttributes.clear();
    variationStockStatus.value='';
    selectedVariation.value=ProductVariationModel.empty();
  }

  String getVariationPrice(){
    return (selectedVariation.value.salePrice>0? selectedVariation.value.salePrice:selectedVariation.value.price).toString();
  }

}