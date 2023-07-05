import 'package:anime_flutter/data/helpers/db_helper.dart';
import 'package:anime_flutter/ui/widgets/anime_card.dart';
import 'package:anime_flutter/ui/widgets/anime_modal.dart';
import 'package:anime_flutter/utils/app_preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/anime.dart';

class AnimeListView extends StatefulWidget {
  const AnimeListView({super.key});

  @override
  State<AnimeListView> createState() => _AnimeListViewState();
}

class _AnimeListViewState extends State<AnimeListView> {
  List<Anime>? animesDb;
  final AppPreferences appPreferences = AppPreferences();

  @override
  void initState() {
    super.initState();
    animesDb = List.empty();
    initalize();
  }

  initalize() async {
    animesDb = await DbHelper.fetchAnimes();
    if (mounted) {
      setState(() {});
    }
  }

  void removeAnime(Anime anime) {
    setState(() {
      animesDb?.remove(anime);
      appPreferences.deleteForAnime(anime.episodes!, anime.members!);
    });
  }

  void showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AnimeModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.only(right: 20.0, top: 20.0, left: 20.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Anime List",
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    onPressed: () => showModal(context),
                    icon: Icon(Icons.info),
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: animesDb!.length,
                  itemBuilder: (context, index) => AnimeCard(
                    anime: animesDb![index],
                    buttonAction: removeAnime,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
