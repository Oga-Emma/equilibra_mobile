import 'package:equilibra_mobile/ui/core/res/palet.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/empty_space.dart';

import 'helper.dart';

class EDropDown extends StatelessWidget {
  EDropDown(
      {@required this.hintText,
      @required this.icon,
      this.onSaved,
      this.validator});
  String hintText;
  Widget icon;
  Function(String) onSaved;
  Function(String) validator;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          EmptySpace(multiple: 1.5),
          icon,
          Container(
            color: Pallet.inputColor.withOpacity(0.5),
            height: 48,
            width: 1,
            margin: EdgeInsets.symmetric(horizontal: 12),
          ),
          Expanded(
              child: DropdownButton<String>(
            items: []
                .map((str) => DropdownMenuItem<String>(
                      child: Text(str),
                    ))
                .toList(),
            onChanged: (selected) {
              print(selected);
            },
            hint: Text(
              hintText,
              style: TextStyle(color: Pallet.inputColor),
            ),
            isExpanded: true,
            underline: SizedBox(),
          )),
          EmptySpace(multiple: 1.5),
        ],
      ),
      decoration: BoxDecoration(
          border:
              Border.all(color: Pallet.inputColor.withOpacity(0.5), width: 1),
          borderRadius: radius),
    );
  }
}

class EDropDownTextField extends StatelessWidget {
  EDropDownTextField(
      {@required this.hintText,
      @required this.icon,
      this.onSaved,
      this.validator,
      this.onTap,
      this.controller});
  String hintText;
  Widget icon;
  Function(String) onSaved;
  Function(String) validator;
  Function() onTap;
  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: onTap,
        child: IgnorePointer(
          ignoring: true,
          child: Row(
            children: <Widget>[
              EmptySpace(multiple: 1.5),
              icon,
              Container(
                color: Pallet.inputColor.withOpacity(0.5),
                height: 48,
                width: 1,
                margin: EdgeInsets.symmetric(horizontal: 12),
              ),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration.collapsed(
                      hintText: hintText,
                      hintStyle: TextStyle(
                        color: Pallet.inputColor.withOpacity(0.5),
                      )),
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Pallet.inputColor.withOpacity(0.5),
              ),
              EmptySpace(multiple: 1.5),
            ],
          ),
        ),
      ),
      decoration: BoxDecoration(
          border:
              Border.all(color: Pallet.inputColor.withOpacity(0.5), width: 1),
          borderRadius: radius),
    );
  }
}
