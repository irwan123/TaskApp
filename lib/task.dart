import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'notifikasi_api.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  TextEditingController subjek = TextEditingController();
  TextEditingController pesan = TextEditingController();
  final firebase = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Dashboard')),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextField(
                  controller: subjek,
                  decoration: InputDecoration(
                      labelText: "Subjek",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)))),
              const SizedBox(height: 10),
              TextField(
                  controller: pesan,
                  decoration: InputDecoration(
                      labelText: "Pesan",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)))),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: TextButton.styleFrom(backgroundColor: Colors.blue),
                      onPressed: () async {
                        try {
                          await firebase
                              .collection("item")
                              .doc(subjek.text)
                              .set({
                            "subjek": subjek.text,
                            "pesan": pesan.text,
                          });
                        } catch (e) {
                          // ignore: avoid_print
                          print(e);
                        }
                        NotificationApi.showNotification(
                          title: 'Pemberitahuan!',
                          body: subjek.text,
                        );
                        subjek.clear();
                        pesan.clear();
                      },
                      child: const Text("Tambah")),
                  ElevatedButton(
                      style: TextButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () async {
                        try {
                          firebase.collection("item").doc(subjek.text).delete();
                        } catch (e) {
                          // ignore: avoid_print
                          print(e);
                        }
                        subjek.clear();
                        pesan.clear();
                      },
                      child: const Text("Hapus")),
                ],
              ),
              Expanded(
                child: SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: firebase.collection("item").snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, i) {
                                  QueryDocumentSnapshot x =
                                      snapshot.data!.docs[i];
                                  return ListTile(
                                    title: Text(x['subjek']),
                                    subtitle: Text(x['pesan']),
                                  );
                                });
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
