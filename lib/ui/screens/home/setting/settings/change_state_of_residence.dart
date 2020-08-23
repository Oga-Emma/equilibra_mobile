import 'dart:io';

import 'package:equilibra_mobile/model/dto/complete_signup_dto.dart';
import 'package:equilibra_mobile/model/dto/government_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:equilibra_mobile/ui/core/utils/svg_icon_utils.dart';
import 'package:equilibra_mobile/ui/core/widgets/dialogs.dart';
import 'package:equilibra_mobile/ui/core/widgets/e_button.dart';
import 'package:equilibra_mobile/ui/core/widgets/e_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/custom_snackbar/ui_snackbar.dart';
import 'package:helper_widgets/empty_space.dart';
import 'package:helper_widgets/string_utils/string_utils.dart';
import 'package:helper_widgets/validators.dart';

class ChangeStateOfResidence extends StatefulWidget {
  @override
  _ChangeStateOfResidenceState createState() => _ChangeStateOfResidenceState();
}

class _ChangeStateOfResidenceState extends State<ChangeStateOfResidence>
    with UISnackBarProvider {
  var _formkey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var completeSignup = CompleteSignupDTO();

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

  String _message = "Please select your state of residence";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Current State of Residence"),
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              EDropDownTextField(
                validator: Validators.validateString(),
                controller: stateController,
                hintText: "What state do you live in?",
                icon: SvgIconUtils.getSvgIcon(SvgIconUtils.PERSON_AVATER,
                    width: 20, height: 20),
                onTap: () async {
                  GovernmentDTO government = await showDialog(
                      context: context,
                      builder: (context) => SelectStateDialog());

                  if (government != null) {
                    completeSignup.stateOfResidence = government;
                    stateController.text =
                        StringUtils.toTitleCase(government.name);

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
                hintText: "What LGA do you live in?",
                icon: SvgIconUtils.getSvgIcon(SvgIconUtils.LOCK,
                    width: 20, height: 20),
                onTap: () async {
                  if (completeSignup.stateOfResidence == null) {
                    onError(_message);
                  } else {
                    RoomDTO lga = await showDialog(
                        context: context,
                        builder: (context) => SelectLgaDialog(
                            completeSignup.stateOfResidence.id));
                    if (lga != null) {
                      completeSignup.localGovtOfResidence = lga;
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
                  if (completeSignup.stateOfResidence == null) {
                    onError(_message);
                  } else {
                    RoomDTO room = await showDialog(
                        context: context,
                        builder: (context) => SelectFederalConstituencyDialog(
                            completeSignup.stateOfResidence.id));
                    if (room != null) {
                      completeSignup.stateOfResidenceFedConstituency = room;
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
                  if (completeSignup.stateOfResidence == null) {
                    onError(_message);
                  } else {
                    RoomDTO room = await showDialog(
                        context: context,
                        builder: (context) => SelectSenatorialDialog(
                            completeSignup.stateOfResidence.id));
                    if (room != null) {
                      completeSignup.stateOfResidenceSenatorialDistrict = room;
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
                  if (completeSignup.stateOfResidence == null) {
                    onError(_message);
                  } else {
                    RoomDTO room = await showDialog(
                        context: context,
                        builder: (context) => SelectStateConstituencyDialog(
                            completeSignup.stateOfResidence.id));
                    if (room != null) {
                      completeSignup.stateOfResidenceConstituency = room;
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
                      onError("Please select your state of residence");
                    } else if (StringUtils.isEmpty(lgaController.text)) {
                      onError("Please select your LGA of residence");
                    } else if (StringUtils.isEmpty(
                        federalConstituencyController.text)) {
                      onError(
                          "Please select your state of residence's federal constituency");
                    } else if (StringUtils.isEmpty(
                        senatorialDistrictController.text)) {
                      onError(
                          "Please select your state of residence's senatorial district");
                    } else if (StringUtils.isEmpty(
                        stateConstituencyController.text)) {
                      onError(
                          "Please select your state of residence's state constituency");
                    } else {
                      saveChanges();
                    }
//                    Router.gotoWidget(PlaceOfResidenceScreen(), context);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  onError(err) {
    showInSnackBar(context, err);
  }

  void saveChanges() {}
}
