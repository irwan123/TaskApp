import 'package:apptask/download.dart';
import 'package:apptask/home.dart';
import 'package:apptask/profil.dart';
import 'package:apptask/upload.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final int _currentIndex = 0;

  final HomePage _homePage = const HomePage();
  final DownloadScreen _downloadScreen = const DownloadScreen();
  final UploadScreen _uploadScreen = const UploadScreen();
  final ProfilPage _profilPage = const ProfilPage();

  late Widget _showPage = const HomePage();

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _homePage;
      case 1:
        return _downloadScreen;
      case 2:
        return _uploadScreen;
      case 3:
        return _profilPage;
      default:
        return const Center(
            child: Text(
          "Halaman Tidak Ada",
          style: TextStyle(fontSize: 30),
        ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _showPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: ("Home"),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.download),
              label: ("Download"),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.upload),
              label: ("Upload"),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: ("Profile"),
              backgroundColor: Colors.blue),
        ],
        onTap: (int tappedIndex) {
          setState(() {
            _showPage = _pageChooser(tappedIndex);
          });
        },
      ),
    );
  }
}
