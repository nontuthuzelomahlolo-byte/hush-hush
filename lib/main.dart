import 'package:flutter/material.dart';

void main() => runApp(const HushHushApp());

class HushHushApp extends StatelessWidget {
  const HushHushApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Segoe UI', brightness: Brightness.light),
      home: const MainSharingSpace(),
    );
  }
}

const Color skyBlue = Color(0xFF87CEEB);
const Color hotPink = Color(0xFFFF69B4);
const Color softPink = Color(0xFFFFF0F5);

class MainSharingSpace extends StatefulWidget {
  const MainSharingSpace({super.key});

  @override
  _MainSharingSpaceState createState() => _MainSharingSpaceState();
}

class _MainSharingSpaceState extends State<MainSharingSpace> {
  final TextEditingController _mainController = TextEditingController();

  List<Map<String, dynamic>> posts = [
    {
      "user": "Hidden Pearl",
      "tag": "#LostLove",
      "title": "Checking In",
      "content": "It's been a year... 💔",
      "type": "text",
      "isLiked": false
    },
    {
      "user": "Warrior Spirit",
      "tag": "#Success",
      "title": "New Beginnings",
      "content": "Voice Diary Shared 🎙️",
      "type": "audio",
      "isLiked": false
    },
  ];

  void _showPublishDialog({String? content, bool isAudio = false}) {
    String selectedTag = "#General"; // Initialize with a default valid value
    final TextEditingController titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Finalize Post",
            style: TextStyle(color: hotPink, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Entry Title")),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: selectedTag,
              items: <String>[
                "#General",
                "#LostLove",
                "#Success",
                "#Cheating",
                "#Parenting"
              ]
                  .map<DropdownMenuItem<String>>(
                      (String tag) => DropdownMenuItem<String>(
                            value: tag,
                            child: Text(tag),
                          ))
                  .toList(),
              onChanged: (String? val) {
                if (val != null) {
                  // This callback is within the dialog's context,
                  // so updating the state here won't rebuild the MainSharingSpace
                  // directly, but it will update the `selectedTag` local variable
                  // used when the PUBLISH button is pressed.
                  // For a DropdownButtonFormField inside a dialog,
                  // you might need a local state management within the dialog itself
                  // if you want the dropdown to visually update immediately.
                  // For this simple case, just assigning the value is sufficient
                  // as the dialog is dismissed after publish.
                  selectedTag = val;
                }
              },
              decoration: const InputDecoration(labelText: "Hashtag"),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: hotPink),
            onPressed: () {
              setState(() {
                posts.insert(0, {
                  "user": "You (Alias)",
                  "tag": selectedTag,
                  "title": titleController.text.isEmpty
                      ? "My Secret"
                      : titleController.text,
                  "content": isAudio ? "Voice Diary Shared 🎙️" : content,
                  "type": isAudio ? "audio" : "text",
                  "isLiked": false
                });
                _mainController.clear();
              });
              Navigator.pop(context);
            },
            child: const Text("PUBLISH"),
          )
        ],
      ),
    );
  }

  void _showFeatureComingSoon(BuildContext context, String featureName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$featureName feature coming soon!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("HUSH-HUSH",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) =>
                  _buildPostCard(context, index),
            ),
          ),
          _buildCustomSharingBar(),
        ],
      ),
    );
  }

  Widget _buildPostCard(BuildContext context, int index) {
    var post = posts[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: softPink, borderRadius: BorderRadius.circular(25)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(post['tag'] as String,
                  style: const TextStyle(color: hotPink, fontWeight: FontWeight.bold)),
              Text(post['user'] as String,
                  style: const TextStyle(
                      color: Colors.grey, fontSize: 11, fontStyle: FontStyle.italic)),
            ],
          ),
          const SizedBox(height: 10),
          Text(post['title'] as String,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 5),
          Text(post['content'] as String),
          if (post['type'] == 'audio') _buildAudioWaveform(),
          const SizedBox(height: 15),
          Row(
            children: [
              _ActionBtn(
                icon: (post['isLiked'] as bool) ? Icons.favorite : Icons.favorite_border,
                label: "Support",
                color: hotPink,
                onTap: () => setState(() => post['isLiked'] = !(post['isLiked'] as bool)),
              ),
              const SizedBox(width: 20),
              _ActionBtn(
                icon: Icons.chat_bubble_outline,
                label: "Connect",
                color: skyBlue,
                onTap: () => _showFeatureComingSoon(context, "Connect"),
              ),
              const SizedBox(width: 20),
              _ActionBtn(
                icon: Icons.gif_box_outlined,
                label: "GIF",
                color: skyBlue,
                onTap: () => _showFeatureComingSoon(context, "GIF"),
              ),
              const SizedBox(width: 20),
              _ActionBtn(
                icon: Icons.image_outlined,
                label: "Pic",
                color: skyBlue,
                onTap: () => _showFeatureComingSoon(context, "Picture"),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAudioWaveform() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 40,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: const Row(children: [
        Icon(Icons.play_arrow, color: hotPink),
        Expanded(
            child: Text(" |||II||I|I||II||I||I|",
                style: TextStyle(color: hotPink)))
      ]),
    );
  }

  Widget _buildCustomSharingBar() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.black12))),
      child: Row(
        children: [
          // PROFILE PIC
          const CircleAvatar(
              backgroundColor: softPink,
              radius: 18,
              child: Text("P",
                  style: TextStyle(color: hotPink, fontWeight: FontWeight.bold))),
          const SizedBox(width: 8),
          // TEXT BOX WITH EMOJI AND GIF
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: softPink, borderRadius: BorderRadius.circular(25)),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _mainController,
                      onSubmitted: (String val) => _showPublishDialog(content: val),
                      decoration: const InputDecoration(
                          hintText: "Share a secret...", border: InputBorder.none),
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.emoji_emotions_outlined,
                          color: skyBlue, size: 20),
                      onPressed: () => _showFeatureComingSoon(context, "Emoji")),
                  IconButton(
                      icon: const Icon(Icons.gif_box_outlined,
                          color: skyBlue, size: 20),
                      onPressed: () => _showFeatureComingSoon(context, "GIF (input)")),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10), // Spacing before the microphone icon
          // RECORD BUTTON ON THE FAR RIGHT
          GestureDetector(
            onTap: () => _showPublishDialog(isAudio: true),
            child: const CircleAvatar(
                backgroundColor: hotPink,
                radius: 22,
                child: Icon(Icons.mic, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  const _ActionBtn({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 5),
          Text(label,
              style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }
}