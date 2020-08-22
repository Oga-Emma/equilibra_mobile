class CompleteSignupDTO {
  var stateOfOrigin;
  var localGovtOfOrigin;
  var stateOfOriginFedConstituency;
  var stateOfOriginSenatorialDistrict;
  var stateOfOriginConstituency;

  var stateOfResidence;
  var localGovtOfResidence;
  var stateOfResidenceFedConstituency;
  var stateOfResidenceSenatorialDistrict;
  var stateOfResidenceConstituency;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "stateOfOrigin": stateOfOrigin,
      "localGovtOfOrigin": localGovtOfOrigin,
      "stateOfOriginFedConstituency": stateOfOriginFedConstituency,
      "stateOfOriginSenatorialDistrict": stateOfOriginSenatorialDistrict,
      "stateOfOriginConstituency": stateOfOriginConstituency,
      "stateOfResidence": stateOfResidence,
      "localGovtOfResidence": localGovtOfResidence,
      "stateOfResidenceFedConstituency": stateOfResidenceFedConstituency,
      "stateOfResidenceSenatorialDistrict": stateOfResidenceSenatorialDistrict,
      "stateOfResidenceConstituency": stateOfResidenceConstituency,
      "signupStatus": true
    };
  }
}
