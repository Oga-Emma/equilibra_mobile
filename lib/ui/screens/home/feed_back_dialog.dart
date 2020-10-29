import 'package:equilibra_mobile/di/controllers/user_controller.dart';
import 'package:equilibra_mobile/ui/core/res/palet.dart';
import 'package:equilibra_mobile/ui/core/widgets/e_button.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/empty_space.dart';
import 'package:helper_widgets/string_utils/string_utils.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class FeedBackDialog extends StatefulWidget {
  FeedBackDialog(this.email);
  String email;

  @override
  _FeedBackDialogState createState() => _FeedBackDialogState();
}

class _FeedBackDialogState extends State<FeedBackDialog> {
  UserController userController;
  var _feedbackTextController = TextEditingController();
  double rating = 3.0;
  bool _sending = false;

  @override
  void dispose() {
    _feedbackTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userController = Provider.of<UserController>(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      content: SingleChildScrollView(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(8.0),
                color: Pallet.groupBgColor,
                child: Center(child: Text("Leave your feedbacks")),
              ),
              EmptySpace(multiple: 2),
              // Text(
              //   "Rate this app",
              //   style: TextStyle(color: Pallet.primaryColor),
              // ),
              // EmptySpace(),
              // SmoothStarRating(
              //     allowHalfRating: false,
              //     onRated: (v) {
              //       rating = v;
              //       setState(() {});
              //     },
              //     starCount: 5,
              //     rating: rating,
              //     size: 36.0,
              //     color: Colors.orangeAccent,
              //     borderColor: Colors.orangeAccent,
              //     spacing: 0.0),
              // EmptySpace(multiple: 3),
              Text(
                "Enter feedback bellow",
                style: TextStyle(color: Pallet.primaryColor),
              ),
              EmptySpace(),
              TextField(
                controller: _feedbackTextController,
                minLines: 6,
                maxLines: 7,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Pallet.primaryColor))),
              ),
              EmptySpace(multiple: 2),
              EButton(loading: _sending, label: "Submit", onTap: sendFeedback),
            ],
          ),
        ),
      ),
    );
  }

  sendFeedback() async {
    if (StringUtils.isNotEmpty(_feedbackTextController.text))
      userController.sendFeedback(_feedbackTextController.text);
    Navigator.pop(context);
  }
}
