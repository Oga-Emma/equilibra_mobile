import 'package:equilibra_mobile/ui/core/res/palet.dart';
import 'package:equilibra_mobile/ui/core/utils/svg_icon_utils.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/empty_space.dart';

class AboutContact extends StatelessWidget {
  AboutContact(this.scaffoldKey, {this.isAbout = false});
  bool isAbout;
  GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                centerTitle: false,
                leading: InkWell(
                  onTap: () {
                    scaffoldKey.currentState.openDrawer();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 16.0, bottom: 16.0),
                    child: Center(
                      child: SvgIconUtils.getSvgIcon(SvgIconUtils.NAV_BAR_ICON,
                          color: Colors.white, height: 16, width: 16),
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16.0),
                        bottomRight: Radius.circular(16.0))),
                pinned: true,
                title: Text(isAbout ? "About us" : "Contact us"),
                expandedHeight: 170,
                flexibleSpace: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24.0),
                      bottomRight: Radius.circular(24.0)),
                  child: Container(
                    child: SafeArea(
                      left: false,
                      right: false,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 56),
                            title(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverFillRemaining(
                  child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: isAbout ? aboutUs(context) : contactUs(context)),
              ))
            ],
          ),
        ),
      ],
    );
  }

  String website = "www.theequilibra.com";
  String email = "info@theequilibra.com";
  String phone1 = "+234-803-444-5555";
  String phone2 = "+234-802-333-4444";

  Widget contactUs(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        EmptySpace(),
        Text("Contact Us",
            style: Theme.of(context).textTheme.title.copyWith(fontSize: 18.0)),
        EmptySpace(),
        Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Website"),
              EmptySpace(),
              Text(website, style: TextStyle(color: Pallet.primaryColor)),
              EmptySpace(multiple: 3),
              Text("Email"),
              EmptySpace(),
              Text(email, style: TextStyle(color: Pallet.primaryColor)),
              EmptySpace(multiple: 3),
              Text("Telephone"),
              EmptySpace(),
              Row(
                children: <Widget>[
                  Text(phone1, style: TextStyle(color: Pallet.primaryColor)),
                  Text("; ", style: TextStyle(color: Pallet.primaryColor)),
                  Text(phone2, style: TextStyle(color: Pallet.primaryColor)),
                ],
              )
            ],
          ),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(4.0)),
        ),
        EmptySpace(multiple: 3),
        Text("Address",
            style: Theme.of(context).textTheme.title.copyWith(fontSize: 18.0)),
        EmptySpace(),
        Container(
          padding: EdgeInsets.all(16.0),
          child: Text(
              "23., abore nostrud nulla sunt est dolore sunt nisi est labore esse exercitation anim ex sit. Lagos"),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(4.0)),
        ),
      ],
    );
  }

  Widget aboutUs(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        EmptySpace(),
        Text("Our Vision",
            style: Theme.of(context).textTheme.title.copyWith(fontSize: 18.0)),
        EmptySpace(),
        Text(
            '''To achieve, sustain unity and continuously engage positively to harness the synergies from contributions of our diverse and rich heritage in a free, fair and just society.''',
            style: TextStyle(height: 1.3)),
        EmptySpace(multiple: 2),
        Container(
          height: 200,
          width: double.maxFinite,
          child: Image(
            image: AssetImage("assets/img/feedback_img.png"),
            fit: BoxFit.cover,
          ),
        ),
        EmptySpace(multiple: 3),
        Text("Our Core Values",
            style: Theme.of(context).textTheme.title.copyWith(fontSize: 18.0)),
        EmptySpace(),
        Text(
          '''To achieve, sustain unity and continuously engage positively to harness the synergies from contributions of our diverse and rich heritage in a free, fair and just society.''',
          style: TextStyle(height: 1.3),
        ),
        EmptySpace(multiple: 3),
        Text("Our Mission",
            style: Theme.of(context).textTheme.title.copyWith(fontSize: 18.0)),
        EmptySpace(),
        Text(
            '''To create and nurture platforms and such other programs for positive engagement between the people, social partners and our country’s institutions, including those elected or appointed to serve within them, towards achieving greater common good.''',
            style: TextStyle(height: 1.3)),
      ],
    );
  }

  Widget title() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Stack(
        children: <Widget>[
          Container(
            margin:
                EdgeInsets.only(left: 32.0, right: 4.0, top: 8.0, bottom: 8.0),
            child: Container(
              width: double.maxFinite,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 48.0, right: 16.0, top: 16.0, bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("theEquilibra",
                        style: TextStyle(
                            fontSize: 18, color: Pallet.primaryColor)),
                    EmptySpace(),
                    Text(
                      "People’s Parliament",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
//                                border: Border.all(color: Colors.white)
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.0)),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            child: SizedBox(
              child: Center(
                child: Card(
                  elevation: 8.0,
                  child: Container(
                    height: 60,
                    width: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image(
                          image: AssetImage(
                              "assets/img/room_topic_side_image.png")),
                    ),
                    decoration: BoxDecoration(
//                                border: Border.all(color: Colors.white)
//                                          color: Colors.yellow,
                        borderRadius: BorderRadius.circular(4.0)),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
