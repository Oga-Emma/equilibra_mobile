import 'package:equilibra_mobile/model/dto/government_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';

class CompleteSignupDTO {
  GovernmentDTO stateOfOrigin;
  RoomDTO localGovtOfOrigin;
  RoomDTO stateOfOriginFedConstituency;
  RoomDTO stateOfOriginSenatorialDistrict;
  RoomDTO stateOfOriginConstituency;

  GovernmentDTO stateOfResidence;
  RoomDTO localGovtOfResidence;
  RoomDTO stateOfResidenceFedConstituency;
  RoomDTO stateOfResidenceSenatorialDistrict;
  RoomDTO stateOfResidenceConstituency;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "stateOfOrigin": stateOfOrigin.id,
      "localGovtOfOrigin": localGovtOfOrigin.id,
      "stateOfOriginFedConstituency": stateOfOriginFedConstituency.id,
      "stateOfOriginSenatorialDistrict": stateOfOriginSenatorialDistrict.id,
      "stateOfOriginConstituency": stateOfOriginConstituency.id,
      "stateOfResidence": stateOfResidence.id,
      "localGovtOfResidence": localGovtOfResidence.id,
      "stateOfResidenceFedConstituency": stateOfResidenceFedConstituency.id,
      "stateOfResidenceSenatorialDistrict":
          stateOfResidenceSenatorialDistrict.id,
      "stateOfResidenceConstituency": stateOfResidenceConstituency.id,
      "signupStatus": true
    };
  }
}
