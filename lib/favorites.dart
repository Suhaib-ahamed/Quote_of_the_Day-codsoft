import 'package:flutter/material.dart';
import 'main.dart';
import "package:share_plus/share_plus.dart";
import "package:flutter/cupertino.dart";

class FavoriteScreen extends StatefulWidget {
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Quotes'),
      ),
      body: SizedBox(
        height: 800,
        width: 700,
        child: ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                const newDivider(),
                favoritesContainer(favorites[index], index),
                //newDivider(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget favoritesContainer(String favorite, int index) {
    return Container(
      height: 300,
      width: 290,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: const DecorationImage(
              colorFilter: ColorFilter.mode(
                  Color.fromARGB(129, 91, 119, 108), BlendMode.dstATop),
              image: AssetImage("assets/th.jpg"),
              fit: BoxFit.cover)),
      margin: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  if (favorites.isNotEmpty) {
                    setState(() {
                      favorites.removeAt(index);
                    });
                  }
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.black54,
                ),
                iconSize: 30,
              ),
              IconButton(
                onPressed: () {
                  Share.share(favorites[index]);
                },
                icon: const Icon(
                  Icons.share,
                  color: Colors.blue,
                ),
                iconSize: 30,
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Container(
                margin: EdgeInsets.all(30),
                child: Text(
                  textAlign: TextAlign.justify,
                  '"$favorite"',
                  style: const TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
