import 'package:equilibra_mobile/ui/core/res/palet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIconUtils {
  static const PERSON_AVATER = "assets/svg/person_avater.svg";
  static const LOCK = "assets/svg/lock.svg";
  static const ARROW_CIRCLE_RIGHT = "assets/svg/arrow_circlue_right.svg";
  static const FACEBOOK = "assets/svg/facebook.svg";
  static const GOOGLE_PLUS = "assets/svg/google_plus.svg";
  static const NAV_BAR_ICON = "assets/svg/navigation_drawer_icon.svg";
  static const JUDICIARY_GROUP_ICON = "assets/svg/judiciary_group_icon.svg";
  static const OTHER_GROUP_ICON = "assets/svg/other_groups_icon.svg";
  static const GROUP_INITIAL_BG = "assets/svg/group_list_initials_bg.svg";
  static const USER_AVATAR = "assets/svg/user_avatar.svg";
  static const REPLY = "assets/svg/reply.svg";
  static const LIKE = "assets/svg/like.svg";
  static const LIKED = "assets/svg/liked.svg";
  static const LINK = "assets/svg/link.svg";
  static const LOGOUT = "assets/svg/logout.svg";
  static const CLOCK = "assets/svg/room_clock.svg";
  static const HON = "assets/svg/room_ho.svg";
  static const HOME = "assets/svg/home.svg";
  static const NOTIFICATION = "assets/svg/notification.svg";
  static const ABOUT_US = "assets/svg/about_us.svg";
  static const CONTACT_US = "assets/svg/contact_us.svg";
  static const FEEDBACK = "assets/svg/mail.svg";
  static const SETTINGS = "assets/svg/settings.svg";
  static const NO_COMMENT = "assets/svg/no_comment_found.svg";

  static String COMMENT_ADD_IMAGE_SEND = "assets/svg/image_add.svg";
  static String COMMENT_SEND = "assets/svg/send.svg";

  static Widget getSvgIcon(String icon,
      {double width = 24, double height = 24, Color color}) {
    var iconColor = Pallet.inputColor;
    if (color != null) {
      iconColor = color;
    }
    return SvgPicture.asset(icon,
        color: iconColor, width: width, height: height);
  }

  static Widget getSvgNoColor(String icon,
      {double width = 24, double height = 24}) {
    return SvgPicture.asset(icon, width: width, height: height);
  }

  static Widget getSvgImage(String icon,
      {double width = 48, double height = 48}) {
    return SvgPicture.asset(icon, width: width, height: height);
  }
}
