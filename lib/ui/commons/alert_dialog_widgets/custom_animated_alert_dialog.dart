import 'package:familystars_2/infrastructure/constants/color_constants.dart';
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
              duration: const Duration(milliseconds: 400),
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
        transitionDuration: const Duration(milliseconds: 400),
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

  const _CustomDialog(
      {required this.title,
      required this.description,
      required this.okButtonText,
      required this.onOkPressed,
      this.cancelButtonText,
      this.onCancelPressed,
      this.image,
      this.isCloseIconShow,
      this.mainAxisAlignmentForButton});

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const RoundedRectangleBorder(
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
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                color: Theme.of(context).colorScheme.surface),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: ListView(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              children: <Widget>[
                title != null
                    ? Container(
                        alignment: Alignment.centerLeft,
                        child: Text(title ?? "",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                            )),
                      )
                    : Container(),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: mainAxisAlignmentForButton != null
                      ? Text(description ?? "",
                          style: const TextStyle(fontSize: 13))
                      : Text(description ?? "",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
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
                      visible: okButtonText != null && onOkPressed != null,
                      child: InkWell(
                        onTap: onOkPressed,
                        child: Container(
                          child: Text(okButtonText ?? "",
                              style: const TextStyle(
                                color: ColorConstants.whiteColor,
                              )
                              // fontSize: mainAxisAlignmentForButton != null ? 12 : null,
                              ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                        ),
                      ),
                    ),
                    Visibility(
                      visible:
                          cancelButtonText != null && onCancelPressed != null,
                      child: const SizedBox(
                        width: 20,
                      ),
                    ),
                    Visibility(
                      visible:
                          cancelButtonText != null && onCancelPressed != null,
                      child: InkWell(
                        onTap: onCancelPressed,
                        child: Container(
                          child: Text(cancelButtonText ?? "",
                              style: const TextStyle(
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
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
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
