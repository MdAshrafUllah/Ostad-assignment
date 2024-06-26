import 'package:ecommerce_app/data/models/network_response.dart';
import 'package:ecommerce_app/data/services/network_caller.dart';
import 'package:ecommerce_app/data/utility/urls.dart';
import 'package:get/get.dart';

class DeleteCartListProductController extends GetxController {
  String _message = '';

  String get message => _message;

  Future<bool> deleteCartProduct(int productId) async {
    final NetworkResponse response = await NetworkCaller()
        .getRequest(Urls.deleteCartProduct(productId), isLogin: true);
    if (response.isSuccess) {
      return true;
    } else {
      _message = 'Delete cart list product failed!';
      return false;
    }
  }
}
