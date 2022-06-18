import 'package:aawani/screens/addPost/PostUrl.dart';
import 'package:aawani/screens/home/MyHomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart' as osm;
import 'package:geolocator/geolocator.dart';

class MapsCard extends StatefulWidget {
  MapsCard({Key? key}) : super(key: key);

  @override
  State<MapsCard> createState() => _MapsCardState();
}

class _MapsCardState extends State<MapsCard> {
  Position? cl = Position(
      latitude: 36.752871,
      longitude: 3.040785,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0);

  final fposition = GlobalKey<FormState>();

  getPostion(BuildContext context) async {
    bool sercives = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();

    if (sercives == false) {
      showDialog(
          context: context,
          builder: (context) => Dialog(
                  child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shrinkWrap: true,
                      children: [
                    ListTile(
                      leading: Icon(
                        Icons.location_off_outlined,
                        color: Colors.blueAccent,
                      ),
                      title: Text(
                        "Location Services may not enable ",
                        style:
                            TextStyle(color: Color.fromARGB(172, 244, 67, 54)),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ])));
    } else {
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      } else {
        return getLatAndLang();
      }
    }
  }

  getLatAndLang() async {
    return await Geolocator.getCurrentPosition().then((value) {
      setState(() {
        cl = value;
      });
    });
  }

  osm.MapController? controller;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    controller = osm.MapController(
      initMapWithUserPosition: false,
      initPosition: osm.GeoPoint(latitude: 36.7538, longitude: 3.0588),
      areaLimit: osm.BoundingBox(
        east: 10.4922941,
        north: 47.8084648,
        south: 45.817995,
        west: 5.9559113,
      ),
    );
    getMarckers();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  post() async {
    await getPostion(context);

    osm.GeoPoint p =
        osm.GeoPoint(latitude: cl!.latitude, longitude: cl!.longitude);
    controller!.changeLocation(p);
    controller!.setZoom(zoomLevel: 12.0);
  }

