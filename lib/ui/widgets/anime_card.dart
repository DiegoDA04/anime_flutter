import 'package:anime_flutter/utils/app_preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/helpers/db_helper.dart';
import '../../data/models/anime.dart';

class AnimeCard extends StatefulWidget {
  const AnimeCard({super.key, required this.anime, this.buttonAction});
  final Anime anime;
  final Function(Anime)? buttonAction;

  @override
  State<AnimeCard> createState() => _AnimeCardState();
}

class _AnimeCardState extends State<AnimeCard> {
  AppPreferences appPreferences = AppPreferences();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Card(
      margin: const EdgeInsets.only(bottom: 4.0),
      color: Colors.white,
      elevation: 0.0,
      child: Row(
        children: [
          SizedBox(
            height: size.height * 0.15,
            width: size.width * 0.25,
            child: Image.network(
              widget.anime.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: size.height * 0.15,
            width: size.width * 0.45,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.anime.title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      height: 1.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    widget.anime.year == null
                        ? "Unknown year"
                        : widget.anime.year.toString(),
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    widget.anime.isFavorite
                        ? DbHelper.deleteAnime(widget.anime)
                        : {
                            DbHelper.insertAnime(widget.anime),
                            appPreferences.saveForAnime(
                                widget.anime.episodes!, widget.anime.members!)
                          };

                    if (widget.buttonAction != null) {
                      widget.buttonAction!(widget.anime);
                    }

                    setState(() {
                      widget.anime.isFavorite = !widget.anime.isFavorite;
                    });
                  },
                  icon: Icon(widget.anime.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
