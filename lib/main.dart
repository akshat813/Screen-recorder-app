import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screen_recording/flutter_screen_recording.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Screen recording '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String status="start";
  bool count=false;
  @override
  void initState() {
    super.initState();
    requestPermissions();
  }
  requestPermissions() async {
    await [
      Permission.storage,
      Permission.microphone,
      Permission.photos

    ].request();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: RaisedButton(onPressed: ()async{
                setState(() {
                  status="stop";
                });
                if (count==false)
                {
                 await FlutterScreenRecording.startRecordScreen(DateTime.now().millisecondsSinceEpoch.toString());
                  count=true;
                }
                else
                {
                 String path = await FlutterScreenRecording.stopRecordScreen;
                  setState(() {
                    status="start";
                  });
                  count=false;
                  OpenFile.open(path);
                }
              },
                child: Text(status),),
            ),
          ],
        )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}