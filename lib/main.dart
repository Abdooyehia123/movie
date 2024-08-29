import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:abdoooo/custshape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

int temp = 0;
List<IconData> borh = [];
List<int> fa = [];
int a = 0;
int myindex = 0;
List<String> img = [
  // 'images/abul.jpg',
  // 'images/ertu.jpeg',
  // 'images/omar_mok.jpg',
  // 'images/omr.jpg',
  // 'images/p23474939_b_v13_aa.jpg',
  // 'images/saladin.jpg',
  // 'images/the meassa.jpeg'
];
List<String> titles = [
  // 'Abulhamid khan',
  // 'Ertugrul',
  // 'Lion',
  // 'Omar',
  // 'Mehmet',
  // 'Saladin',
  // 'The Meassage'
];

List<String> data = [];
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isdesk(BuildContext context) => MediaQuery.of(context).size.width >= 600;
  bool ismob(BuildContext context) => MediaQuery.of(context).size.width < 600;

  @override
  void initState() {
    super.initState();
    signin();
  }

  signin() async {
    var response = await Dio().get(
        'https://api.themoviedb.org/3/movie/popular?api_key=1b869b3ccf57d089047ded4b1de007b8&language=en-US');

    var results = response.data['results'] as List;
    print("${results.length}");

    setState(() {
      img = results.map<String>((movie) {
        String posterPath = movie['poster_path'];
        borh.add(Icons.favorite_border);
        return 'https://image.tmdb.org/t/p/w500' + posterPath;
      }).toList();

      titles = results.map<String>((movie) {
        String title = movie['title'];
        return title;
      }).toList();

      data = results.map<String>((movie) {
        String data = movie['overview'];
        return data;
      }).toList();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 27, 24, 24),
      appBar: AppBar(
        title: const Text(
          "Latest movies",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 34, 34, 34),
        centerTitle: true,
      ),
      body: SafeArea(child: OrientationBuilder(builder: (context, orientation) {
        return GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: ismob(context) ? 2 : 3, mainAxisExtent: 90 + 256),
          children: List.generate(titles.length, (index) {
            borh.add(Icons.favorite_border);
            return GestureDetector(
              onTap: () {
                a = index;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyWidget()),
                );
              },
              //...
              child: Container(
                margin: const EdgeInsets.all(3),
                height: 100,
                width: 180,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(0, 51, 50, 50),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Container(
                        child: Stack(children: [
                          Container(
                            height: 250,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(img[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          IconButton(
                              onPressed: () {
                                setState(() {
                                  if (borh[index] == Icons.favorite_border) {
                                    borh[index] = Icons.favorite;
                                    fa.add(index);
                                  } else {
                                    borh[index] = Icons.favorite_border;
                                    fa.remove(index);
                                  }
                                });
                              },
                              icon: Icon(
                                borh[index],
                                color: Colors.white,
                              ))
                          //              child: GestureDetector(onTap: () {
                          //               print("Clicked");
                          // Navigator.push(
                          //   context,
                          //    MaterialPageRoute(builder: (context) => const MyWidget()),
                          // );
                          // }),
                        ]),
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 90,
                      alignment: Alignment.topLeft,
                      color: Color.fromARGB(0, 51, 50, 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.fromLTRB(
                                  ismob(context) ? 7 : 40, 10, 0, 0),
                              child: Text(
                                titles[index],
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              )),
                          Padding(
                              padding: EdgeInsets.fromLTRB(
                                  ismob(context) ? 7 : 40, 10, 0, 0),
                              child: Text(
                                data[index].substring(0, 40),
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(83, 248, 248, 248),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      })),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 27, 24, 24),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Container(
            child: Container(
                child: Stack(children: [
              ClipPath(
                clipper: custshape(),
                child: Container(
                  height: 230,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.cover,

                    image: NetworkImage(
                      img[a],
                    ),
                    //   fit: BoxFit.cover,
                    //   height: 230,
                    //   width: MediaQuery.of(context).size.width,
                  )),
                ),
                // child: Image.asset(
                //   img[a],
                //   fit: BoxFit.cover,
                //   height: 230,
                //   width: MediaQuery.of(context).size.width,
                // )
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 120, 0, 0),
                height: 190,
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: const Color.fromARGB(255, 70, 70, 70)
                            .withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 0),
                        blurStyle: BlurStyle.outer),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(img[a]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: 220,
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                height: 130,
                margin: EdgeInsets.fromLTRB(180, 220, 0, 0),
                decoration:
                    BoxDecoration(color: const Color.fromARGB(0, 253, 17, 0)),
                child: Stack(
                  children: [
                    Text(
                      titles[a],
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                        child: Text(
                          "data abbou ksflasklfaskljfkl;asjflkaslkfaslkgaslgnkl",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 139, 139, 139),
                          ),
                        )),
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 90, 0, 0),
                        child: Text(
                          "pobularity : 1042",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 185, 185, 185),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                width: 390,
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                height: 200,
                margin: EdgeInsets.fromLTRB(10, 330, 0, 0),
                decoration: BoxDecoration(color: Color.fromARGB(0, 255, 17, 0)),
                child: Stack(
                  children: [
                    Text(
                      "Story line",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 28, 0, 0),
                        child: ReadMoreText(
                          data[a],
                          numLines: 1,
                          readMoreText: 'Read more',
                          readLessText: 'Read less',
                          readMoreIconColor: Colors.red,
                          readMoreTextStyle: TextStyle(
                            color: Colors.red,
                          ),
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                width: 390,
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                height: 240,
                margin: EdgeInsets.fromLTRB(10, 490, 0, 0),
                decoration: BoxDecoration(color: Color.fromARGB(0, 255, 17, 0)),
                child: Stack(
                  children: [
                    Text(
                      "photos",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
                        child: FlutterCarousel(
                          options: CarouselOptions(
                            height: 400.0,
                            showIndicator: false,
                            slideIndicator: CircularSlideIndicator(),
                          ),
                          items: [1, 2, 3, 4, 5].map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                    width: 600,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: NetworkImage(img[i]),
                                        fit: BoxFit.cover,
                                      ),
                                    ));
                              },
                            );
                          }).toList(),
                        ))
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 800, 0, 0),
                  child: Stack(
                    children: [
                      Container(
                          width: 390,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          height: 120,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(0, 252, 17, 0)),
                          child: Text(
                            "act",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                          )),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                          width: 390,
                          height: 120,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(0, 252, 17, 0)),
                          child: FlutterCarousel(
                            options: CarouselOptions(
                              //height: 150.0,
                              //enlargeCenterPage: false,
                              viewportFraction: 0.3,
                              initialPage: 3,
                              enableInfiniteScroll: true,
                              showIndicator: false,
                              reverse: true,
                              slideIndicator: CircularSlideIndicator(),
                            ),
                            items: [1, 2, 3, 4, 5].map((i) {
                              return Column(
                                children: [
                                  CircleAvatar(
                                    radius: 40.0,
                                    backgroundImage: NetworkImage(img[i]),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    titles[i],
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.white),
                                  ),
                                ],
                              );
                            }).toList(),
                          ))
                    ],
                  ))
            ])),
          )),
        ));
  }
}

