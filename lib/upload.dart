import 'dart:io';

import 'package:apptask/notifikasi_api.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:file_picker/file_picker.dart';
import 'services.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? file;
  UploadTask? task;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() {
      file = File(path);
    });
  }

  uploadFile() async {
    if (file == null) return;
    final fileName = basename(file!.path);
    final destination = 'files/$fileName';
    task = MyFirebaseStorage.uploadFile(destination, file!);
    setState(() {});
    if (task == null) return;
    final snaptshot = await task!.whenComplete(() => {});
    final url = await snaptshot.ref.getDownloadURL();
    // ignore: avoid_print
    print(url);
  }

  // ignore: non_constant_identifier_names
  Widget UploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
      stream: task.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final snap = snapshot.data!;
          final progress = snap.bytesTransferred / snap.totalBytes;
          final uploadPersen = (progress * 100).toStringAsFixed(2);
          return Text('Selesai $uploadPersen %');
        } else {
          return Container();
        }
      });

  @override
  void initState() {
    super.initState();
    NotificationApi.init();
  }

  @override
  Widget build(BuildContext context) {
    final fileName =
        file != null ? basename(file!.path) : 'Tidak ada File yang dipilih ';
    return Scaffold(
        appBar: AppBar(title: const Text('Upload File')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    selectFile();
                  },
                  child: const Text('Pilih Files')),
              Text(fileName),
              ElevatedButton(
                  onPressed: () {
                    uploadFile();
                  },
                  child: const Text('Upload File')),
              task != null ? UploadStatus(task!) : Container(),
              ElevatedButton(
                  onPressed: () => NotificationApi.showNotification(
                        title: 'Pemberitahuan!',
                        body: 'Data Sudah Berhasil Di Upload!',
                      ),
                  child: const Text('Kirim Pemberitahuan!')),
            ],
          ),
        ));
  }
}
