import 'package:ecommerce/features/shop/controllers/product/product_images_controller.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/features/shop/models/product_variation_model.dart';
import 'package:get/get.dart';

class ProductVariationController extends GetxController {
  static ProductVariationController get instance => Get.find();

  // VARIABLES
  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation = ProductVariationModel.empty().obs;

  // SELECTED ATTRIBUTE, AND VARIATION
  void onAttributeSelected(ProductModel product, attributeName, attributeValue) {
    // WHEN ATTRIBUTE IS SELECTED WE WILL FIRST AND THAT ATTRIBUTE TO THE SELECTED ATTRIBUTES
    final selectedAttributes = Map<String, dynamic>.from(this.selectedAttributes);
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    final selectedVariation = product.productVariation!.firstWhere((variation) => _isSameAttributeValues(variation.attributeValues, selectedAttributes), orElse: () => ProductVariationModel.empty());

    // SHOW THE SELECTED VARIATION IMAGE AS A MAIN IMAGE
    if (selectedVariation.image.isNotEmpty) {
      ProductImagesController.instance.selectedProductImages.value = selectedVariation.image;
    }

    // ASSIGN SELECTED VARIATION
    this.selectedVariation.value = selectedVariation;
  }

  // CHECK IF SELECTED ATTRIBUTES MATCHES ANY VARIATION ATTRIBUTES
  bool _isSameAttributeValues(Map<String, dynamic> variationAttributes, Map<String, dynamic> selectedAttributes) {
    // IF SELECTED ATTRIBUTES CONTAINS 3 ATTRIBUTES AND CURRENT VARIATION CONTAINS 2 THEN RETURN
    if (variationAttributes.length != selectedAttributes.length) return false;

    // IF ANY OF THE ATTRIBUTES IS DIFFERENT THEN RETURN. E.G [GREEN, LARGE] X [GREEN, SMALL]
    for (final key in variationAttributes.keys) {
      // ATTRIBUTES[KEY] = VALUE WHICH COULD BE [GREEN, SMALL, COTTON] ETC.
      if (variationAttributes[key] != selectedAttributes[key]) return false;
    }

    return true;
  }

  // CHECK ATTRIBUTE AVAILABILITY / STOCK IN VARIATION
  Set<String?> getAttributeAvailabilityVariation(List<ProductVariationModel> variations, String attributeName) {
    // PASS THE VARIATIONS TO CHECK WITH ATTRIBUTES ARE AVAILABLE AND STOCK IS NOT 0
    final availableVariationAttributesValues = variations
        .where((variation) =>
            // CHECK EMPTY OR OUT OF STOCK ATTRIBUTES
            variation.attributeValues[attributeName] != null && variation.attributeValues[attributeName]!.isNotEmpty && variation.stock > 0)
        // FETCH ALL NON-EMPTY ATTRIBUTES OR VARIATIONS
        .map((variation) => variation.attributeValues[attributeName])
        .toSet();

    return availableVariationAttributesValues;
  }

  String getVariationPrice() {
    return (selectedVariation.value.salePrice > 0 ? selectedVariation.value.salePrice : selectedVariation.value.price).toString();
  }

  // CHECK PRODUCT VARIATION STOCK STATUS
  void getProductVariationStockStatus() {
    variationStockStatus.value = selectedVariation.value.stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  // RESET SELECTED ATTRIBUTES WHEN SWITCHING PRODUCTS
  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }
}
