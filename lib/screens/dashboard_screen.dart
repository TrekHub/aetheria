import 'package:aetheria/screens/sermon_form_screen.dart';
import 'package:aetheria/utils/app_theme.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  final String bibleVerse =
      "But those who hope in the Lord will renew their strength. "
      "They will soar on wings like eagles; "
      "they will run and not grow weary, "
      "they will walk and not be faint. (Isaiah 40:31 NIV)";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.skyBlue,
        title: Text("Aetheria"),
        centerTitle: false,
        actions: [
          IconButton(onPressed: null, icon: Icon(Icons.logout_outlined)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => SermonFormScreen()),
          );
        },
        backgroundColor: AppTheme.skyBlue,
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),

      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(color: AppTheme.skyBlue),
            child: Center(child: Text(bibleVerse)),
          ),
        ],
      ),
    );
  }
}
