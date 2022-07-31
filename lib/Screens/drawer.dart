
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _url3 = 'https://www.ptcp.pk/';
    void _launchURL3() async {
      if (!await launch(_url3)) throw 'Could not launch $_url3';
    }

    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.grey),
      child: Drawer(
        child: ListView(
          // padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Center(child: Text('MOVIE\nSEARCHER',style:TextStyle(fontSize: 40,color: Colors.white,fontFamily: 'd'),)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  color: Colors.purple
              ),
            ),
            ListTile(
                leading: Icon(
                  Icons.person_pin,
                  color: Colors.purple,
                  size: 30,
                ),
                title: Text(
                  'ABOUT US',
                  style: TextStyle(
                      color: Colors.purple, fontFamily: 'b', fontSize: 22),
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23)),
                        child: Container(
                          height: 300,
                          width: 350,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 12,
                              ),
                              const CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                AssetImage('assets/nser.jpg'),
                              ),
                              const Text(
                                'Muhammad Naseer',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.teal,
                                    fontFamily: 'd',
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                'FLUTTER DEVELOPER',
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontFamily: 'b',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  letterSpacing: 2.5,
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Divider(
                                thickness: 2,
                                color: Colors.teal.shade100,
                              ),
                              Card(
                                color: Colors.white,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 25,
                                ),
                                child: Row(
                                  children: const <Widget>[
                                    Icon(
                                      Icons.phone,
                                      color: Colors.teal,
                                    ),
                                    Text(
                                      '  +923453096739',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        letterSpacing: 1.5,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 25),
                                child: Row(
                                  children: <Widget>[
                                    const Icon(
                                      Icons.email,
                                      color: Colors.teal,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'muhammadnaseerkhan\n1122@gmail.com',
                                      style: TextStyle(
                                        fontSize: 16,
                                        letterSpacing: 1.5,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal.shade900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
                }),
            ListTile(
              leading: Icon(
                Icons.person_pin,
                color: Colors.purple,
                size: 30,
              ),
              title: Text(
                'WEBSITE',
                style: TextStyle(
                    color: Colors.purple, fontFamily: 'b', fontSize: 22),
              ),
              onTap: () async {
                if (await CheckNet.isConnected()) {
                  _launchURL3();
                } else {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.ERROR,
                    animType: AnimType.RIGHSLIDE,
                    headerAnimationLoop: true,
                    title: 'No Internet Connection',
                    desc:
                    'Please Connect to a mobile Cellular data or wifi connection',
                    btnOkOnPress: () {},
                    btnOkColor: Colors.green,
                  )..show();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CheckNet {
  static Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
      // I am connected to a mobile network.
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
      // I am connected to a wifi network.
    } else {
      return false;
    }
  }
}
