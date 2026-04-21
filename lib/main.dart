import 'package:flutter/material.dart';

void main() => runApp(WomensSanctuaryApp());

class WomensSanctuaryApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            theme: ThemeData(
                // Using your preferred Segoe UI font style
                fontFamily: 'Segoe UI', 
                brightness: Brightness.dark,
            ),
            home: DiaryFeedScreen(),
        );
    }
}

class DiaryFeedScreen extends StatelessWidget {
    // Your branding colors
    final Color navyBlue = Color(0xFF0A192F);
    final Color limeGreen = Color(0xFF32CD32);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: navyBlue,
            appBar: AppBar(
                title: Text("Women's Diary", style: TextStyle(fontWeight: FontWeight.bold)),
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
            ),
            body: ListView.builder(
                itemCount: 5, // Just a placeholder for 5 diary entries
                itemBuilder: (context, index) {
                    return DiaryCard(navyBlue: navyBlue, limeGreen: limeGreen);
                },
            ),
            // Your Lime Green pill-shaped record button
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () { /* This would trigger audio recording */ },
                backgroundColor: limeGreen,
                icon: Icon(Icons.mic, color: Colors.black),
                label: Text("Share Your Story", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
        );
    }
}

class DiaryCard extends StatelessWidget {
    final Color navyBlue;
    final Color limeGreen;

    DiaryCard({required this.navyBlue, required this.limeGreen});

    @override
    Widget build(BuildContext context) {
        return Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Color(0xFF112240), // Slightly lighter navy for the card
                borderRadius: BorderRadius.circular(20), // Your preferred rounded corners
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text("Diary Title: Feeling overwhelmed...", 
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 10),
                    // Placeholder for the Audio Waveform
                    Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: limeGreen.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(child: Text("|||||||||||||||||| Waveform ||||||||||||||||||", 
                            style: TextStyle(color: limeGreen, fontSize: 10))),
                    ),
                    SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            Text("Anonymous Sister", style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                            TextButton(
                                onPressed: () {}, 
                                child: Text("Support", style: TextStyle(color: limeGreen))
                            ),
                        ],
                    )
                ],
            ),
        );
    }
}