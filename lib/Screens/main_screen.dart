import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
// import 'package:rating_dialog/rating_dialog.dart';

import '../Models/movie_model.dart';
import 'detail_screen.dart';
import 'drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var movieName = TextEditingController();
  late StreamController _streamController;
  late Stream _stream;

  void _search(String name) async {
    _streamController.add('loading');
    var url = 'https://www.omdbapi.com/?t=$name&plot=full&apiKey=94e188aa';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonbData = json.decode(response.body);
      if (jsonbData['Response'] == 'True') {
        Movie movie = Movie.fromJson(jsonbData);
        //now we add to the model data to json

        //streamController.add(jsonbData);
        _streamController.add(movie);
      } else {
        _streamController.add('not fond');
      }
      //print(jsonbData);
    } else {
      _streamController.add('wrong');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _streamController = StreamController();
    _stream = _streamController.stream;
    _streamController.add('empty');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Center(
          child: Text(
            'Search Movies',
            style: TextStyle(
                fontSize: 23,
                letterSpacing: 2,
                fontFamily: 'b',
                fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.star,
              size: 40,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                // set to false if you want to force a rating
                builder: (context) => RatingDialog(
                  initialRating: 1.0,
                  title: Text(
                    'Movir Searcher',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 40,
                      fontFamily: 'e',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  message: Text(
                    'Tap a star to set your rating. Add more description here if you want.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 19, fontFamily: 'a'),
                  ),
                  // your app's logo?
                  image: Image.asset('assets/stars.jpg'),
                  submitButtonText: 'Submit',
                  commentHint: 'Write your review about our app',
                  onCancelled: () => print('cancelled'),
                  onSubmitted: (response) {
                    print(
                        'rating: ${response.rating}, comment: ${response.comment}');
                  },
                ),
              );
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              color: Colors.teal,
              child: Column(
                children: [
                  TextField(
                    controller: movieName,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Colors.greenAccent, width: 4)),
                        enabledBorder: OutlineInputBorder(

                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                BorderSide(color: Colors.amber, width: 4)),
                        hintText: 'Enter movie name',hintStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.greenAccent,
                    ),
                        labelText: 'Movie name',
                        labelStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.greenAccent,
                        ),
                        helperText: 'Please entre the correct movie name',
                        helperStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.brown,
                        ),),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.black,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: Colors.purple,
                          width: 2,
                        ),
                      ),
                    ),
                    icon: Icon(Icons.search),
                    label: Text(
                      'Search',
                      style: TextStyle(fontSize: 28,fontFamily: 'a'),
                    ),
                    onPressed: () {
                      if (movieName.text.isNotEmpty) {
                        _search(movieName.text);
                      } else {
                        Fluttertoast.showToast(msg: 'Plz enter movie name');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _stream,
              builder: (context, snapshot) {
                if (snapshot.data == 'empty') {
                  return Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'ALL ABOUT MOVIES',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'a',
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'HOLLYWOOD:',
                            style: TextStyle(
                              fontSize: 27,
                              fontFamily: 'b',
                              color: Colors.purple,
                            ),
                          ),
                          Image.asset('assets/1.jpeg'),
                          Text(
                            'BOLLYWOOD:',
                            style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'b',
                              color: Colors.purple,
                            ),
                          ),
                          Image.asset('assets/bolly.jpeg'),
                        ],
                      ),
                    ),
                  );
                }
                else if (snapshot.data == 'loading') {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data == 'wrong') {
                  return Center(
                    child: Text('somethings went wrong'),
                  );
                } else if (snapshot.data == 'not fond') {
                  return Center(
                    child: Text('movie not found'),
                  );
                } else {
                  Movie? movies = snapshot.data as Movie;
                  return Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Title : ${movies.Title}',
                            style: TextStyle(fontSize: 30,fontFamily: 'b'),
                          ),
                          Text(
                            'Poster:',
                            style: TextStyle(fontSize: 30,fontFamily: 'b'),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Image.network(
                              movies.Poster,
                            ),
                          ),
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 12,
                                  shadowColor: Colors.red,

                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)
                                  )
                              ),
                              child: Text('Movies Details',style: TextStyle(fontFamily: 'b',fontSize: 26),),
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (ctx) {
                                  return MovieDetealScreen(movie: movies);
                                }));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
