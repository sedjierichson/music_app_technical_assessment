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
  TextEditingController tfSearch = TextEditingController();
  List<Song> listSong = [];
  bool isLoadingAll = true;
  bool isErrorAll = false;
  bool isSelected = false;
  int indexSelected = 9999;
  void getSongList(String search) async {
    try {
      listSong = await db.getSong(artist: search);
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
    getSongList('justin bieber');
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
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextField(
                    controller: tfSearch,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            getSongList(tfSearch.text.toString());
                          });
                        },
                        icon: Icon(Icons.search),
                      ),
                      focusColor: Colors.black,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelText: 'Search Artist',
                    ),
                  ),
                ),
                // Expanded(
                //   child: Column(
                //     children: [
                //       ElevatedButton(
                //         onPressed: getSongList,
                //         child: Text('Tests'),
                //       ),
                Expanded(child: cardSong()),
                //     ],
                //   ),
                // ),
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
          return GestureDetector(
            onTap: () {
              print('halo');
              setState(() {
                indexSelected = index;
              });
            },
            child: Card(
              child: ListTile(
                leading: Image.network(
                  listSong[index].image.toString(),
                  width: 70,
                  height: 70,
                  fit: BoxFit.fill,
                ),
                title: Text(
                  listSong[index].title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(listSong[index].artistName),
                    Text(listSong[index].album)
                  ],
                ),
                trailing: indexSelected == index
                    ? Icon(Icons.play_arrow)
                    : SizedBox(),
                isThreeLine: true,
              ),
            ),
          );
        },
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
