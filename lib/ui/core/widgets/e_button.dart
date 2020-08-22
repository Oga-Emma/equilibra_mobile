import 'package:equilibra_mobile/ui/core/res/palet.dart';
import 'package:equilibra_mobile/ui/core/utils/svg_icon_utils.dart';
import 'package:flutter/material.dart';

import 'helper.dart';

class EButton extends StatelessWidget {
  EButton({@required this.label, @required this.onTap});

  final String label;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: radius),
      color: Pallet.primaryColor,
      onPressed: onTap,
      child: Container(
        height: 52,
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Text(
              "$label",
              style: TextStyle(fontSize: 14.0, color: Colors.white),
            )),
            SvgIconUtils.getSvgIcon(SvgIconUtils.ARROW_CIRCLE_RIGHT,
                color: Colors.white, width: 24, height: 24)
          ],
        ),
      ),
    );

    return Material(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 52,
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Text(
                "$label",
                style: TextStyle(fontSize: 14.0, color: Colors.white),
              )),
              SvgIconUtils.getSvgIcon(SvgIconUtils.ARROW_CIRCLE_RIGHT,
                  color: Colors.white, width: 24, height: 24)
            ],
          ),
          decoration:
              BoxDecoration(color: Pallet.primaryColor, borderRadius: radius),
        ),
      ),
    );
  }
}
