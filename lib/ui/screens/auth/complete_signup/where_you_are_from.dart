import 'package:equilibra_mobile/model/dto/complete_signup_dto.dart';
import 'package:equilibra_mobile/ui/core/utils/svg_icon_utils.dart';
import 'package:equilibra_mobile/ui/core/widgets/e_button.dart';
import 'package:equilibra_mobile/ui/core/widgets/e_dropdown.dart';
import 'package:equilibra_mobile/ui/core/widgets/helper.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/empty_space.dart';

import '../auth_viewmodel.dart';

class PlaceOfOriginScreen extends StatefulWidget {
  PlaceOfOriginScreen(this.completeSignup,
      {@required this.onNext, this.onError});
  Function() onNext;
  Function(String) onError;
  CompleteSignupDTO completeSignup;

  @override
  _PlaceOfOriginScreenState createState() => _PlaceOfOriginScreenState();
}

class _PlaceOfOriginScreenState extends State<PlaceOfOriginScreen> {
  var _formkey = GlobalKey<FormState>();

  var stateController = TextEditingController();
  var lgaController = TextEditingController();
  var federalConstituencyController = TextEditingController();
  var senatorialDistrictController = TextEditingController();
  var stateConstituencyController = TextEditingController();

  TitleId state;
  TitleId lga;
  TitleId fedConstituency;
  TitleId senatorialDistrict;
  TitleId stateConstituency;

  @override
  void dispose() {
    stateController.dispose();
    lgaController.dispose();
    federalConstituencyController.dispose();
    senatorialDistrictController.dispose();
    stateConstituencyController.dispose();
    super.dispose();
  }

  String _message = "Please select your state of origin";
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          EDropDownTextField(
            controller: stateController,
            hintText: "What state are you from?",
            icon: SvgIconUtils.getSvgIcon(SvgIconUtils.PERSON_AVATER,
                width: 20, height: 20),
            onTap: () async {
//              TitleId state = await showDialog(
//                  context: context,
//                  builder: (context) => AlertDialog(
//                        content: FilterableList(widget.states),
//                      ));
//
//              if (state != null) {
//                this.state = state;
//                stateController.text = StringUtils.toTitleCase(state.name);
//                widget.completeSignup.stateOfOrigin = state.id;
//              }
            },
          ),
          EmptySpace(multiple: 2),
          EDropDownTextField(
            controller: lgaController,
            hintText: "What LGA are you from?",
            icon: SvgIconUtils.getSvgIcon(SvgIconUtils.LOCK,
                width: 20, height: 20),
            onTap: () async {
//              if (state == null) {
//                widget.onError(_message);
//              } else {
//                var lga = await showDialog(
//                    context: context,
//                    builder: (context) => SelectLgaDialog(state.id));
//                if (lga != null) {
//                  this.lga = lga;
//                  lgaController.text = StringUtils.toTitleCase(lga.name);
//                  widget.completeSignup.localGovtOrigin = lga.id;
//
////                    name = StringUtils.toTitleCase(name);
////                    newLga = lga;
////                    newLgaController.text = name;
//                }
//              }
            },
          ),
          EmptySpace(multiple: 2),
          EDropDownTextField(
            controller: federalConstituencyController,
            hintText: "Federal Constituency?",
            icon: SvgIconUtils.getSvgIcon(SvgIconUtils.LOCK,
                width: 20, height: 20),
            onTap: () async {
//              if (state == null) {
//                widget.onError(_message);
//              } else {
//                var fedConstituency = await showDialog(
//                    context: context,
//                    builder: (context) =>
//                        SelectFederalConstituencyDialog(state.id));
//                if (fedConstituency != null) {
//                  this.fedConstituency = fedConstituency;
//                  federalConstituencyController.text =
//                      StringUtils.toTitleCase(fedConstituency.name);
//                  widget.completeSignup.stateFedConstituency =
//                      fedConstituency.id;
////                    name = StringUtils.toTitleCase(name);
////                    newLga = lga;
////                    newLgaController.text = name;
//                }
//              }
            },
          ),
          EmptySpace(multiple: 2),
          EDropDownTextField(
              controller: senatorialDistrictController,
              hintText: "Senatorial District?",
              icon: SvgIconUtils.getSvgIcon(SvgIconUtils.LOCK,
                  width: 20, height: 20),
              onTap: () async {
//                if (state == null) {
//                  widget.onError(_message);
//                } else {
//                  var senatorialDisctrict = await showDialog(
//                      context: context,
//                      builder: (context) =>
//                          SelectSenatorialDialog(state.id));
//                  if (senatorialDisctrict != null) {
//                    this.senatorialDistrict = senatorialDisctrict;
//                    senatorialDistrictController.text =
//                        StringUtils.toTitleCase(senatorialDisctrict.name);
//                    widget.completeSignup.senatorialDistrict =
//                        senatorialDisctrict.id;
////                    name = StringUtils.toTitleCase(name);
////                    newLga = lga;
////                    newLgaController.text = name;
//                  }
//                }
              }),
          EmptySpace(multiple: 2),
          EDropDownTextField(
            controller: stateConstituencyController,
            hintText: "State Constituency?",
            icon: SvgIconUtils.getSvgIcon(SvgIconUtils.LOCK,
                width: 20, height: 20),
            onTap: () async {
//              if (state == null) {
//                widget.onError(_message);
//              } else {
//                var stateConstituency = await showDialog(
//                    context: context,
//                    builder: (context) =>
//                        SelectStateConstituencyDialog(state.id));
//                if (stateConstituency != null) {
//                  this.stateConstituency = stateConstituency;
//                  stateConstituencyController.text =
//                      StringUtils.toTitleCase(stateConstituency.name);
//                  widget.completeSignup.stateConstituency =
//                      stateConstituency.id;
////                    name = StringUtils.toTitleCase(name);
////                    newLga = lga;
////                    newLgaController.text = name;
//                }
//              }
            },
          ),
          EmptySpace(multiple: 2),
          EButton(
              label: "Next",
              onTap: () {
//                if (widget.completeSignup.stateOfOrigin == null) {
//                  widget.onError("Please select your state of origin");
//                } else if (widget.completeSignup.localGovtOrigin == null) {
//                  widget.onError("Please select your LGA of origin");
//                } else if (widget.completeSignup.stateFedConstituency ==
//                    null) {
//                  widget.onError(
//                      "Please select your state of origin's federal constituency");
//                } else if (widget.completeSignup.senatorialDistrict ==
//                    null) {
//                  widget.onError(
//                      "Please select your state of origin's senatorial district");
//                } else if (widget.completeSignup.stateConstituency ==
//                    null) {
//                  widget.onError(
//                      "Please select your state of origin's state constituency");
//                } else {

//                }
//                    Router.gotoWidget(PlaceOfResidenceScreen(), context);
              }),
        ],
      ),
    );
  }
}
