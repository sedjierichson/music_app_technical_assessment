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
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: ,
                      ),
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
}
