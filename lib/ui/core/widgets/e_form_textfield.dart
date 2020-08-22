import 'package:equilibra_mobile/ui/core/res/palet.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/empty_space.dart';

class EFormTextField extends StatelessWidget {
  EFormTextField(
      {@required this.labelText,
      this.onSaved,
      this.validator,
      this.controller,
      this.obscureText = false,
      this.autoValidate = false,
      this.isEnabled = true,
      this.inputType = TextInputType.text,
      this.initialValue,
      this.showDropDownArrow = false,
      this.isLastTextField = false});
  final String labelText;
  final String initialValue;
  final Function(String) onSaved;
  final Function(String) validator;
  final TextEditingController controller;
  final bool autoValidate;
  final bool obscureText;
  final bool isEnabled;
  final bool showDropDownArrow;
  final TextInputType inputType;
  final bool isLastTextField;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("$labelText"),
        EmptySpace(),
        ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
                color: isEnabled ? Colors.transparent : Colors.grey[300],
                border: Border.all(color: Pallet.accentColor.withOpacity(0.3))),
            child: IgnorePointer(
              ignoring: !isEnabled,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      initialValue: initialValue,
                      onSaved: onSaved,
                      validator: validator,
                      autovalidate: autoValidate,
                      obscureText: obscureText,
                      keyboardType: inputType,
                      textInputAction: isLastTextField
                          ? TextInputAction.done
                          : TextInputAction.next,
                      onFieldSubmitted: (_) => isLastTextField
                          ? null
                          : FocusScope.of(context).nextFocus(),
                      decoration: InputDecoration.collapsed(hintText: ""),
                    ),
                  ),
                  showDropDownArrow ? EmptySpace() : SizedBox(),
                  showDropDownArrow
                      ? Icon(EvaIcons.arrowIosDownwardOutline,
                          size: 20, color: Colors.grey)
                      : SizedBox()
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
