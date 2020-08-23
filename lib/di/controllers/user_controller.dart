import 'package:equilibra_mobile/data/remote/user/repository/user_repo.dart';
import 'package:equilibra_mobile/model/dto/user_dto.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/subjects.dart';
import 'package:stacked/stacked.dart';

export 'package:provider/provider.dart';

class UserController extends BaseViewModel {
  var _userRepo = GetIt.instance<UserRepo>();

  var _profileIsFetching = false;
  var _profileController = BehaviorSubject<UserProfileDTO>();
  Stream<UserProfileDTO> fetchProfile() {
    if (!_profileIsFetching) {
      _profileIsFetching = true;
      _userRepo.fetchMyProfile().then((value) {
        _profileIsFetching = false;
        _profileController.sink.add(value);
      }).catchError((err) {
        _profileIsFetching = false;
      });
    }
    return _profileController.stream;
  }

  @override
  void dispose() {
    _profileController.close();
    super.dispose();
  }
}
