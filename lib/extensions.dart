import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogTrigger{
  DialogTrigger({this.controlData=null});
  final dynamic controlData;
  void Function(dynamic) callback = (_){};
}
Future triggerDialog(Function(DialogTrigger) builder, {dynamic value}){
  Completer completer = Completer();
  var d = DialogTrigger(controlData: value)..callback=(result){
    completer.complete(result);
  };
  builder(d);
  return completer.future;
}

showMyDialog(
    DialogTrigger dialogTrigger,
    BuildContext context,
    WidgetBuilder builder,
    {bool barrierDismissible = false}
    ){
  /*showDialog(
    context: context,
    builder: (BuildContext context) {
      return builder(context);
    },
  ).then((result){
    dialogTrigger.callback(result);
  });*/

  showGeneralDialog(
    barrierLabel: "Dialog",
    barrierDismissible: barrierDismissible,
    context: context,
    pageBuilder: (ctx, a1, a2) {
      return builder(ctx);
    },
    transitionBuilder: (ctx, a1, a2, child) {
      var curve = Curves.easeInOut.transform(a1.value);
      return Transform.scale(
        scale: curve,
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 400),
  ).then((result){
    dialogTrigger.callback(result);
  });
}