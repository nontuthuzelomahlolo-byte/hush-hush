import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Existing colors
const Color skyBlue = Color(0xFF87CEEB);
const Color hotPink = Color(0xFFFF69B4);
const Color softPink = Color(0xFFFFF0F5);

// DATA_MODEL for app navigation state
class AppNavigationModel extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners();
    }
  }
}

void main() => runApp(const HushHushApp());

class HushHushApp extends StatelessWidget {
  const HushHushApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppNavigationModel>(
      create: (BuildContext context) => AppNavigationModel(),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme:
              ThemeData(fontFamily: 'Segoe UI', brightness: Brightness.light),
          home: const MainScreenWrapper(),
        );
      },
    );
  }
}

// New Screens (placeholders for other navigation sections)
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NOTIFICATIONS",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: const Center(
        child: Text("No new notifications.",
            style: TextStyle(color: Colors.grey)),
      ),
    );
  }
}

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("INBOX",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: const Center(
        child: Text("Your inbox is empty.",
            style: TextStyle(color: Colors.grey)),
      ),
    );
  }
}

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BOOKMARKS",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: const Center(
        child: Text("No bookmarks yet.", style: TextStyle(color: Colors.grey)),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MY PROFILE",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              radius: 50,
              backgroundColor: softPink,
              child: Text("P",
                  style: TextStyle(
                      fontSize: 40,
                      color: hotPink,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
            const Text("You (Alias)",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("Joined: Today", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: hotPink),
              onPressed: () {
                Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const SettingsScreen()));
              },
              child:
                  const Text("Account Settings", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SETTINGS",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        children: const <Widget>[
          ListTile(
            leading: Icon(Icons.privacy_tip_outlined, color: hotPink),
            title: Text("Privacy Policy"),
          ),
          ListTile(
            leading: Icon(Icons.help_outline, color: hotPink),
            title: Text("Help & Support"),
          ),
          ListTile(
            leading: Icon(Icons.logout, color: hotPink),
            title: Text("Logout"),
          ),
        ],
      ),
    );
  }
}

// MainScreenWrapper handles the BottomNavigationBar and displays the selected content
class MainScreenWrapper extends StatelessWidget {
  const MainScreenWrapper({super.key});

  static final List<Widget> _widgetOptions = <Widget>[
    const MainSharingSpace(), // Home
    const NotificationsScreen(),
    const InboxScreen(),
    const BookmarkScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNavigationModel>(
      builder: (BuildContext context, AppNavigationModel model, Widget? child) {
        return Scaffold(
          body: _widgetOptions.elementAt(model.selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_outlined),
                activeIcon: Icon(Icons.notifications),
                label: 'Notifications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.inbox_outlined),
                activeIcon: Icon(Icons.inbox),
                label: 'Inbox',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_border),
                activeIcon: Icon(Icons.bookmark),
                label: 'Bookmarks',
              ),
            ],
            currentIndex: model.selectedIndex,
            selectedItemColor: hotPink,
            unselectedItemColor: Colors.grey,
            onTap: (int index) {
              model.setSelectedIndex(index);
            },
            type: BottomNavigationBarType.fixed, // To show all labels
            backgroundColor: Colors.white,
            elevation: 0, // Remove shadow
          ),
        );
      },
    );
  }
}

// Original MainSharingSpace (now serving as the "Home" tab content)
class MainSharingSpace extends StatefulWidget {
  const MainSharingSpace({super.key});

  @override
  _MainSharingSpaceState createState() => _MainSharingSpaceState();
}

class _MainSharingSpaceState extends State<MainSharingSpace> {
  final TextEditingController _mainController = TextEditingController();

  List<Map<String, dynamic>> posts = <Map<String, dynamic>>[
    <String, dynamic>{
      "user": "Hidden Pearl",
      "tag": "#LostLove",
      "title": "Checking In",
      "content": "It's been a year... 💔",
      "type": "text",
      "isLiked": false
    },
    <String, dynamic>{
      "user": "Warrior Spirit",
      "tag": "#Success",
      "title": "New Beginnings",
      "content": "Voice Diary Shared 🎙️",
      "type": "audio",
      "isLiked": false
    },
  ];

  void _showPublishDialog({String? content, bool isAudio = false}) {
    String? selectedTag = "#General"; // Initialize with a default valid value
    final TextEditingController titleController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Text("Finalize Post",
                style: TextStyle(color: hotPink, fontWeight: FontWeight.bold)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                    controller: titleController,
                    decoration:
                        const InputDecoration(labelText: "Entry Title")),
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
                    setState(() {
                      selectedTag = val;
                    });
                  },
                  decoration: const InputDecoration(labelText: "Hashtag"),
                ),
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: hotPink),
                onPressed: () {
                  this.setState(() {
                    posts.insert(0, <String, dynamic>{
                      "user": "You (Alias)",
                      "tag": selectedTag ?? "#General",
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
          );
        },
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
        children: <Widget>[
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
      decoration: BoxDecoration(
          color: softPink, borderRadius: BorderRadius.circular(25)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(post['tag'] as String,
                  style: const TextStyle(
                      color: hotPink, fontWeight: FontWeight.bold)),
              Text(post['user'] as String,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                      fontStyle: FontStyle.italic)),
            ],
          ),
          const SizedBox(height: 10),
          Text(post['title'] as String,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 5),
          Text(post['content'] as String),
          if (post['type'] == 'audio') _buildAudioWaveform(),
          const SizedBox(height: 15),
          Row(
            children: <Widget>[
              _ActionBtn(
                icon: (post['isLiked'] as bool)
                    ? Icons.favorite
                    : Icons.favorite_border,
                label: "Support",
                color: hotPink,
                onTap: () => setState(
                    () => post['isLiked'] = !(post['isLiked'] as bool)),
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
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: const Row(children: <Widget>[
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
        children: <Widget>[
          // PROFILE PIC - Now interactive for profile/settings
          GestureDetector(
            onTap: () {
              Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const ProfileScreen()));
            },
            child: const CircleAvatar(
                backgroundColor: softPink,
                radius: 18,
                child: Text("P",
                    style: TextStyle(
                        color: hotPink, fontWeight: FontWeight.bold))),
          ),
          const SizedBox(width: 8),
          // TEXT BOX WITH EMOJI AND GIF
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: softPink, borderRadius: BorderRadius.circular(25)),
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _mainController,
                      onSubmitted: (String val) =>
                          _showPublishDialog(content: val),
                      decoration: const InputDecoration(
                          hintText: "Share a secret...",
                          border: InputBorder.none),
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.emoji_emotions_outlined,
                          color: skyBlue, size: 20),
                      onPressed: () =>
                          _showFeatureComingSoon(context, "Emoji")),
                  IconButton(
                      icon: const Icon(Icons.gif_box_outlined,
                          color: skyBlue, size: 20),
                      onPressed: () =>
                          _showFeatureComingSoon(context, "GIF (input)")),
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
        children: <Widget>[
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 5),
          Text(label,
              style: TextStyle(
                  color: color, fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }
}