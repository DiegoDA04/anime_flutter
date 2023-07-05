import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  SharedPreferences? preferences;
  bool get isPresent => preferences != null;

  String get episodes => "episodes";
  String get members => "members";

  static final instance = AppPreferences._internal();

  AppPreferences._internal() {
    SharedPreferences.getInstance().then((value) {
      preferences = value;
    });
  }

  factory AppPreferences() => instance;

  int getTotalAnimeEpisodes() =>
      isPresent ? preferences!.getInt(episodes) ?? 0 : 0;
  int getTotalAnimeMembers() =>
      isPresent ? preferences!.getInt(members) ?? 0 : 0;

  void saveForAnime(int nEpisodes, int nMembers) {
    var totalAnimeEpisodes = getTotalAnimeEpisodes();
    var totalAnimeMembers = getTotalAnimeMembers();
    if (isPresent) {
      preferences!.setInt(episodes, nEpisodes + totalAnimeEpisodes);
      preferences!.setInt(members, nMembers + totalAnimeMembers);
    }
  }

  void deleteForAnime(int nEpisodes, int nMembers) {
    var totalAnimeEpisodes = getTotalAnimeEpisodes();
    var totalAnimeMembers = getTotalAnimeMembers();

    if (isPresent) {
      preferences!.setInt(episodes, totalAnimeEpisodes - nEpisodes);
      preferences!.setInt(members, totalAnimeMembers - nMembers);
    }
  }
}
