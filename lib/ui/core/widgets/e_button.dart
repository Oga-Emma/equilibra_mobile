import 'package:equilibra_mobile/ui/core/res/palet.dart';
import 'package:equilibra_mobile/ui/core/utils/svg_icon_utils.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/loading_spinner.dart';

import 'helper.dart';

class EButton extends StatelessWidget {
  EButton({@required this.label, @required this.onTap, this.loading = false});

  final String label;
  final bool loading;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: radius),
      color: Pallet.primaryColor,
      onPressed: loading ? () {} : onTap,
      child: Container(
        height: 52,
        padding: EdgeInsets.all(4.0),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Text(
              "$label",
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            )),
            loading
                ? LoadingSpinner(color: Colors.white)
                : SvgIconUtils.getSvgIcon(SvgIconUtils.ARROW_CIRCLE_RIGHT,
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
