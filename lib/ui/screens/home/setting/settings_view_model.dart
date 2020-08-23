import 'package:equilibra_mobile/di/di.dart';
import 'package:equilibra_mobile/ui/router/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsViewModel extends BaseViewModel {
  var _navigationService = getIt<NavigationService>();

  editProfile() {
    _navigationService.navigateTo(Routes.editProfileScreen);
  }

  changePassword() {
    _navigationService.navigateTo(Routes.changePasswordScreen);
  }

  changeStateOfResidence() {
    _navigationService.navigateTo(Routes.changeStateOfResidence);
  }

  changeDiaspora() {
    _navigationService.navigateTo(Routes.changeDiaspora);
  }

  void logout() {
//    _navigationService.navigateTo(Routes.landingScreen);
  }
}
