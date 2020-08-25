import 'package:equilibra_mobile/di/di.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:equilibra_mobile/ui/core/res/palet.dart';
import 'package:equilibra_mobile/ui/core/utils/svg_icon_utils.dart';
import 'package:equilibra_mobile/ui/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/empty_space.dart';
import 'package:helper_widgets/loading_spinner.dart';
import 'package:stacked_services/stacked_services.dart';

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

  var _navigationService = getIt<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: radius,
      child: Container(
        padding: EdgeInsets.only(top: 16.0, left: 16, right: 16, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getIcon(),
            EmptySpace.v2(),
            Text("${group.title}",
                style: Theme.of(context).textTheme.title.copyWith(
                    fontSize: 18,
                    color: isSelected ? Colors.white : Colors.grey[800])),
            EmptySpace(),
            Text(
              "${group.description1}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 12, color: isSelected ? Colors.white : Colors.grey),
            ),
            EmptySpace(multiple: 0.5),
            Text(
              "${group.description2}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 12, color: isSelected ? Colors.white : Colors.grey),
            ),
            EmptySpace(),
            MaterialButton(
              minWidth: double.maxFinite,
              shape: RoundedRectangleBorder(borderRadius: radius),
              elevation: 0.0,
              color: Pallet.primaryColor,
              onPressed: () {
                _navigationService.navigateTo(Routes.roomGroupsListScreen,
                    arguments: RoomGroupsListScreenArguments(group: group));
              },
              child: Text(
                "Join ${group.title}",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: isSelected ? Pallet.primaryColor : Pallet.groupBgColor,
            borderRadius: radius,
            border: Border.all(width: 0.2, color: Pallet.primaryColor)),
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
