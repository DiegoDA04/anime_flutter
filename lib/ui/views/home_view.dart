import 'package:anime_flutter/data/helpers/http_helper.dart';
import 'package:anime_flutter/ui/widgets/anime_card.dart';
import 'package:flutter/material.dart';

import '../../data/helpers/db_helper.dart';
import '../../data/models/anime.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Anime>? topAnimes;
  final ScrollController scrollController = ScrollController();
  int _currentPage = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    topAnimes = List.empty();
    initalize();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadMoreData();
      }
    });
  }

  void loadMoreData() async {
    List<Anime> moreAnimes = await HttpHelper.fetchTopAnimes(_currentPage + 1);

    topAnimes!.addAll(moreAnimes);

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        topAnimes!.addAll(moreAnimes);
        _currentPage++;
      });
    });
  }

  initalize() async {
    List<Anime> dbItems = await DbHelper.fetchAnimes();
    topAnimes = await HttpHelper.fetchTopAnimes(_currentPage);

    for (var animeFromDb in dbItems) {
      int animeIndex =
          topAnimes!.indexWhere((element) => element.id == animeFromDb.id);
      if (animeIndex != -1) {
        topAnimes![animeIndex].isFavorite = animeFromDb.isFavorite;
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: size.width,
        padding: const EdgeInsets.only(right: 20.0, top: 20.0, left: 20.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "AnimeApp",
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                "List of animes",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 18.0,
              ),
              Chip(
                backgroundColor: Colors.black,
                label: const Text(
                  "Top",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: topAnimes!.length + 1,
                  itemBuilder: (context, index) {
                    if (index < topAnimes!.length) {
                      return AnimeCard(
                        anime: topAnimes![index],
                      );
                    } else {
                      return _buildLoadingIndicator();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
