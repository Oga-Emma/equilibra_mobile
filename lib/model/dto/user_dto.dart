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
