import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:equilibra_mobile/ui/core/res/palet.dart';
import 'package:equilibra_mobile/ui/core/utils/svg_icon_utils.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/empty_space.dart';
import 'package:helper_widgets/loading_spinner.dart';

import 'helper.dart';

class GroupsGridItem extends StatelessWidget {
  GroupsGridItem(
      {@required this.icon,
      this.isSelected = false,
      @required this.group,
      this.loading = false});
  final String icon;
  final bool isSelected;
  final RoomGroupDTO group;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: radius,
      child: InkWell(
        onTap: () {
//          Router.gotoWidget(RoomGroupsListScreen(group), context);
        },
        child: Container(
          padding: EdgeInsets.all(24.0),
          child: loading
              ? LoadingSpinner()
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      getIcon(),
                      EmptySpace.v2(),
                      Text("${group.title}",
                          style: Theme.of(context).textTheme.title.copyWith(
                              fontSize: 16,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey[800])),
                      EmptySpace(),
                      /*Text(
                  "36 groups",
                  style:
                  TextStyle(fontSize: 14, color: isSelected ? Colors.white : Colors.grey[800]),
                ),*/
                    ],
                  ),
                ),
          decoration: BoxDecoration(
              color: isSelected ? Pallet.primaryColor : Pallet.groupBgColor,
              borderRadius: radius,
              border: Border.all(
                  color: isSelected
                      ? Pallet.primaryColor
                      : Pallet.groupLineColor)),
        ),
      ),
    );
  }

  getIcon() {
    if (group.roomType == RoomType.LGA ||
        group.roomType == RoomType.HOUSE_OF_REPRESENTATIVE) {
      return Image.asset('assets/img/lga_icon.png', width: 40, height: 40);
    } else if (group.roomType == RoomType.SENATE ||
        group.roomType == RoomType.HOUSE_OF_ASSEMBLY) {
      return Image.asset('assets/img/leg_icon.png', width: 40, height: 40);
    } else if (group.roomType == RoomType.MINISTRY) {
      return Image.asset('assets/img/exe_icon.png', width: 40, height: 40);
    }
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          color: isSelected
              ? Colors.white
              : Pallet.accentColor, //ColorUtils.groupIconColor,
          borderRadius: BorderRadius.circular(8)),
      child: SvgIconUtils.getSvgIcon(icon, color: Colors.white),
      alignment: Alignment.center,
    );
  }
}
