import 'filterable_list_item.dart';

class GovernmentDTO extends FilterableListItem {
  var leader; //": "okezie ikpeazu",
  var leaderPhoto; //": "https://res.cloudinary.com/theequilibra/image/upload/v1593955879/Image_05-07-2020_at_2.30_PM_lj6oib.jpg",
  var senatePresident; //": "",
  var senatePresidentPhoto; //": "https://picsum.photos/200",
  var cjn; //": "josiah bishop",
  var cjnPhoto; //": "https://picsum.photos/200",
  var speaker; //": "ingram bassam",
  var speakerPhoto; //": "https://res.cloudinary.com/theequilibra/image/upload/v1594218451/4th_Sun_Cover_s8tnqg.jpg",
  var bannerPhoto; //": "https://res.cloudinary.com/theequilibra/image/upload/v1595777735/snipe_capital_mistakes_whrifb.jpg",
  var touristAttractionCenters; //": [
//  "Arochukwuk caves, Azumimi river",
//  "Enemaba warm spring,Akwette weaving centre",
//  "Agbagwu slave market, Long juju of Arochukwu"
//  ],
  var mineralResources; //": [
//  "Clay and Coal"
//  ],
  var agriculture; //": [
//  "Cashew ",
//  "Rubber",
//  "Plantain"
//  ],
  var museumsAndParks; //": [
//  "National museum of colonial history ",
//  "National war museum"
//  ],
  var id; //": "5e3d4a46fb9e016690a5b898",
  var name; //": "abia state",
  var slug; //": "AB",
  var description; //": "<p>abia colony, home to enyimba football club of aba, two time african champion league winners (2003 &amp; 2004) was created on 27th august, 1991, by the then federal military government under general lbrahim babangida, out of imo state.</p><p>“abia” is an acronym formed from the initial letters of four groups of people, namely:</p><p>aba, bende, lsuikwuato and afikpo. these constituted the major groups in the state at its creation.</p><p>located in the southeastern region of nigeria, abia state lies within approximately latitudes 4° 40′ and 6° 14′</p><p>north, and longitudes 7° 10′ and 8° east.</p>",
  var slogan; //": "God's Own State",
  var powerGenerated; //": null,
  var budgetSubmissionDate; //": null,
  var budgetPassDate; //": null,
  var totalLg; //": 17,
  var population; //": 3700000,
  var totalStateConstituency; //": 3,
  var infantMortalityRate; //": 62.4,
  var literacyRate; //": 94.24,
  var unemploymentRate; //": 11.2,
  var foreignReserve; //": 0,
  var crimeRate; //": null,
  var inflationRate; //": null,
  var gdpPerHead; //": null,
  var nonOilSectorContributionToGDP; //": 0,
  var budgetPerformanceRate; //": null,
  var plenaryAttendanceRate; //": null,
  var rulingParty; //": "PDP",
  var createdAt; //": "2015-10-21T11:01:35.000Z",
  var updatedAt; //": "2020-08-16T08:44:42.155Z",
  var category; //": "5e3d4a46fb9e016690a5b896",
  var __v; //": 0,
  var stateGovernment; //": null,
  var dateCreated; //": "1991-08-26T23:00:00.000Z",
  var totalConstituency; //": 8,
  var accessToPortableWater; //": "87.95",
  var totalGirlsMarriedBeforeFifteen; //": 17.4,
  var totalSenatorialDistricts; //": 3

  GovernmentDTO.fromMap(Map<String, dynamic> data) {
    leader = data["leader"];
    leaderPhoto = data["leaderPhoto"];
    senatePresident = data["senatePresident"];
    senatePresidentPhoto = data["senatePresidentPhoto"];
    cjn = data["cjn"];
    cjnPhoto = data["cjnPhoto"];
    speaker = data["speaker"];
    speakerPhoto = data["speakerPhoto"];
    bannerPhoto = data["bannerPhoto"];
    touristAttractionCenters = data["touristAttractionCenters"];
    mineralResources = data["mineralResources"];
    agriculture = data["agriculture"];
    museumsAndParks = data["museumsAndParks"];
    id = data["_id"];
    name = data["name"];
    slug = data["slug"];
    description = data["description"];
    slogan = data["slogan"];
    powerGenerated = data["powerGenerated"];
    budgetSubmissionDate = data["budgetSubmissionDate"];
    budgetPassDate = data["budgetPassDate"];
    totalLg = data["totalLg"];
    population = data["population"];
    totalStateConstituency = data["totalStateConstituency"];
    infantMortalityRate = data["infantMortalityRate"];
    literacyRate = data["literacyRate"];
    unemploymentRate = data["unemploymentRate"];
    foreignReserve = data["foreignReserve"];
    crimeRate = data["crimeRate"];
    inflationRate = data["inflationRate"];
    gdpPerHead = data["gdpPerHead"];
    nonOilSectorContributionToGDP = data["nonOilSectorContributionToGDP"];
    budgetPerformanceRate = data["budgetPerformanceRate"];
    plenaryAttendanceRate = data["plenaryAttendanceRate"];
    rulingParty = data["rulingParty"];
    createdAt = data["createdAt"];
    updatedAt = data["updatedAt"];
    category = data["category"];
    __v = data["__v"];
    stateGovernment = data["stateGovernment"];
    dateCreated = data["dateCreated"];
    totalConstituency = data["totalConstituency"];
    accessToPortableWater = data["accessToPortableWater"];
    totalGirlsMarriedBeforeFifteen = data["totalGirlsMarriedBeforeFifteen"];
    totalSenatorialDistricts = data["totalSenatorialDistricts"];
  }
}
