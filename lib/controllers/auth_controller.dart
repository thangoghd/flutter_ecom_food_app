import 'package:flutter_ecom_food_app/data/repository/auth_repo.dart';
import 'package:flutter_ecom_food_app/models/respone_model.dart';
import 'package:flutter_ecom_food_app/models/signup_body_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpBodyModel signUpBodyModel) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registration(signUpBodyModel);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body['token']);
      responseModel = ResponseModel(true, response.body['token']);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String email, String password) async {
    _isLoading = true;
    update();
    Response response = await authRepo.login(email, password);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body['token']);
      responseModel = ResponseModel(true, response.body['token']);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<void> saveUserEmailAndPassword(String email, String password) async {
    await authRepo.saveUserEmailAndPassword(email, password);
  }

  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }

  Future<bool> logout() async {
    return await authRepo.logout();
  }
}
