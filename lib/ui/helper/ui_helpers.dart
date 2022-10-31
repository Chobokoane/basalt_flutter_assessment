import 'package:flutter/material.dart';

/// Contains useful functions to reduce boilerplate code
class UIHelper {
  static const BorderRadius textFieldBorderRadiusAllCircular = const BorderRadius.all(Radius.circular(8));
  static const BorderRadius textFieldBorderRadiusRightSideCircular =  const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8));
  static const double _VerticalSpaceXSmall = 5.0;
  static const double _VerticalSpaceSmall = 10.0;
  static const double _VerticalSpaceMedium = 20.0;
  static const double _VerticalSpaceMediumBigger = 30.0;
  static const double _VerticalSpaceMediumLarge = 40.0;
  static const double _VerticalSpaceLarge = 60.0;
  static const double _VerticalSpaceXLarge = 120.0;

  static const double _HorizontalSpaceXSmall = 5.0;
  static const double _HorizontalSpaceSmall = 10.0;
  static const double _HorizontalSpaceMedium = 20.0;
  static const double _HorizontalSpaceMediumLarge = 20.0;
  static const double _HorizontalSpaceLarge = 60.0;
  static const double _HorizontalSpaceXLarge = 120.0;

  static void showDialogTwoActions(BuildContext context, String title, Widget content, Function onClickButtonOne, String buttonOneText, Function onClickButtonTwo, String buttonTwoText) {
    showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Container(
                decoration: const BoxDecoration(
                  color:  Color(0xFF2D365C),
                  borderRadius:  BorderRadius.only(topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0)),
                ),
                padding: const EdgeInsets.only(left: 24, top: 8, right: 8, bottom: 4),
                child: Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: const Icon(
                            Icons.close,
                            size: 30,
                            color: Colors.white,
                          ),
                          tooltip: 'Close',
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    )
                  ],
                )
            ),
            titlePadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(12)),
            content: content,
            actions: <Widget>[
              TextButton(
                child: Text(buttonTwoText),
                onPressed: () {
                  Navigator.of(context).pop();
                  onClickButtonTwo();
                },
              ),
              TextButton(
                child: Text(buttonOneText),
                onPressed: () {
                  Navigator.of(context).pop();
                  onClickButtonOne();
                },
              ),
            ],
          );
        }
    );
  }
}