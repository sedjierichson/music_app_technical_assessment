// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:music_app_technical_assessment/api/dbservices_song.dart';
import 'package:music_app_technical_assessment/models/song.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SongServices db = SongServices();
  List<Song> listSong = [];
  bool isLoadingAll = true;
  bool isErrorAll = false;

  void getSongList() async {
    try {
      listSong = await db.getSong(artist: "new jeans");
      setState(() {
        isLoadingAll = false;
        isErrorAll = false;
      });
    } catch (e) {
      setState(() {
        isLoadingAll = false;
        isErrorAll = true;
      });
    }
  }

  @override
  void initState() {
    getSongList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                SearchBar(
                  hintText: 'Search Artist',
                ),
                Expanded(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: getSongList,
                        child: Text('Tests'),
                      ),
                      Expanded(child: cardSong()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cardSong() {
    if (isLoadingAll == false && isErrorAll == false) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: listSong.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: FlutterLogo(size: 50.0),
              title: Text(listSong[index].title),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(listSong[index].artistName),
                  Text(listSong[index].album)
                ],
              ),
              trailing: Icon(Icons.more_vert),
              isThreeLine: true,
            ),
          );
        },
      );
    } else {
      return CircularProgressIndicator();
    }
  }
}
