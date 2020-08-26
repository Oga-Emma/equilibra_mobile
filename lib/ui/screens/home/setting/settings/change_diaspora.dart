import 'package:equilibra_mobile/di/controllers/user_controller.dart';
import 'package:equilibra_mobile/model/dto/user_dto.dart';
import 'package:equilibra_mobile/ui/core/utils/countries_list.dart';
import 'package:equilibra_mobile/ui/core/widgets/e_button.dart';
import 'package:equilibra_mobile/ui/core/widgets/e_form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/custom_snackbar/ui_snackbar.dart';
import 'package:helper_widgets/custom_toasts.dart';
import 'package:helper_widgets/empty_space.dart';
import 'package:helper_widgets/error_handler.dart';
import 'package:helper_widgets/loading_spinner.dart';
import 'package:helper_widgets/string_utils/string_utils.dart';
import 'package:provider/provider.dart';

class ChangeDiaspora extends StatefulWidget {
  @override
  _ChangeDiasporaState createState() => _ChangeDiasporaState();
}

class _ChangeDiasporaState extends State<ChangeDiaspora>
    with UISnackBarProvider, ErrorHandler {
  var _formkey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  var oldCountryOfResidenceController = TextEditingController();
  var newCountryOfResidenceController = TextEditingController();

  dispose() {
    oldCountryOfResidenceController.dispose();
    newCountryOfResidenceController.dispose();
    super.dispose();
  }

  UserController controller;
  @override
  Widget build(BuildContext context) {
    controller = Provider.of<UserController>(context);

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Change Diaspora"),
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back_ios)),
        ),
        body: StreamBuilder<UserProfileDTO>(
            stream: controller.fetchProfile(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserDTO user = snapshot.data;

                if (StringUtils.isEmpty(oldCountryOfResidenceController.text)) {
                  oldCountryOfResidenceController.text = user.currentCountry;
                }
                return Form(
                  key: _formkey,
                  child: Container(
                    padding: EdgeInsets.all(24.0),
                    child: ListView(
                      children: <Widget>[
                        EFormTextField(
                          controller: oldCountryOfResidenceController,
                          labelText: "Current Country of Residence",
                          showDropDownArrow: true,
                          isEnabled: false,
                        ),
                        EmptySpace(multiple: 3),
                        InkWell(
                          onTap: () async {
                            var country = await showCountryPicker();
                            if (country.isNotEmpty) {
                              newCountryOfResidenceController.text = country;
                            }
                          },
                          child: IgnorePointer(
                            child: EFormTextField(
                                controller: newCountryOfResidenceController,
                                labelText: "New Country of Residence",
                                showDropDownArrow: true,
                                onSaved: (value) {}),
                          ),
                        ),
                        EmptySpace(multiple: 3),
                        EButton(
                            label: "Update Location",
                            onTap: updateLocation,
                            loading: controller.isBusy),
                      ],
                    ),
                  ),
                );
              }
              return LoadingSpinner();
            }));
  }

  Future<String> showCountryPicker() async {
    return await showDialog(
            context: context, builder: (context) => CountryDialog()) ??
        "";
  }

  @override
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  updateLocation() async {
    if (StringUtils.isEqualsIgnoreCase(newCountryOfResidenceController.text,
        oldCountryOfResidenceController.text)) return;

    if (StringUtils.isEmpty(newCountryOfResidenceController.text)) {
      showErrorToast("Select a country");
      return;
    }

    try {
      await controller.updateProfile(
          {"currentCountry": newCountryOfResidenceController.text});

      showInSnackBar(context, "Account updated");
    } catch (err) {
      showInSnackBar(context, getErrorMessage(err, "Error saving changes"));
    }
  }
}

class CountryDialog extends StatefulWidget {
  @override
  _CountryDialogState createState() => _CountryDialogState();
}

class _CountryDialogState extends State<CountryDialog> {
  var filterController = TextEditingController();

  String filterText = "";
  List<Map<String, dynamic>> countries = [];

  @override
  void dispose() {
    filterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    countries.clear();
    countries.addAll(countriesList.where(
        (country) => country['name'].toLowerCase().contains(filterText)));

    return AlertDialog(
      content: Container(
        height: MediaQuery.of(context).size.height / 1.5,
        width: double.maxFinite,
        child: Column(
          children: <Widget>[
            TextField(
              controller: filterController,
              decoration: InputDecoration(hintText: "Search country"),
              onChanged: (value) {
                setState(() {
                  filterText = value.toLowerCase();
                });
              },
            ),
            EmptySpace(),
            Expanded(
                child: ListView.builder(
                    itemCount: countries.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: Text(countries[index]['name']),
                          onTap: () =>
                              Navigator.pop(context, countries[index]['name']));
                    }))
          ],
        ),
      ),
    );
  }
}
