import 'package:equilibra_mobile/model/dto/complete_signup_dto.dart';
import 'package:equilibra_mobile/model/dto/government_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:equilibra_mobile/ui/core/utils/svg_icon_utils.dart';
import 'package:equilibra_mobile/ui/core/widgets/dialogs.dart';
import 'package:equilibra_mobile/ui/core/widgets/e_button.dart';
import 'package:equilibra_mobile/ui/core/widgets/e_dropdown.dart';
import 'package:equilibra_mobile/ui/core/widgets/helper.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/empty_space.dart';
import 'package:helper_widgets/string_utils/string_utils.dart';
import 'package:helper_widgets/validators.dart';
import 'package:helper_widgets/validators.dart';
import 'package:helper_widgets/validators.dart';
import 'package:helper_widgets/validators.dart';
import 'package:helper_widgets/validators.dart';

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
            validator: Validators.validateString(),
            controller: stateController,
            hintText: "What state are you from?",
            icon: SvgIconUtils.getSvgIcon(SvgIconUtils.PERSON_AVATER,
                width: 20, height: 20),
            onTap: () async {
              GovernmentDTO government = await showDialog(
                  context: context, builder: (context) => SelectStateDialog());

              if (government != null) {
                widget.completeSignup.stateOfOrigin = government;
                stateController.text = StringUtils.toTitleCase(government.name);

                lgaController.text = "";
                federalConstituencyController.text = "";
                senatorialDistrictController.text = "";
                stateConstituencyController.text = "";

                setState(() {});
              }
            },
          ),
          EmptySpace(multiple: 2),
          EDropDownTextField(
            validator: Validators.validateString(),
            controller: lgaController,
            hintText: "What LGA are you from?",
            icon: SvgIconUtils.getSvgIcon(SvgIconUtils.LOCK,
                width: 20, height: 20),
            onTap: () async {
              if (widget.completeSignup.stateOfOrigin == null) {
                widget.onError(_message);
              } else {
                RoomDTO lga = await showDialog(
                    context: context,
                    builder: (context) => SelectLgaDialog(
                        widget.completeSignup.stateOfOrigin.id));
                if (lga != null) {
                  widget.completeSignup.localGovtOfOrigin = lga;
                  lgaController.text = StringUtils.toTitleCase(lga.name);
                  setState(() {});
                }
              }
            },
          ),
          EmptySpace(multiple: 2),
          EDropDownTextField(
            validator: Validators.validateString(),
            controller: federalConstituencyController,
            hintText: "Federal Constituency?",
            icon: SvgIconUtils.getSvgIcon(SvgIconUtils.LOCK,
                width: 20, height: 20),
            onTap: () async {
              if (widget.completeSignup.stateOfOrigin == null) {
                widget.onError(_message);
              } else {
                RoomDTO room = await showDialog(
                    context: context,
                    builder: (context) => SelectFederalConstituencyDialog(
                        widget.completeSignup.stateOfOrigin.id));
                if (room != null) {
                  widget.completeSignup.stateOfOriginFedConstituency = room;
                  federalConstituencyController.text =
                      StringUtils.toTitleCase(room.name);
                  setState(() {});
                }
              }
            },
          ),
          EmptySpace(multiple: 2),
          EDropDownTextField(
            validator: Validators.validateString(),
            controller: senatorialDistrictController,
            hintText: "Senatorial District?",
            icon: SvgIconUtils.getSvgIcon(SvgIconUtils.LOCK,
                width: 20, height: 20),
            onTap: () async {
              if (widget.completeSignup.stateOfOrigin == null) {
                widget.onError(_message);
              } else {
                RoomDTO room = await showDialog(
                    context: context,
                    builder: (context) => SelectSenatorialDialog(
                        widget.completeSignup.stateOfOrigin.id));
                if (room != null) {
                  widget.completeSignup.stateOfOriginSenatorialDistrict = room;
                  senatorialDistrictController.text =
                      StringUtils.toTitleCase(room.name);
                  setState(() {});
                }
              }
            },
          ),
          EmptySpace(multiple: 2),
          EDropDownTextField(
            validator: Validators.validateString(),
            controller: stateConstituencyController,
            hintText: "State Constituency?",
            icon: SvgIconUtils.getSvgIcon(SvgIconUtils.LOCK,
                width: 20, height: 20),
            onTap: () async {
              if (widget.completeSignup.stateOfOrigin == null) {
                widget.onError(_message);
              } else {
                RoomDTO room = await showDialog(
                    context: context,
                    builder: (context) => SelectStateConstituencyDialog(
                        widget.completeSignup.stateOfOrigin.id));
                if (room != null) {
                  widget.completeSignup.stateOfOriginConstituency = room;
                  stateConstituencyController.text =
                      StringUtils.toTitleCase(room.name);
                  setState(() {});
                }
              }
            },
          ),
          EmptySpace(multiple: 2),
          EButton(
              label: "Next",
              onTap: () {
                if (StringUtils.isEmpty(stateController.text)) {
                  widget.onError("Please select your state of origin");
                } else if (StringUtils.isEmpty(lgaController.text)) {
                  widget.onError("Please select your LGA of origin");
                } else if (StringUtils.isEmpty(
                    federalConstituencyController.text)) {
                  widget.onError(
                      "Please select your state of origin's federal constituency");
                } else if (StringUtils.isEmpty(
                    senatorialDistrictController.text)) {
                  widget.onError(
                      "Please select your state of origin's senatorial district");
                } else if (StringUtils.isEmpty(
                    stateConstituencyController.text)) {
                  widget.onError(
                      "Please select your state of origin's state constituency");
                } else {
                  widget.onNext();
                }
//                    Router.gotoWidget(PlaceOfResidenceScreen(), context);
              }),
        ],
      ),
    );
  }
}
