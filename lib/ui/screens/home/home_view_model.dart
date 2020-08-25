import 'package:equilibra_mobile/di/di.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';
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

  var group = RoomGroupDTO("Federal", RoomType.COURT, "Judiciary", 0,
      description1: "The Supreme Court",
      description2: "Courts of Appeal",
      isFederal: true);
  RoomDTO ventTheSteam;
  Future<void> getVentTheSteam() async {
    if (ventTheSteam == null) {
//    RoomDTO room = await

      try {
        ventTheSteam = await _navigationService.navigateTo(
            Routes.roomGroupsListScreen,
            arguments: RoomGroupsListScreenArguments(
                group: group, getVentTheSteam: true));
      } catch (err) {
        print(err);
      }
    }

    _navigationService.navigateTo(Routes.roomScreen,
        arguments: RoomScreenArguments(
            group: group, room: ventTheSteam, isVentTheSteam: true));
  }

  settingsScreen() {
    _navigationService.navigateTo(Routes.settingsScreen);
  }

  logout() {}
}
