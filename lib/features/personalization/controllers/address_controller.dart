import 'package:clothiva_project/common/widgets/loaders/circular_loader.dart';
import 'package:clothiva_project/features/personalization/models/address_model.dart';
import 'package:clothiva_project/utils/constants/image_strings.dart';
import 'package:clothiva_project/utils/helpers/exports.dart';
import 'package:clothiva_project/utils/popups/exports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clothiva_project/data/repositories/address/address_repository.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  // fetch all users specific addresses
  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
        (element) => element.selectedAddress,
        orElse: () => AddressModel.empty(),
      );
      return addresses;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Address Not Found', message: e.toString());
      return [];
    }
  }

  Future<void> selectAddress(AddressModel newSelectedAddress) async {
    Get.defaultDialog(
      title: '',
      onWillPop: () async {
        return false;
      },
      barrierDismissible: false,
      backgroundColor: Colors.transparent,
      content: const CircularLoader(),
    );

    try {
      // clear the selected field
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
          selectedAddress.value.id,
          false,
        );
      }

      // assign selected address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      // set the "selected" field to true for the newly selected address
      await addressRepository.updateSelectedField(
        selectedAddress.value.id,
        true,
      );

      Get.back();
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error in Selection', message: e.toString());
    }
  }

  // Add new address
  Future addNewAddress() async {
    try {
      // start loading
      FullScreenLoader.openLoadingDialog(
        'Storing Address...',
        CImages.docerAnimation,
      );

      // check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!addressFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Save Address Data
      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        selectedAddress: true,
      );
      final id = await addressRepository.addAddress(address);

      // Update Selected Address status
      address.id = id;
      await selectAddress(address);

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show Success Message
      Loaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your address has been saved successfully.',
      );

      // Refresh Address Data
      refreshData.toggle();

      // Reset Fields
      resetFormFields();

      // Redirect
      Navigator.of(Get.context!).pop();
    } catch (e) {
      // Remove Loader
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Address not found', message: e.toString());
    }
  }

  // Function to reset form fields
  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }
}
