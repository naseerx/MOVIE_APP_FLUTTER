import 'package:flutter/material.dart';

import '../Models/movie_model.dart';
import 'main_screen.dart';


class MovieDetealScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetealScreen({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieDetealScreen> createState() => _MovieDetealScreenState();
}

class _MovieDetealScreenState extends State<MovieDetealScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffe2cafa),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              shadowColor: Colors.teal,
              elevation: 10,
              backgroundColor: Colors.red,
              expandedHeight: 300,
              pinned: true,
              floating: false,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  widget.movie.Title,
                  style: TextStyle(
                    fontSize: 35,
                    fontFamily: 'e',
                    letterSpacing: 2,
                  ),
                ),
                centerTitle: true,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  widget.movie.Poster,
                                  height: 200,
                                  width: 130,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.movie.Title,
                                    style: TextStyle(
                                        fontSize: 38,
                                        fontWeight: FontWeight.bold,color: Colors.teal,
                                        fontFamily: 'b'),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),

                                  Row(
                                    children: [
                                      Text(
                                        'RATING : ',
                                        style: TextStyle(fontSize: 27, color: Colors.purple),
                                      ),
                                      Text(
                                        '${widget.movie.imdbRating}/10',
                                        style: TextStyle(
                                          fontSize: 30,color: Colors.teal
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'DURATION : ',
                                        style: TextStyle(fontSize: 27, color: Colors.purple),
                                      ),
                                      Text(
                                        widget.movie.Runtime,
                                        style: TextStyle(
                                          fontSize: 30,color: Colors.teal
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        scrollDirection: Axis.horizontal,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConsText(
                              text: 'DESCRIPTION:',
                              text1: widget.movie.Plot,
                            ),
                            ConsText(
                              text: 'RELEASED:',
                              text1: widget.movie.Released,
                            ),
                            ConsText(
                              text: 'ACTORS:',
                              text1: widget.movie.Actors,
                            ),
                            ConsText(
                              text: 'DIRECTOR:',
                              text1: widget.movie.Director,
                            ),
                            ConsText(
                              text: 'WRITER:',
                              text1: widget.movie.Writer,
                            ),
                            ConsText(
                              text: 'AWARDS:',
                              text1: widget.movie.Awards,
                            ),
                            ConsText(
                              text: 'BOX OFFICE:',
                              text1: widget.movie.BoxOffice,
                            ),
                            ConsText(
                              text: 'GENRE:',
                              text1: widget.movie.Genre,
                            ),
                            ConsText(
                              text: 'COUNTRY:',
                              text1: widget.movie.Country,
                            ),
                            ConsText(
                              text: 'WEBSITE:',
                              text1: widget.movie.Website,
                            ),
                            ConsText(
                              text: 'RATED:',
                              text1: widget.movie.Rated,
                            ),
                            ConsText(
                              text: 'LANGUAGE:',
                              text1: widget.movie.Language,
                            ),
                            ConsText(
                              text: 'META SCORE:',
                              text1: widget.movie.Metascore,
                            ),
                            ConsText(
                              text: 'IMBD VOTES:',
                              text1: widget.movie.imdbVotes,
                            ),
                            ConsText(
                              text: 'IMBD ID:',
                              text1: widget.movie.imdbID,
                            ),
                            ConsText(
                              text: 'TYPE:',
                              text1: widget.movie.Type,
                            ),
                            ConsText(
                              text: 'DVD:',
                              text1: widget.movie.DVD,
                            ),
                            ConsText(
                              text: 'WEBSITE:',
                              text1: widget.movie.Website,
                            ),
                            ConsText(
                              text: 'PRODUCTION:',
                              text1: widget.movie.Production,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  onPrimary: Colors.purple,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    side: BorderSide(
                                      color: Colors.purple,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                icon: Icon(Icons.home),
                                label: Text(
                                  'HOME',
                                  style:
                                      TextStyle(fontSize: 28, fontFamily: 'a'),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return HomeScreen();
                                  }));
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ));
  }
}

class ConsText extends StatelessWidget {
  String text;
  String text1;

  ConsText({required this.text, required this.text1});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          color: Colors.black,
        ),
        SizedBox(height: 12),
        Text(
          text,
          style: TextStyle(fontSize: 26, fontFamily: 'b', color: Colors.purple),
        ),
        Text(
          text1,
          style: TextStyle(fontSize: 16, color: Colors.blueGrey),
        ),
        SizedBox(height: 5),
      ],
    );
  }
}