//borderRadius: BorderRadius.circular(0),
class fav extends StatefulWidget {
  const fav({super.key});

  @override
  State<fav> createState() => _fav();
}

class _fav extends State<fav> {
  @override
  Widget build(BuildContext context) {
    bool isdesk(BuildContext context) =>
        MediaQuery.of(context).size.width >= 600;
    bool ismob(BuildContext context) => MediaQuery.of(context).size.width < 600;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "favorite movies",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 34, 34, 34),
        centerTitle: true,
      ),
      body: Container(
          color: const Color.fromARGB(255, 29, 29, 29),
          child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, mainAxisExtent: 180, mainAxisSpacing: 5),
              children: List.generate(fa.length, (index) {
                return Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      height: ismob(context) ? 200 : 200,
                      width: ismob(context) ? 400 : 860,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(
                              img[fa[index]],
                            ),
                            fit: BoxFit.cover,
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
                            height: 170,
                            width: ismob(context) ? 90 : 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: const Color.fromARGB(255, 53, 51, 51)
                                        .withOpacity(0.8),
                                    spreadRadius: 0,
                                    blurRadius: 20,
                                    offset: Offset(0, 0),
                                    blurStyle: BlurStyle.outer),
                              ],
                              image: DecorationImage(
                                image: NetworkImage(img[fa[index]]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Padding(
                                    padding: EdgeInsets.fromLTRB(10, 30, 0, 0),
                                    child: Text(
                                      titles[fa[index]],
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                        shadows: [
                                          Shadow(
                                            blurRadius: 20.0,
                                            color: Color.fromARGB(
                                                118, 255, 255, 255),
                                            offset: Offset(0, 0),
                                          ),
                                        ],
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                    )),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                    child: Text(
                                      data[fa[index]].substring(
                                          0, ismob(context) ? 30 : 80),
                                      maxLines: 4,
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                        shadows: [
                                          Shadow(
                                            blurRadius: 20.0,
                                            color: Color.fromARGB(190, 0, 0, 0),
                                            offset: Offset(0, 0),
                                          ),
                                        ],
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 51, 51, 51),
                                      ),
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }))),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Center(child: MyHomePage()),
    Center(child: fav()),
    Center(child: Text('Profile')),
    Center(child: Text('Profile')),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.new_releases_outlined),
            label: 'latest',
            backgroundColor: const Color.fromARGB(255, 34, 34, 34),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'favorite',
            backgroundColor: const Color.fromARGB(255, 34, 34, 34),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department_rounded),
            label: 'trending',
            backgroundColor: const Color.fromARGB(255, 34, 34, 34),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'gg',
            backgroundColor: const Color.fromARGB(255, 34, 34, 34),
          )
        ],
      ),
    );
  }
}

