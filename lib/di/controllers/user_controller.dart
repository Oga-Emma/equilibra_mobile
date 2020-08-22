import 'package:equilibra_mobile/data/remote/user/repository/user_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

export 'package:provider/provider.dart';

class UserController extends BaseViewModel {
  var userRepo = GetIt.instance<UserRepo>();
}
