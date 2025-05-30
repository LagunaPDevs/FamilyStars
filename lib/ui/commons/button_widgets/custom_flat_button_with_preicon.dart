// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

/// A material design "flat button_widgets".
///
/// ### This class is obsolete, please use [TextButton] instead.
///
/// FlatButton, RaisedButton, and OutlineButton have been replaced by
/// TextButton, ElevatedButton, and OutlinedButton respectively.
/// ButtonTheme has been replaced by TextButtonTheme,
/// ElevatedButtonTheme, and OutlinedButtonTheme. The original classes
/// will be deprecated soon, please migrate code that uses them.
/// There's a detailed migration guide for the new button_widgets and button_widgets
/// theme classes in
/// [flutter.dev/go/material-button_widgets-migration-guide](https://flutter.dev/go/material-button-migration-guide).
///
/// A flat button_widgets is a text_widgets label displayed on a (zero elevation) [Material]
/// widget that reacts to touches by filling with color.
///
/// Use flat buttons on toolbars, in dialogs, or inline with other content but
/// offset from that content with padding so that the button_widgets's presence is
/// obvious. Flat buttons intentionally do not have visible borders and must
/// therefore rely on their position relative to other content for context. In
/// dialogs and cards, they should be grouped together in one of the bottom
/// corners. Avoid using flat buttons where they would blend in with other
/// content, for example in the middle of lists.
///
/// Material design flat buttons have an all-caps label, some internal padding,
/// and some defined dimensions. To have a part of your application be
/// interactive, with ink splashes, without also committing to these stylistic
/// choices, consider using [InkWell] instead.
///
/// If the [onPressed] and [onLongPress] callbacks are null, then this button_widgets will be disabled,
/// will not react to touch, and will be colored as specified by
/// the [disabledColor] property instead of the [color] property. If you are
/// trying to change the button_widgets's [color] and it is not having any effect, check
/// that you are passing a non-null [onPressed] handler.
///
/// Flat buttons have a minimum size of 88.0 by 36.0 which can be overridden
/// with [ButtonTheme].
///
/// The [clipBehavior] argument must not be null.
///
/// {@tool snippet}
///
/// This example shows a simple [FlatButton].
///
/// ![A simple FlatButton](https://flutter.github.io/assets-for-api-docs/assets/material/flat_button.png)
///
/// ```dart
/// FlatButton(
///   onPressed: () {
///     /*...*/
///   },
///   child: Text(
///     "Flat Button",
///   ),
/// )
/// ```
/// {@end-tool}
///
/// {@tool snippet}
///
/// This example shows a [FlatButton] that is normally white-on-blue,
/// with splashes rendered in a different shade of blue.
/// It turns black-on-grey when disabled.
/// The button_widgets has 8px of padding on each side, and the text_widgets is 20px high.
///
/// ![A FlatButton with white text_widgets on a blue background](https://flutter.github.io/assets-for-api-docs/assets/material/flat_button_properties.png)
///
/// ```dart
/// FlatButton(
///   color: Colors.blue,
///   textColor: Colors.white,
///   disabledColor: Colors.grey,
///   disabledTextColor: Colors.black,
///   padding: EdgeInsets.all(8.0),
///   splashColor: Colors.blueAccent,
///   onPressed: () {
///     /*...*/
///   },
///   child: Text(
///     "Flat Button",
///     style: TextStyle(fontSize: 20.0),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [RaisedButton], a filled button_widgets whose material elevates when pressed.
///  * [DropdownButton], which offers the user a choice of a number of options.
///  * [SimpleDialogOption], which is used in [SimpleDialog]s.
///  * [IconButton], to create buttons that just contain icons.
///  * [InkWell], which implements the ink splash part of a flat button_widgets.
///  * [RawMaterialButton], the widget this widget is based on.
///  * <https://material.io/design/components/buttons.html>
///  * Cookbook: [Build a form with validation](https://flutter.dev/docs/cookbook/forms/validation)
class CustomFlatButtonWithPreIcon extends MaterialButton {
  /// Create a simple text_widgets button_widgets.
  ///
  /// The [autofocus] and [clipBehavior] arguments must not be null.
  const CustomFlatButtonWithPreIcon({
    super.key,
    required VoidCallback super.onPressed,
    super.onLongPress,
    super.onHighlightChanged,
    super.mouseCursor,
    super.textTheme,
    super.textColor,
    super.disabledTextColor,
    super.color,
    super.disabledColor,
    super.focusColor,
    super.hoverColor,
    super.highlightColor,
    super.splashColor,
    super.colorBrightness,
    super.padding,
    super.visualDensity,
    super.shape,
    super.clipBehavior,
    super.focusNode,
    super.autofocus,
    super.materialTapTargetSize,
    required Widget super.child,
    super.height,
    super.minWidth,
  });

