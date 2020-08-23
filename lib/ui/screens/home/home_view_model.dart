import 'package:equilibra_mobile/di/di.dart';
import 'package:equilibra_mobile/ui/router/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  var _navigationService = getIt<NavigationService>();

  int _currentPage = 0;
  int get currentPage => _currentPage;
  set currentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  settingsScreen() {
    _navigationService.navigateTo(Routes.settingsScreen);
  }

  logout() {}
}
