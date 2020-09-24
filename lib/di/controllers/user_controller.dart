import 'dart:io';

import 'package:equilibra_mobile/data/remote/user/repository/user_repo.dart';
import 'package:equilibra_mobile/model/dto/auth_response_dto.dart';
import 'package:equilibra_mobile/model/dto/user_dto.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/subjects.dart';
import 'package:stacked/stacked.dart';

export 'package:provider/provider.dart';

class UserController extends BaseViewModel {
  var _userRepo = GetIt.instance<UserRepo>();

  var _profileIsFetching = false;
  var _profileController = BehaviorSubject<UserProfileDTO>();

  UserDTO user;

  Stream<UserProfileDTO> fetchProfile() {
    if (user == null && !_profileIsFetching) {
      _profileIsFetching = true;
      _userRepo.fetchMyProfile().then((value) {
        user = value;
        _profileIsFetching = false;
        _profileController.sink.add(value);
      }).catchError((err) {
        _profileIsFetching = false;
      });
    }
    return _profileController.stream;
  }

  Future changePassword({newPassword, oldPassword}) {
    return _userRepo.changePassword(
        newPassword: newPassword, oldPassword: oldPassword);
  }

  updateProfile(Map<String, dynamic> data, {File avatar}) async {
    try {
      setBusy(true);
      await _userRepo.updateProfile(data, avatar: avatar);
      _profileController = BehaviorSubject<UserProfileDTO>();
      fetchProfile();
    } catch (err) {
      setBusy(false);
      throw err;
    }
    setBusy(false);
  }

  Future changeStateOfResidence(Map<String, dynamic> data) async {
    try {
      setBusy(true);
      await _userRepo.changeStateOfResidence(data);
      _profileController = BehaviorSubject<UserProfileDTO>();
      fetchProfile();
    } catch (err) {
      setBusy(false);
      throw err;
    }
    setBusy(false);
  }

  Future updateFCMToken(String token) async {
    try {
      var oldToken = await _userRepo.getFcmToken();

      if (oldToken == token) return;
      setBusy(true);

      await _userRepo.updateProfile({"fcmToken": token});
      _userRepo.saveFCMToken(token);
    } catch (err) {
      setBusy(false);
      throw err;
    }
    setBusy(false);
  }

  @override
  void dispose() {
    _profileController.close();
    super.dispose();
  }

  Future<void> forgotPassword(String email) async {
    try {
      setBusy(true);
      await _userRepo.forgotPassword(email);
    } catch (err) {
      setBusy(false);
      throw err;
    }
    setBusy(false);
  }

  Future<UserDTO> socialAuth(token, isGoogle) async {
    try {
      setBusy(true);
      var user = await _userRepo.socialAuth(token, isGoogle);

      setBusy(false);
      return user;
    } catch (err) {
      setBusy(false);
      throw err;
    }
    setBusy(false);
  }
}
