import 'package:cached_network_image/cached_network_image.dart';
import 'package:equilibra_mobile/ui/core/utils/svg_icon_utils.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  ProfileImage({this.imageUrl = "", this.radius = 50});
  String imageUrl;
  double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        child: imageUrl.isEmpty
            ? SvgIconUtils.getSvgImage(SvgIconUtils.USER_AVATAR,
                height: radius / 2, width: radius / 2)
            : Image(
                image: CachedNetworkImageProvider(imageUrl), fit: BoxFit.cover),
        height: radius,
        width: radius,
        decoration: BoxDecoration(shape: BoxShape.circle),
      ),
    );
  }
}