// child: Row(
//           children: [
// /////////////////////////
//             Column(
//                 // verticalDirection: VerticalDirection.down,
//                 // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 // crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                       alignment: Alignment.bottomCenter,
//                       color: const Color.fromARGB(255, 70, 14, 224),

//                       // decoration: const BoxDecoration(
//                       //   shape: BoxShape.circle,
//                       //   color: Color.fromARGB(255, 82, 3, 3),
//                       width: 183,
//                       height: 260,
//                       child: Column(
//                         children: [
//                           Container(
//                             alignment: Alignment.bottomCenter,
//                             // color: const Color.fromARGB(255, 103, 90, 139),
//                             child: Image.asset('images/omr.jpg'),
//                             // decoration: const BoxDecoration(
//                             //   shape: BoxShape.circle,
//                             //   color: Color.fromARGB(255, 82, 3, 3),
//                             width: 183,
//                             height: 180,
//                           ),
//                           Container(
//                             alignment: Alignment.topCenter,
//                             color: const Color.fromARGB(255, 220, 212, 241),
//                             // decoration: const BoxDecoration(
//                             //   shape: BoxShape.circle,
//                             //   color: Color.fromARGB(255, 82, 3, 3),
//                             width: 183,
//                             height: 80,
//                           )
//                         ],
//                       )

//                       //  alignment: Alignment.center,
//                       ),

//                   //SizedBox( h and w),
//                 ]),
// //////col 2//////
//             ///
//             ///
//               Column(
//                 // verticalDirection: VerticalDirection.down,
//                 // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 // crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                       alignment: Alignment.bottomCenter,
//                       color: const Color.fromARGB(255, 70, 14, 224),

//                       // decoration: const BoxDecoration(
//                       //   shape: BoxShape.circle,
//                       //   color: Color.fromARGB(255, 82, 3, 3),
//                       width: 183,
//                       height: 260,
//                       child: Column(
//                         children: [
//                           Container(
//                             alignment: Alignment.bottomCenter,
//                             // color: const Color.fromARGB(255, 103, 90, 139),
//                             child: Image.asset('images/omr.jpg'),
//                             // decoration: const BoxDecoration(
//                             //   shape: BoxShape.circle,
//                             //   color: Color.fromARGB(255, 82, 3, 3),
//                             width: 183,
//                             height: 180,
//                           ),
//                           Container(
//                             alignment: Alignment.topCenter,
//                             color: const Color.fromARGB(255, 220, 212, 241),
//                             // decoration: const BoxDecoration(
//                             //   shape: BoxShape.circle,
//                             //   color: Color.fromARGB(255, 82, 3, 3),
//                             width: 183,
//                             height: 80,
//                           )
//                         ],
//                       )

