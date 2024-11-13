import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Dialog that shows a loading icon during an async process
class CustomLoading {
  static progressDialog(bool isLoading, BuildContext context) {
    if (!isLoading) {
      Navigator.of(context, rootNavigator: true).pop();
    } else {
      showDialog(
        barrierDismissible: false,
        context: context,
        barrierColor: Colors.transparent,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false, child: CustomLoadingLayout());
        },
        useRootNavigator: true,
      );
    }
  }
}

class CustomLoadingLayout extends StatefulWidget {
  const CustomLoadingLayout({Key? key}) : super(key: key);

  @override
  _CustomLoadingLayoutState createState() => _CustomLoadingLayoutState();
}

class _CustomLoadingLayoutState extends State<CustomLoadingLayout>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return const CupertinoActivityIndicator(
      radius: 15,
    );
  }
}
