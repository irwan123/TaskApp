import 'package:flutter/material.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({Key? key}) : super(key: key);

  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  late String payload;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Download File')),
        body: const Center(
            child: Text(
          "Download",
          style: TextStyle(fontSize: 30),
        )));
  }
}
