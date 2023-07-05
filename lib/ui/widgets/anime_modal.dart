import 'package:anime_flutter/utils/app_preferences.dart';
import 'package:flutter/material.dart';

class AnimeModal extends StatefulWidget {
  const AnimeModal({super.key});

  @override
  State<AnimeModal> createState() => _AnimeModalState();
}

class _AnimeModalState extends State<AnimeModal> {
  AppPreferences? appPreferences;
  int episodes = 0;
  int members = 0;

  @override
  void initState() {
    // TODO: implement initState
    appPreferences = AppPreferences();
    super.initState();
    initalize();
  }

  initalize() {
    episodes = appPreferences!.getTotalAnimeEpisodes();
    members = appPreferences!.getTotalAnimeMembers();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text("Total episodes and memebers"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Episodes: $episodes"),
          Text("Members: $members"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Close'),
        ),
      ],
    );
  }
}
