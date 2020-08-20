import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Profile Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Stack(
          children: [
            ClipPath(
              child: Container(
                color: Colors.black.withOpacity(0.8),
              ),
              clipper: getClipper(),
            ),
            Positioned(
              left: 50,
              right: 50,
              top: MediaQuery.of(context).size.width / 5,
              child: Column(
                children: [
                  Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(75.0),
                        color: Colors.red,
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                          fit: BoxFit.cover,
                        )),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Tom Cruise',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 40.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Done from Raja Yogan Channel',
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 20.0,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Container(
                    height: 35.0,
                    width: 95.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.green,
                      elevation: 10.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageCarouselScreen(),
                              ));
                        },
                        child: Center(
                          child: Text(
                            'Edit this',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Text(
                                '1253',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('Followers'),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Text(
                                '658',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('Following'),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Text(
                                '256',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('Likes'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class ImageCarouselScreen extends StatefulWidget {
  @override
  _ImageCarouselScreenState createState() => _ImageCarouselScreenState();
}

class _ImageCarouselScreenState extends State<ImageCarouselScreen> {
  int photoIndex = 0;

  List<String> photos = [
    'assets/images/apple.jpg',
    'assets/images/flutter_dahsboard.png',
    'assets/images/Untitled.png'
  ];

  void _prevImage() {
    setState(() {
      photoIndex = photoIndex > 0 ? photoIndex - 1 : 0;
    });
  }

  void _nextImage() {
    setState(() {
      photoIndex = photoIndex < photos.length - 1 ? photoIndex + 1 : photoIndex;
    });
  }

  Widget image_carousel = new Container(
        height: 400.0,
        child: CarouselSlider(
          options: CarouselOptions(
            height: 400.0,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: Duration(milliseconds: 800),),
          items: [
            'http://pic3.16pic.com/00/55/42/16pic_5542988_b.jpg',
            'http://photo.16pic.com/00/38/88/16pic_3888084_b.jpg',
            'http://pic3.16pic.com/00/55/42/16pic_5542988_b.jpg',
            'http://photo.16pic.com/00/38/88/16pic_3888084_b.jpg'
          ].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(color: Colors.amber),
                    child: GestureDetector(
                        child: Image.network(i, fit: BoxFit.fill),
                        onTap: () {
                          Navigator.push<Widget>(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageScreen(i),
                            ),
                          );
                        }));
              },
            );
          }).toList(),
        ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [ 
              Container(
                //Padding(padding: EdgeInsets.only(top: 10.0)),
                //width: MediaQuery.of(context).size.width,
                height: 240.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(photos[photoIndex]),
                        fit: BoxFit.cover),
                    border: Border.all(color: Colors.black)),
              ),
              GestureDetector(
                onTap: _nextImage,
                child: Container(
                  height: 240.0,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                ),
              ),
              GestureDetector(
                onTap: _prevImage,
                child: Container(
                  height: 240.0,
                  width: MediaQuery.of(context).size.width / 2,
                  color: Colors.transparent,
                ),
              ),
              Positioned(
                top : 220.0,
                left: MediaQuery.of(context).size.width / 2 - 30.0,
                child: Row(
                  children: [
                    SelectedPhoto(
                      photoIndex : photoIndex,
                      numberOfDots : photos.length,
                    ),
                  ],
                ),
              )
            ],
          ),
          image_carousel,
        ],
      ),
    );
  }
}

class SelectedPhoto extends StatelessWidget {

  final int photoIndex;
  final int numberOfDots;

  SelectedPhoto({this.photoIndex,this.numberOfDots});

  List<Widget> _buildDots() {
    List<Widget> dots = [];

    for (int i=0; i< numberOfDots; ++i) {
      dots.add(i == photoIndex ? _activeDot() : _inactiveDot());
    }
    return dots;
  }

  Widget _activeDot() {
     return new Container(
      child: Padding(
        padding: EdgeInsets.only(left: 3.0, right: 3.0),
        child: Container(
            width: 10.0,
            height: 10.0,
            decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(5.0),
                )),
      ),
    );
  }

  Widget _inactiveDot() {
    return new Container(
      child: Padding(
        padding: EdgeInsets.only(left: 3.0, right: 3.0),
        child: Container(
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(4.0))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children:
          _buildDots(),
      ),
    );
  }
}

class ImageScreen extends StatefulWidget {
  final String url;
  ImageScreen(this.url);

  @override
  _MyImageScreen createState() => _MyImageScreen(url);
}

class _MyImageScreen extends State<ImageScreen> {
  final String url;
  _MyImageScreen(this.url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ImageScreen'),
        ),
        body: Image.network(url, width: double.infinity));
  }
}