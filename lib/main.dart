import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "favorites.dart";
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(Myhome());
}

class Myhome extends StatefulWidget {
  const Myhome({Key? key}) : super(key: key);

  @override
  State<Myhome> createState() => _MyhomeState();
}

List<String> quotes = [
  'So many books, so little time',
  'A room without books is like a body without a soul',
  'You only live once, but if you do it right, once is enough.',
  'Be the change that you wish to see in the world.',
  "If you tell the truth, you don't have to remember anything.",
];

List<String> newQuotes = [
  'Be yourself; everyone else is already taken',
];

List<String> favorites = [];

List<String> refresh = [
  'To be yourself in a world that is constantly trying to make you something else is the greatest accomplishment.',
  'The only way to do great work is to love what you do',
  "Believe you can and you're halfway there.",
  'Strive not to be a success, but rather to be of value',
  'The purpose of our lives is to be happy',
  'The best way to predict the future is to create it',
  'Please wait until tomorrow'
];

int i = 0;

DateTime lastRefreshTime = DateTime.now();

class _MyhomeState extends State<Myhome> {
  @override
  Widget build(BuildContext context) {
    if (DateTime.now().difference(lastRefreshTime).inDays > 0) {
      setState(() {
        newQuotes.add(refresh[0]);

        quotes.addAll(newQuotes);

        lastRefreshTime = DateTime.now();
      });
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Quote of The Day'),
          centerTitle: true,
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white10, Colors.greenAccent])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                      iconSize: 30,
                      onPressed: () {
                        if (i < refresh.length) {
                          setState(() {
                            quotes.add(newQuotes.removeAt(0));

                            newQuotes.add(refresh[i]);

                            i += 1;
                          });
                        }
                      },
                      icon: const Icon(Icons.queue_rounded)),
                  const navigate()
                ],
              ),
              const newDivider(),
              const Row(
                children: <Widget>[
                  SizedBox(
                    width: 50,
                  ),
                ],
              ),
              SizedBox(
                  height: 350,
                  width: 320,
                  child: newQuotecontainer(newQuotes[newQuotes.length - 1])),
              const newDivider(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 50,
                  ),
                  Text(
                    'Yesterday',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 25),
                  ),
                ],
              ),
              Expanded(
                child: SizedBox(
                  height: 300,
                  width: 320,
                  child: ListView.builder(
                    itemCount: quotes.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      final reversedQuotes = quotes.reversed.toList();
                      return Row(
                        children: [
                          const VerticalDivider(
                            thickness: 2.5,
                            indent: 50,
                            endIndent: 50,
                            color: Colors.greenAccent,
                          ),
                          buildContainer(reversedQuotes[index], index),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class newDivider extends StatelessWidget {
  const newDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 1,
      indent: 20,
      endIndent: 20,
      color: Colors.black,
    );
  }
}

Widget buildContainer(String quote, int index) {
  return Container(
    height: 300,
    width: 290,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: const DecorationImage(
            colorFilter: ColorFilter.mode(
                Color.fromARGB(154, 255, 249, 249), BlendMode.dstATop),
            image: AssetImage('assets/OIP.jpg'),
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
                  if (quotes.isNotEmpty) {
                    favorites.add(quotes[index]);
                    print('Quote added to favorites: ${quotes[index]}');
                  }
                },
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                iconSize: 30,
              ),
              IconButton(
                onPressed: () {
                  Share.share(quotes[index]);
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
                  '"$quote"',
                  style: const TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ]),
  );
}

Widget newQuotecontainer(String newQuotes) {
  return Container(
    height: 300,
    width: 290,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: const DecorationImage(
            colorFilter: ColorFilter.mode(
                Color.fromARGB(160, 255, 254, 254), BlendMode.dstATop),
            image: AssetImage('assets/th (1).jpg'),
            fit: BoxFit.cover)),
    margin: const EdgeInsets.all(30),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    ScaleAnimatedText('New Quote'),
                    ScaleAnimatedText('New Quote '),
                  ],
                  repeatForever: true,
                  totalRepeatCount: 10,
                  // pause: const Duration(milliseconds: 1000),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: false,
                ),
                IconButton(
                  onPressed: () {
                    if (quotes.isNotEmpty) {
                      favorites.add(newQuotes);
                      print('Quote added to favorites: ${newQuotes[0]}');
                    }
                  },
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  iconSize: 30,
                ),
                IconButton(
                  onPressed: () {
                    Share.share(newQuotes);
                  },
                  icon: const Icon(
                    Icons.share,
                    color: Colors.blue,
                  ),
                  iconSize: 30,
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                margin: EdgeInsets.all(30),
                child: Text(
                  textAlign: TextAlign.justify,
                  '"$newQuotes"',
                  style: const TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ]),
  );
}

class navigate extends StatelessWidget {
  const navigate({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        iconSize: 30,
        onPressed: () {
          print('object');
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => FavoriteScreen()));
        },
        icon: Icon(Icons.favorite_border));
  }
}
