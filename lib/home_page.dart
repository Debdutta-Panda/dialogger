import 'package:dialogger/home_page_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'extensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final vm = HomePageViewModel();
  List<ReactionDisposer> _disposers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            vm.onClick();
          },
          child: Text("Open Dialog"),
        )
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _disposers = [
      reaction(
              (_) => vm.showDialog,//to observe
              (value) {
            var d = value as DialogTrigger;
            showMyDialog(d,context,(BuildContext context) {return VersionUpdateDialog(context,d.controlData);});
          }
      ),
    ];
  }

  VersionUpdateDialog(BuildContext context,String message) {
    return AlertDialog(
      title: const Text("Title"),
      content: Text(
          "Message"
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text("Ok"),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        ElevatedButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.pop(context, false);
          },
        )
      ],
    );
  }

  @override
  void dispose() {
    for (var d in _disposers) {
      d();
    }
    super.dispose();
  }
}