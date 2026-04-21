import 'package:flutter/material.dart';

void main() => runApp(HushHushApp());

class HushHushApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Segoe UI', brightness: Brightness.light),
      home: MainSharingSpace(),
    );
  }
}

// Global Colors
const Color skyBlue = Color(0xFF87CEEB);
const Color hotPink = Color(0xFFFF69B4);
const Color softPink = Color(0xFFFFF0F5);

class MainSharingSpace extends StatelessWidget {
  final List<Map<String, String>> posts = [
    {"user": "Hidden Pearl", "tag": "#LostLove", "content": "It's been a year, and I still find myself checking his profile. Does the stinging ever stop?", "type": "text"},
    {"user": "Warrior Spirit", "tag": "#Success", "content": "Voice Diary: Finally moved into my own place. It's quiet, but it's mine.", "type": "audio"},
    {"user": "Sister #902", "tag": "#Cheating", "content": "I found the messages. I feel like the floor just disappeared from under me.", "type": "text"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("SISTERHOOD FEED", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.inbox_outlined, color: skyBlue), onPressed: () {}), // Link to the Inbox we made
        ],
      ),
      body: Column(
        children: [
          // 1. TOPIC SELECTOR
          Container(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 10),
              children: ["All", "Divorce", "Cheating", "Parenting", "Success"].map((tag) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Chip(backgroundColor: tag == "All" ? hotPink : softPink, label: Text("#$tag", style: TextStyle(color: tag == "All" ? Colors.white : Colors.black87))),
              )).toList(),
            ),
          ),

          // 2. THE MAIN FEED
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(15),
              itemCount: posts.length,
              itemBuilder: (context, index) => _buildPostCard(posts[index]),
            ),
          ),

          // 3. THE "CREATE" BAR (TEXT + AUDIO)
          _buildCreateBar(),
        ],
      ),
    );
  }

  Widget _buildPostCard(Map<String, String> post) {
    bool isAudio = post['type'] == 'audio';
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(color: softPink, borderRadius: BorderRadius.circular(25)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(post['tag']!, style: TextStyle(color: hotPink, fontWeight: FontWeight.bold, fontSize: 12)),
              Text(post['user']!, style: TextStyle(color: Colors.grey, fontSize: 11, fontStyle: FontStyle.italic)),
            ],
          ),
          SizedBox(height: 10),
          Text(post['content']!, style: TextStyle(fontSize: 16, height: 1.4, color: Colors.black87)),
          if (isAudio) ...[
            SizedBox(height: 15),
            Container(
              height: 40,
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.5), borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  IconButton(icon: Icon(Icons.play_arrow, color: hotPink), onPressed: () {}),
                  Expanded(child: Text("|||II||I|I||II||I||I|", style: TextStyle(color: hotPink, letterSpacing: 2))),
                  Padding(padding: const EdgeInsets.only(right: 15), child: Text("0:42", style: TextStyle(fontSize: 12))),
                ],
              ),
            ),
          ],
          SizedBox(height: 15),
          Row(
            children: [
              _postAction(Icons.favorite_border, "Support"),
              SizedBox(width: 20),
              _postAction(Icons.chat_bubble_outline, "Connect"),
            ],
          )
        ],
      ),
    );
  }

  Widget _postAction(IconData icon, String label) => Row(
    children: [
      Icon(icon, size: 18, color: skyBlue),
      SizedBox(width: 5),
      Text(label, style: TextStyle(color: skyBlue, fontSize: 13, fontWeight: FontWeight.w600)),
    ],
  );

  Widget _buildCreateBar() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
      child: Row(
        children: [
          // USER CIRCLE AVATAR
          CircleAvatar(backgroundColor: softPink, child: Icon(Icons.person, color: hotPink, size: 20)),
          SizedBox(width: 10),
          // TEXT INPUT
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(color: softPink, borderRadius: BorderRadius.circular(25)),
              child: TextField(
                decoration: InputDecoration(hintText: "Share your secret...", border: InputBorder.none),
              ),
            ),
          ),
          SizedBox(width: 10),
          // RECORDING MIC
          CircleAvatar(
            backgroundColor: hotPink,
            child: IconButton(icon: Icon(Icons.mic, color: Colors.white), onPressed: () {}),
          ),
        ],
      ),
    );
  }
}