import 'dart:io';

import 'package:equilibra_mobile/di/controllers/user_controller.dart';
import 'package:equilibra_mobile/model/dto/complete_signup_dto.dart';
import 'package:equilibra_mobile/model/dto/government_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:equilibra_mobile/model/dto/user_dto.dart';
import 'package:equilibra_mobile/ui/core/utils/svg_icon_utils.dart';
import 'package:equilibra_mobile/ui/core/widgets/dialogs.dart';
import 'package:equilibra_mobile/ui/core/widgets/e_button.dart';
import 'package:equilibra_mobile/ui/core/widgets/e_dropdown.dart';
import 'package:equilibra_mobile/ui/core/widgets/e_form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/custom_snackbar/ui_snackbar.dart';
import 'package:helper_widgets/empty_space.dart';
import 'package:helper_widgets/error_handler.dart';
import 'package:helper_widgets/loading_spinner.dart';
import 'package:helper_widgets/string_utils/string_utils.dart';
import 'package:helper_widgets/validators.dart';

class ChangeStateOfResidence extends StatefulWidget {
  @override
  _ChangeStateOfResidenceState createState() => _ChangeStateOfResidenceState();
}

class _ChangeStateOfResidenceState extends State<ChangeStateOfResidence>
    with UISnackBarProvider, ErrorHandler {
  var _formkey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var stateController = TextEditingController();
  var lgaController = TextEditingController();
  var federalConstituencyController = TextEditingController();
  var senatorialDistrictController = TextEditingController();
  var stateConstituencyController = TextEditingController();

  var state, lga, federalConstituency, senate, stateConstituency;

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

  UserController controller;
  @override
  Widget build(BuildContext context) {
    controller = Provider.of<UserController>(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Change State of Residence"),
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: StreamBuilder<UserProfileDTO>(
            stream: controller.fetchProfile(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LoadingSpinner();
              var user = snapshot.data;
              return Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Current state of Residence"),
                    EmptySpace(multiple: 0.5),
                    EFormTextField(
                      isEnabled: false,
                      labelText: "",
                      initialValue:
                          StringUtils.toTitleCase(user.stateOfResidence.name),
                    ),
                    EmptySpace(multiple: 2),
                    Text("New state of Residence"),
                    EmptySpace(multiple: 0.5),
                    EDropDownTextField(
                      validator: Validators.validateString(),
                      controller: stateController,
                      hintText: "New state where I live",
                      icon: SvgIconUtils.getSvgIcon(SvgIconUtils.PERSON_AVATER,
                          width: 20, height: 20),
                      onTap: () async {
                        GovernmentDTO government = await showDialog(
                            context: context,
                            builder: (context) => SelectStateDialog());

                        if (government != null) {
                          state = government.id;
                          stateController.text =
                              StringUtils.toTitleCase(government.name);

                          lgaController.text = "";
                          federalConstituencyController.text = "";
                          senatorialDistrictController.text = "";
                          stateConstituencyController.text = "";
                        }
                      },
                    ),
                    EmptySpace(multiple: 2),
                    Text("What LGA do you live in?"),
                    EmptySpace(multiple: 0.5),
                    EDropDownTextField(
                      validator: Validators.validateString(),
                      controller: lgaController,
                      hintText: "LGA Location",
                      icon: SvgIconUtils.getSvgIcon(SvgIconUtils.LOCK,
                          width: 20, height: 20),
                      onTap: () async {
                        if (state == null) {
                          onError(_message);
                        } else {
                          RoomDTO selectedLga = await showDialog(
                              context: context,
                              builder: (context) => SelectLgaDialog(state));
                          if (selectedLga != null) {
                            lga = selectedLga.id;
                            lgaController.text =
                                StringUtils.toTitleCase(selectedLga.name);
                          }
                        }
                      },
                    ),
                    EmptySpace(multiple: 2),
                    Text("Federal Constituencies"),
                    EmptySpace(multiple: 0.5),
                    EDropDownTextField(
                      validator: Validators.validateString(),
                      controller: federalConstituencyController,
                      hintText: "Federal Constituency?",
                      icon: SvgIconUtils.getSvgIcon(SvgIconUtils.LOCK,
                          width: 20, height: 20),
                      onTap: () async {
                        if (state == null) {
                          onError(_message);
                        } else {
                          RoomDTO room = await showDialog(
                              context: context,
                              builder: (context) =>
                                  SelectFederalConstituencyDialog(state));
                          if (room != null) {
                            federalConstituency = room.id;
                            federalConstituencyController.text =
                                StringUtils.toTitleCase(room.name);
                          }
                        }
                      },
                    ),
                    EmptySpace(multiple: 2),
                    Text("Senatorial District"),
                    EmptySpace(multiple: 0.5),
                    EDropDownTextField(
                      validator: Validators.validateString(),
                      controller: senatorialDistrictController,
                      hintText: "Senatorial District?",
                      icon: SvgIconUtils.getSvgIcon(SvgIconUtils.LOCK,
                          width: 20, height: 20),
                      onTap: () async {
                        if (state == null) {
                          onError(_message);
                        } else {
                          RoomDTO room = await showDialog(
                              context: context,
                              builder: (context) =>
                                  SelectSenatorialDialog(state));
                          if (room != null) {
                            senate = room.id;
                            senatorialDistrictController.text =
                                StringUtils.toTitleCase(room.name);
                          }
                        }
                      },
                    ),
                    EmptySpace(multiple: 2),
                    Text("State Constituency?"),
                    EmptySpace(multiple: 0.5),
                    EDropDownTextField(
                      validator: Validators.validateString(),
                      controller: stateConstituencyController,
                      hintText: "State Constituency?",
                      icon: SvgIconUtils.getSvgIcon(SvgIconUtils.LOCK,
                          width: 20, height: 20),
                      onTap: () async {
                        if (state == null) {
                          onError(_message);
                        } else {
                          RoomDTO room = await showDialog(
                              context: context,
                              builder: (context) =>
                                  SelectStateConstituencyDialog(state));
                          if (room != null) {
                            stateConstituency = room.id;
                            stateConstituencyController.text =
                                StringUtils.toTitleCase(room.name);
                            setState(() {});
                          }
                        }
                      },
                    ),
                    EmptySpace(multiple: 2),
                    EButton(
                        loading: controller.isBusy,
                        label: "Update Residence",
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
              );
            }),
      ),
    );
  }

  onError(err) {
    showInSnackBar(context, err);
  }

  Future<void> saveChanges() async {
    try {
      var res = await controller.changeStateOfResidence({
        "stateOfResidence": state,
        "localGovtOfResidence": lga,
        "stateOfResidenceFedConstituency": federalConstituency,
        "stateOfResidenceSenatorialDistrict": senate,
        "stateOfResidenceConstituency": stateConstituency
      });

      if (StringUtils.isNotEmpty(res)) {
        showInSnackBar(context, "$res");
      }
    } catch (err) {
      showInSnackBar(context, getErrorMessage(err, "Error saving changes"));
    }
  }
}