//                       //  alignment: Alignment.center,
//                       ),

//                   //SizedBox( h and w),
//                 ]),
// //////col 2//////
//             ///
//             ///

//           ],
//         )

// ][[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[

// Container(
//         color: const Color.fromARGB(255, 34, 34, 34),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Container(
//                 width: 62,
//                 height: 62,
//                 margin: EdgeInsets.all(0),
//                 padding: EdgeInsets.all(0),
//                 color: Colors.red,
//                 child: Stack(children: [
//                  Container(

//                   padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
//                       child:  IconButton(
//                       iconSize: 30,
//                       padding: EdgeInsets.all(2),
//                       onPressed: () {},
//                       icon: Icon(Icons.favorite),
//                       style: MenuItemButton.styleFrom(
//                           backgroundColor: Colors.transparent,
//                           iconColor: iconColo1r,
//                           shadowColor: Colors.transparent))),
//                   Container(
//                       padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
//                       child: Text(
//                         'aa',
//                         style: TextStyle(fontSize: 10, color: Colors.white),
//                       ))
//                 ])),
//             IconButton(
//                 onPressed: () {
//                   setState(() {
//                     iconColo1r = Color.fromARGB(255, 255, 253, 253);
//                   });
//                 },
//                 icon: Icon(Icons.new_releases_outlined),
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.transparent,
//                     iconColor: iconColo2r,
//                     shadowColor: Colors.transparent)),
//             IconButton(
//                 onPressed: () {},
//                 icon: Icon(Icons.star),
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.transparent,
//                     iconColor: iconColo3r,
//                     shadowColor: Colors.transparent)),
//             IconButton(
//                 onPressed: () {},
//                 icon: Icon(Icons.local_fire_department_outlined),
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.transparent,
//                     iconColor: iconColo4r,
//                     shadowColor: Colors.transparent)),
//           ],
//         ),
//       ),
// //////////////////
// Container(
//             margin: EdgeInsets.fromLTRB(20, 120, 0, 0),
//             height: 190,
//             width: 140,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                     color:
//                         const Color.fromARGB(255, 70, 70, 70).withOpacity(0.5),
//                     spreadRadius: 1,
//                     blurRadius: 5,
//                     offset: Offset(0, 0),
//                     blurStyle: BlurStyle.outer),
//               ],
//               image: DecorationImage(
//                 image: AssetImage(img[a]),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),

// /////////////////////

//  Container(
//                         margin: EdgeInsets.fromLTRB(20, 120, 0, 0),
//                         height: 190,
//                         width: 140,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: const Color.fromARGB(255, 70, 70, 70)
//                                   .withOpacity(0.5),
//                               spreadRadius: 1,
//                               offset: Offset(0, 0),
//                             ),
//                           ],
//                           image: DecorationImage(
//                             image: AssetImage(img[a]),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),

// Stack(
//                     children: [
//                       Stack(
//                       children: [

//                       Container(
//                         height: 200,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             image: DecorationImage(
//                               image: AssetImage(
//                                 img[index],
//                               ),
//                               fit: BoxFit.cover,
//                             )),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Container(
//                               alignment: Alignment.centerLeft,
//                               margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
//                               height: 170,
//                               width: 90,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 boxShadow: [
//                                   BoxShadow(
//                                       color:
//                                           const Color.fromARGB(255, 53, 51, 51)
//                                               .withOpacity(0.8),
//                                       spreadRadius: 0,
//                                       blurRadius: 20,
//                                       offset: Offset(0, 0),
//                                       blurStyle: BlurStyle.outer),
//                                 ],
//                                 image: DecorationImage(
//                                   image: AssetImage(img[index]),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

