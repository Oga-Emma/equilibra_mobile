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
  BehaviorSubject<UserProfileDTO> _profileController =
      BehaviorSubject<UserProfileDTO>();

  UserDTO user;
  UserProfileDTO userProfile;
  List voted = [];

  Stream<UserProfileDTO> fetchProfile({bool force = false}) {
    if (force) {
      _profileController.sink.add(null);
    }

    if (force || (userProfile == null && !_profileIsFetching)) {
      _profileIsFetching = true;
      _userRepo.fetchMyProfile().then((value) {
        userProfile = value;
        _profileIsFetching = false;
        _profileController.sink.add(value);
      }).catchError((err) {
        _profileIsFetching = false;
      });
    }
    /*else {
      if (userProfile != null) {
        _profileController.sink.add(userProfile);
      }
    }*/
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
      fetchProfile(force: true);
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
      fetchProfile(force: true);
    } catch (err) {
      setBusy(false);
      throw err;
    }
    setBusy(false);
  }

  Future updateFCMToken(String token) async {
    // print("updating token => $token");
    try {
      // var oldToken = await _userRepo.getFcmToken();
      //
      // if (oldToken == token) return;
      // setBusy(true);

      await _userRepo.updateProfile({
        "fcmTokens": {"mobile": token}
      });
      _userRepo.saveFCMToken(token);
    } catch (err) {
      // print(err);
      // setBusy(false);
      throw err;
    }
    // setBusy(false);
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

  void logout() {
    user = null;
    userProfile = null;
    voted = [];
    _profileIsFetching = false;
    _profileController = BehaviorSubject();
  }

  void sendFeedback(String text) {
    var firstname, lastName;

    List split = user.fullName.split(" ");
    if (split.length > 1) {
      firstname = split[0];
      lastName = split[1];
    } else if (split.length == 1) {
      firstname = split[0];
      lastName = "";
    } else {
      firstname = "Anonymous";
      lastName = "";
    }
    _userRepo.sendFeedback(
        message: text,
        firstName: firstname,
        lastName: lastName,
        email: user.email);
  }
}
