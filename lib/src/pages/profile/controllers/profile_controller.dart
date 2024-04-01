import 'package:get/get.dart';
import 'package:teste_app/src/entities/user.dart';
import 'package:teste_app/src/services/apis/auth/auth_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileController extends GetxController {
  final AuthService _authService = AuthService();
  RxBool isLoading = false.obs;
  var usuario = Rx<User?>(null);
  @override
  void onInit() {
    super.onInit();
    _getUser();
  }

  Future<void> _getUser() async {
    isLoading(true);
    try {
      var userData = await _authService.getUserData();
      usuario(userData);
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> launchUrlSocial(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }
}