  getMarckers() async {
    final snap = await FirebaseFirestore.instance.collection("posts").get();
    final docs = snap.docs;
    String iconData;
    bool food;
    Color? color;
    bool drugs;
    bool clothes;
    bool money;
    bool others;
    bool physical;
    double lat, long;
    osm.GeoPoint p;
    for (var post in docs) {
      bool food = post.data()['category']['food'];

      drugs = post.data()['category']['drugs'];
      clothes = post.data()['category']['clothes'];
      money = post.data()['category']['money'];
      others = post.data()['category']['others'];
      physical = post.data()['category']['physical'];
      if (food) {
        iconData = 'lib/icons/icons8-hamburger-96(-xxxhdpi).png';
        color = Colors.orange;
      } else if (drugs) {
        iconData = 'lib/icons/icons8-drugs-64.png';
        color = Colors.red;
      } else if (clothes) {
        iconData = 'lib/icons/icons8-clothes-64.png';
        color = Colors.blue;
      } else if (money) {
        iconData = 'lib/icons/icons8-money-96(-xxxhdpi).png';
        color = Colors.green;
      } else if (physical) {
        iconData = 'lib/icons/icons8-categorize-48.png';
        color = null;
      } else {
        iconData = 'lib/icons/icons8-teenager-male-100.png';
        color = Colors.grey;
      }

      lat = post.data()['lat'];
      long = post.data()['long'];
      p = osm.GeoPoint(latitude: lat, longitude: long);

      await controller!.addMarker(
        p,
        markerIcon: osm.MarkerIcon(
          assetMarker:
              osm.AssetMarker(image: AssetImage(iconData), color: color),
        ),
      );
    }
    setState(() {
      isLoading = false;
    });

    // snap.docs.forEach((element) async {
    //   print("456789132465");
    //   print(element.data()['postID']);
    //   // markers.add(osm.StaticPositionGeoPoint(
    //   //     element.data()["postID"],
    //   //     osm.MarkerIcon(
    //   //         icon: Icon(
    //   //       Icons.location_on,
    //   //       color: Colors.green,
    //   //       size: 100,
    //   //     )),
    //   //     [
    //   // osm.GeoPoint(
    //   //     latitude: element.data()['lat'],
    //   //     longitude: element.data()['long'])
    //   //     ]));
    //   double lat = element.data()['lat'];
    //   double long = element.data()['long'];

    //   if (element.data()['category']['food']) {
    //     await controller!.addMarker(
    //         osm.GeoPoint(
    //           latitude: lat,
    //           longitude: long,
    //         ),
    //         markerIcon: osm.MarkerIcon(
    //             assetMarker: osm.AssetMarker(
    //                 image: AssetImage(
    //                     "lib/icons/icons8-hamburger-96(-xxxhdpi).png"),
    //                 color: Colors.orange)));
    //   } else if (element.data()['category']['clothers']) {
    //     await controller!.addMarker(
    //         osm.GeoPoint(
    //           latitude: lat,
    //           longitude: long,
    //         ),
    //         markerIcon: osm.MarkerIcon(
    //             assetMarker: osm.AssetMarker(
    //                 image: AssetImage(""),
    //                 color: Colors.blue)));
    //   } else if (element.data()['category']['drugs']) {
    //     await controller!.addMarker(
    //         osm.GeoPoint(
    //           latitude: lat,
    //           longitude: long,
    //         ),
    //         markerIcon: osm.MarkerIcon(
    //             assetMarker: osm.AssetMarker(
    //                 image: AssetImage(""),
    //                 color: Colors.red)));
    //   } else if (element.data()['category']['money']) {
    //     await controller!.addMarker(
    //         osm.GeoPoint(
    //           latitude: lat,
    //           longitude: long,
    //         ),
    //         markerIcon: osm.MarkerIcon(
    //             assetMarker: osm.AssetMarker(
    //                 image:
    //                     AssetImage(""),
    //                 color: Colors.green)));
    //   } else if (element.data()['category']['others']) {
    //     await controller!.addMarker(
    //         osm.GeoPoint(
    //           latitude: lat,
    //           longitude: long,
    //         ),
    //         markerIcon: osm.MarkerIcon(
    //             assetMarker: osm.AssetMarker(
    //                 image: AssetImage(""))));
    //   } else {
    //     await controller!.addMarker(
    //         osm.GeoPoint(
    //           latitude: lat,
    //           longitude: long,
    //         ),
    //         markerIcon: osm.MarkerIcon(
    //             assetMarker: osm.AssetMarker(
    //                 image: AssetImage(""),
    //                 color: Colors.grey)));
    //   }
    // });
    // setState(() {
    //   isLoading = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.green,
              child: Icon(Icons.my_location_outlined, color: Colors.white),
              onPressed: () async {
                await post();
              },
            ),
            body: isLoading
                ? CircularProgressIndicator()
                : osm.OSMFlutter(
                    onGeoPointClicked: (p) async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: CircularProgressIndicator(
                                  color: Colors.green),
                            );
                          });
                      final snap = await FirebaseFirestore.instance
                          .collection('posts')
                          .where('lat', isEqualTo: p.latitude)
                          .where('long', isEqualTo: p.longitude)
                          .get();
                      String postId = "";
                      final l = snap.docs.length;
                      for (var i = 0; i < l; i++) {
                        final snapshot = await FirebaseFirestore.instance
                            .collection('posts')
                            .where('lat', isEqualTo: p.latitude)
                            .where('long', isEqualTo: p.longitude)
                            .snapshots();
                        snapshot.forEach((element) {
                          element.docs.forEach((element) {
                            postId = element.data()['postID'];
                            print(' yazid ' + postId);
                          });
                        });
                        print("going");
                        MaterialPageRoute(
                            builder: (context) => PostUrl(
                                  postId: postId.toString(),
                                ));
                        print("finished ! ");

                        // print(snapshot.data!.docs[i].data()['postID']);
                      }
                    },
                    mapIsLoading: Center(
                      child: CircularProgressIndicator(),
                    ),
                    controller: controller!,
                    trackMyPosition: false,
                    initZoom: 5,
                    minZoomLevel: 8,
                    maxZoomLevel: 14,
                    stepZoom: 1.0,
                    userLocationMarker: osm.UserLocationMaker(
                      personMarker: osm.MarkerIcon(
                        icon: Icon(
                          Icons.location_history_rounded,
                          color: Colors.red,
                          size: 48,
                        ),
                      ),
                      directionArrowMarker: osm.MarkerIcon(
                        icon: Icon(
                          Icons.double_arrow,
                          size: 48,
                        ),
                      ),
                    ),
                    roadConfiguration: osm.RoadConfiguration(
                      startIcon: osm.MarkerIcon(
                        icon: Icon(
                          Icons.person,
                          size: 64,
                          color: Colors.brown,
                        ),
                      ),
                      roadColor: Colors.yellowAccent,
                    ),
                    markerOption: osm.MarkerOption(
                        defaultMarker: osm.MarkerIcon(
                      icon: Icon(
                        Icons.person_pin_circle,
                        color: Colors.green,
                        size: 120,
                      ),
                    )),
                  )));
  }
}
