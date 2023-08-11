import 'package:http/http.dart' as http;
import 'package:music_app_technical_assessment/models/song.dart';
import 'dart:convert';

class SongServices {
  Future<List<Song>> getSong({required String artist}) async {
    Map<String, String> requestHeaders = {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*"
    };
    final response = await http.get(
      Uri.parse('https://itunes.apple.com/search?term=$artist'),
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      // print('masuk');
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> data = map['results'];
      List<Song> listSong = [];
      for (int i = 0; i < data.length; i++) {
        Song song = Song(
          title: data[i]['trackName'],
          artistName: data[i]['artistName'],
          album: data[i]['collectionName'],
        );
        listSong.add(song);
      }
      print(listSong);
      return listSong;
    } else {
      throw ("Gagal mengambil data materi");
    }
  }
}
