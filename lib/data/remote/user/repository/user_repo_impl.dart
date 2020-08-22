import 'package:equilibra_mobile/data/local/cache/local_cache.dart';
import 'package:equilibra_mobile/data/remote/user/service/user_service.dart';

import 'user_repo.dart';
export 'user_repo.dart';

class UserRepoImpl implements UserRepo {
  LocalCache localCache;
  UserService userService;
  UserRepoImpl({this.localCache, this.userService});
}
