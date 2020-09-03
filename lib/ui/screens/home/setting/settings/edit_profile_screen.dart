import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:equilibra_mobile/di/controllers/user_controller.dart';
import 'package:equilibra_mobile/model/dto/user_dto.dart';
import 'package:equilibra_mobile/ui/core/widgets/custom_dialogs.dart';
import 'package:equilibra_mobile/ui/core/widgets/e_button.dart';
import 'package:equilibra_mobile/ui/core/widgets/e_form_textfield.dart';
import 'package:equilibra_mobile/ui/core/widgets/image_preview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/custom_snackbar/ui_snackbar.dart';
import 'package:helper_widgets/empty_space.dart';
import 'package:helper_widgets/error_handler.dart';
import 'package:helper_widgets/loading_spinner.dart';
import 'package:helper_widgets/string_utils/string_utils.dart';
import 'package:helper_widgets/validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../input_validators.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with UISnackBarProvider, ErrorHandler {
  var _formkey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  var _monthController = TextEditingController();
  var _yearController = TextEditingController();

  File image;
  bool _autoValidate = false;
  String fullName = "";
  String userName = "";
  String birthYear, birthMonth;

  UserProfileDTO user;
  UserController controller;

  @override
  void dispose() {
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller = Provider.of<UserController>(context);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Edit Profile"),
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back_ios)),
        ),
        body: StreamBuilder<UserProfileDTO>(
            stream: controller.fetchProfile(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                user = snapshot.data;

                if (StringUtils.isEmpty(_monthController.text)) {
                  _monthController.text = user.birthMonth;
                }

                if (StringUtils.isEmpty(_yearController.text)) {
                  _yearController.text = user.birthYear;
                }
                return Form(
                  key: _formkey,
                  child: Container(
                    padding: EdgeInsets.all(24.0),
                    child: ListView(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                if (image != null) {
                                  showImagePreview(context, file: image);
                                } else if (StringUtils.isNotEmpty(
                                    user.avatar)) {
                                  showImagePreview(context,
                                      imageUrl: user.avatar);
                                }
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4.0),
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      height: 100,
                                      width: 100,
                                      color: Colors.grey[300],
                                      child: Image(
                                          image: image != null
                                              ? FileImage(image)
                                              : CachedNetworkImageProvider(
                                                  user.avatar),
                                          fit: BoxFit.cover),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        color: Colors.black12,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 4,
                                      right: 4,
                                      child: InkWell(
                                        onTap: _selectImage,
                                        child: Icon(Icons.camera_alt,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            EmptySpace(),
                            Expanded(
                                child: EFormTextField(
                              labelText: "Email Address",
                              isEnabled: false,
                              initialValue: user.email,
                            ))
                          ],
                        ),
                        EmptySpace(multiple: 3),
                        EFormTextField(
                            autoValidate: _autoValidate,
                            labelText: "Username",
                            validator: Validators.validateString(),
                            onSaved: (value) {
                              userName = value;
                            },
                            initialValue: user.username),

                        EmptySpace(multiple: 2),
                        EFormTextField(
                            autoValidate: _autoValidate,
                            labelText: "Full Name",
                            isEnabled: true,
                            validator: InputValidators.validateString,
                            initialValue: user.fullName,
                            onSaved: (value) {
                              fullName = value;
                            }),
                        EmptySpace(multiple: 2),

                        GestureDetector(
                            onTap: () => _selectDate(),
                            child: AbsorbPointer(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: EFormTextField(
                                      controller: _monthController,
                                      labelText: "Birth Month",
                                      validator: Validators.validateString(),
                                      onSaved: (value) {
                                        birthMonth = value;
                                      },
                                    ),
                                  ),
                                  EmptySpace.horizontal(multiple: 2),
                                  Expanded(
                                    child: EFormTextField(
                                      controller: _yearController,
                                      labelText: "Birth Year",
                                      validator: Validators.validateString(),
                                      onSaved: (value) {
                                        birthYear = value;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )),
//              EmptySpace(multiple: 2),
//              EFormTextField(labelText: "Phone Number", isEnabled: true, initialValue: user.phoneNumber),
//                EmptySpace(multiple: 2),
//                EFormTextField(
//                    labelText: "Date of birth",
//                    isEnabled: false,
//                    initialValue: getDateOfBirth(userb)),
                        EmptySpace(multiple: 3),
                        EButton(
                            label: "Update Profile",
                            onTap: updateProfile,
                            loading: controller.isBusy),
                      ],
                    ),
                  ),
                );
              }
              return LoadingSpinner();
            }));
  }

  updateProfile() async {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      try {
        await controller.updateProfile({
          "fullName": fullName,
          "username": userName,
          "birthMonth": birthMonth,
          "birthYear": birthYear,
        }, avatar: image);

        showInSnackBar(context, "Account updated");
      } catch (err) {
        showInSnackBar(context, getErrorMessage(err, "Error saving changes"));
      }
    }
  }

  Future _selectImage() async {
    File file = await showChooserDialog(context);
    if (file != null) {
      image = file;
      setState(() {});
    }
  }

  @override
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  var dateFormat = DateFormat("yyyy - MMMM - dd");
  DateTime selectedDate = DateTime.now();
  Future<Null> _selectDate() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime(1990, 1), //selectedDate,
        firstDate: DateTime(1960, 1),
        lastDate: DateTime(DateTime.now().year - 15));
    if (picked != null && picked != selectedDate) {
      var split = dateFormat.format(picked).split(' - ');
      print(split);
      _monthController.text = split[1];
      _yearController.text = split[0];
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
