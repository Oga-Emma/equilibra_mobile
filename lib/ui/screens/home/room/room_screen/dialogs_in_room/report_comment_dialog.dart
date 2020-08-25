import 'package:equilibra_mobile/ui/core/res/palet.dart';
import 'package:equilibra_mobile/ui/core/widgets/e_button.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/empty_space.dart';

class ReportCommentDialog extends StatefulWidget {
  ReportCommentDialog({this.onSubmit});
  Function(String) onSubmit;
  @override
  _ReportCommentDialogState createState() => _ReportCommentDialogState();
}

class _ReportCommentDialogState extends State<ReportCommentDialog> {
  var options = ["Its Spam", "It's inappropriate", "It's abusive or harmfuul"];
  var type = ["SPAM", "INAPPROPRIATE", "ABUSIVE"];
  var selected = 1;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      content: Container(
        width: double.maxFinite,
        height: 300,
        child: Column(
          children: <Widget>[
            Text("CHOOSE A REASON FOR REPORTING THIS POST",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption.copyWith(
                    color: Pallet.accentColor, fontWeight: FontWeight.bold)),
            EmptySpace(),
            Expanded(
              child: ListView.builder(
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            side: BorderSide(
                                color: selected == index
                                    ? Pallet.primaryColor
                                    : Colors.transparent)),
                        color: Colors.white,
                        elevation: 4.0,
                        child: InkWell(
                          onTap: () {
                            selected = index;
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                    selected == index
                                        ? EvaIcons.checkmarkCircle2
                                        : Icons.blur_circular,
                                    color: selected == index
                                        ? Pallet.primaryColor
                                        : Colors.grey[300]),
                                EmptySpace(),
                                Expanded(child: Text(options[index]))
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            EButton(
                onTap: () {
                  widget.onSubmit(type[selected]);
                },
                label: "Submit")
          ],
        ),
      ),
    );
  }
}