  /// Create a text_widgets button_widgets from a pair of widgets that serve as the button_widgets's
  /// [icon] and [label].
  ///
  /// The icon and label are arranged in a row and padded by 12 logical pixels
  /// at the start, and 16 at the end, with an 8 pixel gap in between.
  ///
  /// The [icon], [label], and [clipBehavior] arguments must not be null.
  factory CustomFlatButtonWithPreIcon.icon({
    Key? key,
    required VoidCallback onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHighlightChanged,
    MouseCursor? mouseCursor,
    ButtonTextTheme? textTheme,
    Color? textColor,
    Color? disabledTextColor,
    Color? color,
    Color? disabledColor,
    Color? focusColor,
    Color? hoverColor,
    Color? highlightColor,
    Color? splashColor,
    Brightness? colorBrightness,
    EdgeInsetsGeometry? padding,
    ShapeBorder? shape,
    Clip clipBehavior,
    FocusNode? focusNode,
    bool autofocus,
    MaterialTapTargetSize? materialTapTargetSize,
    required Widget icon,
    required Widget label,
    double? minWidth,
    double? height,
  }) = _CustomFlatButtonWithPreIcon;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ButtonThemeData buttonTheme = ButtonTheme.of(context);
    return RawMaterialButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHighlightChanged: onHighlightChanged,
      mouseCursor: mouseCursor,
      fillColor: buttonTheme.getFillColor(this),
      textStyle: theme.textTheme.bodyMedium!
          .copyWith(color: buttonTheme.getTextColor(this)),
      focusColor: buttonTheme.getFocusColor(this),
      hoverColor: buttonTheme.getHoverColor(this),
      highlightColor: buttonTheme.getHighlightColor(this),
      splashColor: buttonTheme.getSplashColor(this),
      elevation: buttonTheme.getElevation(this),
      focusElevation: buttonTheme.getFocusElevation(this),
      hoverElevation: buttonTheme.getHoverElevation(this),
      highlightElevation: buttonTheme.getHighlightElevation(this),
      disabledElevation: buttonTheme.getDisabledElevation(this),
      padding: buttonTheme.getPadding(this),
      visualDensity: visualDensity ?? theme.visualDensity,
      constraints: buttonTheme.getConstraints(this).copyWith(
            minWidth: minWidth,
            minHeight: height,
          ),
      shape: buttonTheme.getShape(this),
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      autofocus: autofocus,
      materialTapTargetSize: buttonTheme.getMaterialTapTargetSize(this),
      animationDuration: buttonTheme.getAnimationDuration(this),
      child: child,
    );
  }
}

/// The type of FlatButtons created with [FlatButton.icon].
///
/// This class only exists to give FlatButtons created with [FlatButton.icon]
/// a distinct class for the sake of [ButtonTheme]. It can not be instantiated.
class _CustomFlatButtonWithPreIcon extends CustomFlatButtonWithPreIcon {
  _CustomFlatButtonWithPreIcon({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.onHighlightChanged,
    super.mouseCursor,
    super.textTheme,
    super.textColor,
    super.disabledTextColor,
    super.color,
    super.disabledColor,
    super.focusColor,
    super.hoverColor,
    super.highlightColor,
    super.splashColor,
    super.colorBrightness,
    super.padding,
    super.shape,
    super.clipBehavior,
    super.focusNode,
    super.autofocus,
    super.materialTapTargetSize,
    required Widget icon,
    required Widget label,
    super.minWidth,
    super.height,
  }) : super(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              icon,
              const SizedBox(width: 8.0),
              label,
            ],
          ),
        );
}
