import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgHelper {
  static Widget getSvg(String path, {double scale = 1, Color color}) {
    return Padding(
      padding: EdgeInsets.all(8.0 * scale),
      child: SvgPicture.asset(path, color: color),
    );
  }

  static getBackButton({Null Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(11.0),
        child: SvgHelper.getSvg("assets/svg/ic_back_arrow.svg"),
      ),
    );
  }
}
