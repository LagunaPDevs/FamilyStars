import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Animated Dialog that shows information to users

class CustomAnimatedAlertDialog {
  final String? title;
  final String? content;
  final List<Widget>? actions;
  final BuildContext context;

  CustomAnimatedAlertDialog(
      {required this.context, this.title, this.content, this.actions});

  void show() {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.7),
        //SHADOW EFFECT
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: AnimatedOpacity(
              opacity: a1.value,
              curve: Curves.easeIn,
              duration: Duration(milliseconds: 400),
              child: _CustomDialog(
                title: title,
                description: content,
                okButtonText: "Ok",
                onOkPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 400),
        // DURATION FOR ANIMATION
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  }
}

class _CustomDialog extends StatelessWidget {
  final String? title, description, okButtonText, cancelButtonText;
  final VoidCallback? onCancelPressed;
  final VoidCallback? onOkPressed;
  final Image? image;
  final bool? isCloseIconShow;
  final MainAxisAlignment? mainAxisAlignmentForButton;

  _CustomDialog(
      {this.title,
      this.description,
      this.okButtonText,
      this.cancelButtonText,
      this.image,
      this.onCancelPressed,
      this.onOkPressed,
      this.mainAxisAlignmentForButton,
      this.isCloseIconShow = false});

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      elevation: 0.0,
      color: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Theme.of(context).backgroundColor),
            margin: EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: ListView(
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              children: <Widget>[
                title != null
                    ? Container(
                        alignment: Alignment.centerLeft,
                        child: Text(title ?? "",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor,
                            )),
                      )
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: mainAxisAlignmentForButton != null
                      ? Text(description ?? "", style: TextStyle(fontSize: 13))
                      : Text(description ?? "",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 13,
                          )),
                ),
                SizedBox(
                  height: mainAxisAlignmentForButton != null ? 20 : 10,
                ),
                Row(
                  mainAxisAlignment:
                      mainAxisAlignmentForButton ?? MainAxisAlignment.end,
                  children: <Widget>[
                    Visibility(
                      child: InkWell(
                        onTap: onOkPressed,
                        child: Container(
                          child: Text(okButtonText ?? "",
                              style: TextStyle(
                                color: ColorConstants.whiteColor,
                              )
                              // fontSize: mainAxisAlignmentForButton != null ? 12 : null,
                              ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                      ),
                      visible: okButtonText != null && onOkPressed != null,
                    ),
                    Visibility(
                      child: SizedBox(
                        width: 20,
                      ),
                      visible:
                          cancelButtonText != null && onCancelPressed != null,
                    ),
                    Visibility(
                      visible:
                          cancelButtonText != null && onCancelPressed != null,
                      child: InkWell(
                        onTap: onCancelPressed,
                        child: Container(
                          child: Text(cancelButtonText ?? "",
                              style: TextStyle(
                                fontSize: 12,
                              )),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Visibility(
            visible: isCloseIconShow ?? true,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        size: 16,
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
