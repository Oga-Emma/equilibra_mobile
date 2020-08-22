import 'package:equilibra_mobile/ui/core/res/palet.dart';
import 'package:equilibra_mobile/ui/core/utils/svg_icon_utils.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/empty_space.dart';

class EAppBar extends StatelessWidget with PreferredSizeWidget {
  EAppBar({this.onLeadingPressed});
  Function() onLeadingPressed;
//  AppStateProvider appState;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      child: Stack(
        children: <Widget>[
          Container(
            color: Pallet.accentColor,
          ),
          Container(
            decoration: BoxDecoration(
              color: Pallet.primaryColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24.0),
                  bottomRight: Radius.circular(16.0)),
            ),
            child: SafeArea(
              bottom: false,
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 8.0, top: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        onTap: onLeadingPressed,
                        child: Container(
                          margin: EdgeInsets.only(right: 24.0),
                          padding: const EdgeInsets.only(top: 8.0),
                          child: SvgIconUtils.getSvgIcon(
                              SvgIconUtils.NAV_BAR_ICON,
                              color: Colors.white,
                              width: 16,
                              height: 16),
                        ),
                      ),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Home",
                            style: Theme.of(context)
                                .textTheme
                                .title
                                .copyWith(color: Colors.white),
                          ),
                          EmptySpace(multiple: 0.5),
                          RichText(
                            text: TextSpan(text: 'Welcome, ', children: [
                              TextSpan(
                                text: "Ani Emmanuel",
                                style: TextStyle(
//                                      fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ]),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, 90);
}