// Container(
//                           child: BackdropFilter(
//                         filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
//                         child: Container(
//                           color: Colors.black.withOpacity(0),
//                         ),
//                       )),
//                       // Container(
//                       //   margin: EdgeInsets.fromLTRB(20, 120, 0, 0),
//                       //   height: 190,
//                       //   width: 140,
//                       //   decoration: BoxDecoration(
//                       //     borderRadius: BorderRadius.circular(20),
//                       //     boxShadow: [
//                       //       BoxShadow(
//                       //         color: const Color.fromARGB(255, 70, 70, 70)
//                       //             .withOpacity(0.5),
//                       //         spreadRadius: 1,
//                       //         offset: Offset(0, 0),
//                       //       ),
//                       //     ],
//                       //     image: DecorationImage(
//                       //       image: AssetImage(img[a]),
//                       //       fit: BoxFit.cover,
//                       //     ),
//                       //   ),
//                       // ),
//                   ])],
//                   );

// // Stack(
// //                     children: [
// //                       Stack(
// //                       children: [

// //                       Container(
// //                         height: 200,
// //                         decoration: BoxDecoration(
// //                             borderRadius: BorderRadius.circular(8),
// //                             image: DecorationImage(
// //                               image: AssetImage(
// //                                 img[index],
// //                               ),
// //                               fit: BoxFit.cover,
// //                             )),
// //                         child: Row(
// //                           mainAxisAlignment: MainAxisAlignment.start,
// //                           children: [
// //                             Container(
// //                               alignment: Alignment.centerLeft,
// //                               margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
// //                               height: 170,
// //                               width: 90,
// //                               decoration: BoxDecoration(
// //                                 borderRadius: BorderRadius.circular(20),
// //                                 boxShadow: [
// //                                   BoxShadow(
// //                                       color:
// //                                           const Color.fromARGB(255, 53, 51, 51)
// //                                               .withOpacity(0.8),
// //                                       spreadRadius: 0,
// //                                       blurRadius: 20,
// //                                       offset: Offset(0, 0),
// //                                       blurStyle: BlurStyle.outer),
// //                                 ],
// //                                 image: DecorationImage(
// //                                   image: AssetImage(img[index]),
// //                                   fit: BoxFit.cover,
// //                                 ),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),

// // Container(
// //                           child: BackdropFilter(
// //                         filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
// //                         child: Container(
// //                           color: Colors.black.withOpacity(0),
// //                         ),
// //                       )),
// //                       // Container(
// //                       //   margin: EdgeInsets.fromLTRB(20, 120, 0, 0),
// //                       //   height: 190,
// //                       //   width: 140,
// //                       //   decoration: BoxDecoration(
// //                       //     borderRadius: BorderRadius.circular(20),
// //                       //     boxShadow: [
// //                       //       BoxShadow(
// //                       //         color: const Color.fromARGB(255, 70, 70, 70)
// //                       //             .withOpacity(0.5),
// //                       //         spreadRadius: 1,
// //                       //         offset: Offset(0, 0),
// //                       //       ),
// //                       //     ],
// //                       //     image: DecorationImage(
// //                       //       image: AssetImage(img[a]),
// //                       //       fit: BoxFit.cover,
// //                       //     ),
// //                       //   ),
// //                       // ),
// //                   ])],
// //                   );

// // // Container(
// // //                           child: BackdropFilter(
// // //                         filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
// // //                         child: Container(
// // //                           color: Colors.black.withOpacity(0),
// // //                         ),
// // //                       )),
// //                       // Container(
// //                       //   margin: EdgeInsets.fromLTRB(20, 120, 0, 0),
// //                       //   height: 190,
// //                       //   width: 140,
// //                       //   decoration: BoxDecoration(
// //                       //     borderRadius: BorderRadius.circular(20),
// //                       //     boxShadow: [
// //                       //       BoxShadow(
// //                       //         color: const Color.fromARGB(255, 70, 70, 70)
// //                       //             .withOpacity(0.5),
// //                       //         spreadRadius: 1,
// //                       //         offset: Offset(0, 0),
// //                       //       ),
// //                       //     ],
// //                       //     image: DecorationImage(
// //                       //       image: AssetImage(img[a]),
// //                       //       fit: BoxFit.cover,
// //                       //     ),
// //                       //   ),
// //                       // ),
