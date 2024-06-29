import 'package:ecommerce_app/data/models/network_response.dart';
import 'package:ecommerce_app/data/models/product_model.dart';
import 'package:ecommerce_app/data/services/network_caller.dart';
import 'package:ecommerce_app/data/utility/urls.dart';
import 'package:get/get.dart';

class NewProductController extends GetxController {
  bool _getNewProductsInProgress = false;
  ProductModel _newProductModel = ProductModel();
  String _errorMessage = '';

  bool get getNewProductsInProgress => _getNewProductsInProgress;

  ProductModel get newProductModel => _newProductModel;

  String get errorMessage => _errorMessage;

  Future<bool> getNewProducts() async {
    _getNewProductsInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getNewProducts);
    _getNewProductsInProgress = false;
    if (response.isSuccess) {
      _newProductModel = ProductModel.fromJson(response.responseJson ?? {});
      update();
      return true;
    } else {
      _errorMessage = 'New product fetch failed! Try again.';
      update();
      return false;
    }
  }
}
