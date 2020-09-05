class UserDTO {
  var currentCountry; //": "Nigeria",
  var signupStatus; //": false,
  var avatar; //": "",
  var requestResetResidence; //": false,
  var pendingResetResidence; //": false,
  var confirmed; //": false,
  var suspended; //": false,
  var mutedRooms; //": [],
  var id; //": "5f40eca257c4e611f7925e7f",
  var email; //": "ogaemma2017@gmail.com",
  var fullName; //": "Seventy Seven",
  var password; //": "$2b$10$G0t086yTvLG/pJQh6Sx/0eaeOqRVMz/nfzbW1X2KHOR2ZaLOYS0Cq",
  var username; //": "seventy",
  var birthMonth; //": "March",
  var birthYear; //": "1995",
  var createdAt; //": "2020-08-22T10:00:02.732Z",

  UserDTO.fromMap(Map<String, dynamic> data) {
    currentCountry = data['currentCountry'];
    signupStatus = data['signupStatus'];
    avatar = data['avatar'];
    requestResetResidence = data['requestResetResidence'];
    pendingResetResidence = data['pendingResetResidence'];
    confirmed = data['confirmed'] ?? false;
    suspended = data['suspended'] ?? false;
    mutedRooms = data['mutedRooms'];
    id = data['_id'];
    email = data['email'];
    fullName = data['fullName'];
    password = data['password'];
    username = data['username'];
    birthMonth = data['birthMonth'];
    birthYear = data['birthYear'];
    createdAt = data['createdAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      "currentCountry": currentCountry,
      "signupStatus": signupStatus,
      "avatar": avatar,
      "requestResetResidence": requestResetResidence,
      "pendingResetResidence": pendingResetResidence,
      "confirmed": confirmed,
      "suspended": suspended,
      "mutedRooms": mutedRooms,
      "_id": id,
      "email": email,
      "fullName": fullName,
      "password": password,
      "username": username,
      "birthMonth": birthMonth,
      "birthYear": birthYear,
      "createdAt": createdAt,
    };
  }
}

class UserProfileDTO extends UserDTO {
  TitleID localGovtOfOrigin;
  TitleID localGovtOfResidence;
  TitleID stateOfOrigin;
  TitleID stateOfOriginConstituency;
  TitleID stateOfOriginFedConstituency;
  TitleID stateOfOriginSenatorialDistrict;
  TitleID stateOfResidence;
  TitleID stateOfResidenceConstituency;
  TitleID stateOfResidenceFedConstituency;
  TitleID stateOfResidenceSenatorialDistrict;
  UserProfileDTO.fromMap(Map<String, dynamic> data) : super.fromMap(data) {
    if (data['localGovtOfOrigin'] != null && data['localGovtOfOrigin'] is Map) {
      localGovtOfOrigin = TitleID.fromMap(data["localGovtOfOrigin"]);
    }
    if (data['localGovtOfResidence'] != null &&
        data['localGovtOfResidence'] is Map) {
      localGovtOfResidence = TitleID.fromMap(data["localGovtOfResidence"]);
    }
    if (data['stateOfOrigin'] != null && data['stateOfOrigin'] is Map) {
      stateOfOrigin = TitleID.fromMap(data["stateOfOrigin"]);
    }
    if (data['stateOfOriginConstituency'] != null &&
        data['stateOfOriginConstituency'] is Map) {
      stateOfOriginConstituency =
          TitleID.fromMap(data["stateOfOriginConstituency"]);
    }
    if (data['stateOfOriginFedConstituency'] != null &&
        data['stateOfOriginFedConstituency'] is Map) {
      stateOfOriginFedConstituency =
          TitleID.fromMap(data["stateOfOriginFedConstituency"]);
    }
    if (data['stateOfOriginSenatorialDistrict'] != null &&
        data['stateOfOriginSenatorialDistrict'] is Map) {
      stateOfOriginSenatorialDistrict =
          TitleID.fromMap(data["stateOfOriginSenatorialDistrict"]);
    }
    if (data['stateOfResidence'] != null && data['stateOfResidence'] is Map) {
      stateOfResidence = TitleID.fromMap(data["stateOfResidence"]);
    }
    if (data['stateOfResidenceConstituency'] != null &&
        data['stateOfResidenceConstituency'] is Map) {
      stateOfResidenceConstituency =
          TitleID.fromMap(data["stateOfResidenceConstituency"]);
    }
    if (data['stateOfResidenceFedConstituency'] != null &&
        data['stateOfResidenceFedConstituency'] is Map) {
      stateOfResidenceFedConstituency =
          TitleID.fromMap(data["stateOfResidenceFedConstituency"]);
    }
    if (data['stateOfResidenceSenatorialDistrict'] != null &&
        data['stateOfResidenceSenatorialDistrict'] is Map) {
      stateOfResidenceSenatorialDistrict =
          TitleID.fromMap(data["stateOfResidenceSenatorialDistrict"]);
    }
  }
}

class TitleID {
  var id; //": "5e3d4a48fb9e016690a5c0be",
  var name; //": "Uzo Uwani"
  TitleID.fromMap(Map<String, dynamic> data) {
    id = data['_id'];
    name = data['name'];
  }
}

class UserShortInfo {
  var id;
  String fullName;
  String username;
  String avatar;
  bool isSuspended;
  String role;

  UserShortInfo.fromMap(Map<dynamic, dynamic> data) {
    print(data);
    id = data['_id'] ?? "";
    fullName = data['fullName'] ?? "";
    username = data['username'] ?? "";
    avatar = data['avatar'] ?? "";
    isSuspended = data['isSuspended'] ?? false;
    role = data['role'] ?? "";
  }
}
