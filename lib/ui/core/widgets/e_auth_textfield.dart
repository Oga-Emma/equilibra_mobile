import 'package:equilibra_mobile/ui/core/res/palet.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/empty_space.dart';

import 'helper.dart';

class EAuthTextField extends StatelessWidget {
  EAuthTextField(
      {@required this.hintText,
      @required this.icon,
      this.onSaved,
      this.validator,
      this.controller,
      this.obscureText = false,
      this.autoValidate = false,
      this.inputType = TextInputType.text});
  String hintText;
  Widget icon;
  Function(String) onSaved;
  Function(String) validator;
  TextEditingController controller;
  bool autoValidate;
  bool obscureText;
  TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          EmptySpace(multiple: 1.5),
          icon,
          Container(
            color: Pallet.inputColor.withOpacity(0.5),
            height: 56,
            width: 1,
            margin: EdgeInsets.symmetric(horizontal: 12),
          ),
          Expanded(
            child: TextFormField(
              obscureText: obscureText,
              keyboardType: inputType,
              autovalidate: autoValidate,
              controller: controller,
              maxLines: 1,
              decoration: InputDecoration.collapsed(hintText: "$hintText"),
              validator: validator,
              onSaved: onSaved,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          border:
              Border.all(color: Pallet.inputColor.withOpacity(0.5), width: 1),
          borderRadius: radius),
    );
  }
}
