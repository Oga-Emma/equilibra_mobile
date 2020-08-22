import 'package:equilibra_mobile/data/remote/user/repository/user_repo.dart';
import 'package:equilibra_mobile/model/dto/user_dto.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

export 'package:provider/provider.dart';

class UserController extends BaseViewModel {
  var _userRepo = GetIt.instance<UserRepo>();

  Future<UserDTO> fetchProfile() async {
    try {
      setBusy(true);
      UserDTO user = await _userRepo.fetchMyProfile();
      setBusy(false);
      return user;
    } catch (err) {
      setBusy(false);
      throw err;
    }

    setBusy(false);
  }
}
